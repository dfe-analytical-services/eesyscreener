# Diagnosing duckplyr fallbacks

This article is aimed at contributors. It collects what we have learned
about duckplyr’s dplyr-fallback behaviour, the patterns that trigger it
in this codebase, and how to diagnose a new one when it appears.

eesyscreener leans heavily on
[duckplyr](https://duckplyr.tidyverse.org/) so that the large-file code
paths stay responsive for the Shiny app and the screening API. When
duckplyr cannot translate an operation into DuckDB SQL, it falls back to
plain dplyr. That is correct behaviour — but silent fallbacks undo the
performance work, so we want to catch and fix them.

## The fallback messages

duckplyr is verbose and will tell you when it is falling back to dplyr,
often with messages like:

> The duckplyr package is configured to fall back to dplyr when it
> encounters an incompatibility. Fallback events can be collected and
> uploaded for analysis to guide future development. i Automatic
> fallback uploading is not controlled and therefore disabled, see
> `?duckplyr::fallback()`. v Number of reports ready for upload: 1.

These are safe to ignore while you are working. To investigate where a
fallback happened, use
[`duckplyr::fallback_review()`](https://duckplyr.tidyverse.org/reference/fallback.html).
Uploading with
[`duckplyr::fallback_upload()`](https://duckplyr.tidyverse.org/reference/fallback.html)
clears the reports from your machine and submits them to the
maintainers. To auto-upload (and silence the message) use
`duckplyr::fallback_config(autoupload = TRUE)`.

## Severity levels

`duckplyr` replaces dplyr generics with DuckDB-backed implementations.
When it can’t translate an operation, it emits an `rlang_message` and
falls back. Two severity levels:

- **“Error processing”** — the message has an error as its parent
  condition. `expect_no_error()` in testthat 3.3.2 traverses the parent
  chain and treats this as a test failure.
- **“Cannot process”** — informational only, no error parent. Does not
  fail `expect_no_error()` but still represents unhandled fallback
  behaviour.

These fallbacks aren’t critical to fix if everything else is passing and
it’s not causing materialisation in a problematic way (as would be
caught by `test-avoid_materialisation.R`). It’s still good practice to
clean them up.

Note: `lintr::lint_package()` can conflict with some of the workarounds,
so re-lint after each change.

## Common patterns that cause fallbacks

| Pattern                                                                                                                                         | Error / symptom                                                                              |
|-------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------|
| `dplyr::mutate(col = local_var)` bare symbol RHS                                                                                                | “object of type ‘symbol’ is not subsettable”                                                 |
| `dplyr::arrange(.data$col)`                                                                                                                     | same bare-symbol error via `` `$` `` operator                                                |
| `dplyr::count(.data$col)`                                                                                                                       | “Cannot process: `count()` requires columns in `...`”; cascades into `group_by()` fallback   |
| `spec_tbl_df` without [`tibble::as_tibble()`](https://tibble.tidyverse.org/reference/as_tibble.html) conversion                                 | “Must pass a plain data frame or a tibble”                                                   |
| [`utils::stack()`](https://rdrr.io/r/utils/stack.html) output passed to dplyr verbs                                                             | factor columns — duckplyr can’t build a relation                                             |
| [`vapply()`](https://rdrr.io/r/base/lapply.html) result used directly in [`dplyr::mutate()`](https://dplyr.tidyverse.org/reference/mutate.html) | named/multi-element vector → “length(val) == 1 is not TRUE” or “Can’t convert named vectors” |

## Patterns that work fine with duckplyr

- `dplyr::filter(!!col_sym == value)` — bang-bang with
  [`rlang::sym()`](https://rlang.r-lib.org/reference/sym.html) is fine
- `dplyr::filter(.data$col == value)` — `.data$` in
  [`filter()`](https://rdrr.io/r/stats/filter.html) works (the issue is
  specific to `arrange()` and `count()`)
- `dplyr::distinct(!!!syms_vec)` — spliced symbols work
- `dplyr::select("quoted_col_name")` — string selectors work
- `dplyr::count(!!rlang::sym("col"))` — bang-bang in `count()` works

## Diagnosing interactively

1.  `pkgload::load_all(".", quiet = TRUE)` to load the source package
2.  [`duckplyr::methods_overwrite()`](https://duckplyr.tidyverse.org/reference/methods_overwrite.html)
    to activate duckplyr globally
3.  Wrap
    [`screen_dfs()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_dfs.md)
    or the suspect check function with
    `withCallingHandlers(..., rlang_message = function(m) { ... })` to
    intercept fallback messages and inspect
    [`sys.calls()`](https://rdrr.io/r/base/sys.parent.html) for the
    originating line
4.  Isolate by running individual check functions directly
5.  [`duckplyr::methods_restore()`](https://duckplyr.tidyverse.org/reference/methods_overwrite.html)
    if you want to reset to dplyr when done

## Catching silent materialisation

Fallbacks are one way to lose the DuckDB fast path. Inadvertently
materialising the whole data frame is another. To catch this, run with
`prudence = "stingy"`:

- `screen_dfs(<data>, <meta>, prudence = "stingy")`
- If the lazy table is materialised, an error will be thrown. Identify
  the guilty line with
  [`rlang::last_trace()`](https://rlang.r-lib.org/reference/last_error.html).

`test-avoid_materialisation.R` exercises this in CI.
