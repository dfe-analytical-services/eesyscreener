# Duckplyr Fallback Fixes

## Overview

`duckplyr` replaces dplyr generics with DuckDB-backed implementations. When it
can't translate an operation to DuckDB SQL, it emits an `rlang_message` and
falls back to plain dplyr. There are two severity levels:

- **"Error processing"** — the message has an error as its parent condition.
  `expect_no_error()` in testthat 3.3.2 traverses the parent chain and treats
  this as a test failure.
- **"Cannot process"** — informational only, no error parent. Does not fail
  `expect_no_error()` but still represents unhandled fallback behaviour.

The goal was to eliminate **all** duckplyr fallbacks so that no silent
degradation occurs.

---

## Root Causes and Fixes

### 1. `R/screen_dfs.R` — methods not restored on exit

**Problem**: `screen_dfs()` calls `duckplyr::methods_overwrite()` partway
through execution (before the geography checks) but never restored on exit.
This left duckplyr methods active for subsequent test files (alphabetically
later), contaminating their results.

**Fix**: Added an `on.exit` guard and an immediate restore call just before the
metadata-only checks:

```r
on.exit(suppressMessages(duckplyr::methods_restore()), add = TRUE)
suppressMessages(duckplyr::methods_restore())
```

The immediate `methods_restore()` ensures metadata checks run with plain dplyr.
The `on.exit` ensures methods are always restored even if `screen_dfs()` errors
or returns early.

---

### 2. `R/utils.R` — `dplyr::mutate(stage = stage)` with bare symbol RHS

**Problem**: In `run_and_log_check()`, a local character variable `stage` was
used as the RHS of a `mutate()`. With duckplyr active, its NSE translator calls
`expr[[1]][[1]]` to check for `pkg::fn`-style calls. A bare symbol is not
subsettable — error: "object of type 'symbol' is not subsettable".

**Fix**: Replaced with base R column assignment, which bypasses duckplyr
entirely:

```r
check_results[["stage"]] <- stage
all_results <- rbind(all_results, check_results)
```

---

### 3. `R/check_api_dict_col_names.R` — `spec_tbl_df` and `.data$col` in `arrange()`

**Problem 1**: `eesyscreener::data_dictionary` is class `spec_tbl_df` (a readr
tibble subclass). duckplyr rejects it: "Must pass a plain data frame or a
tibble, not a `<spec_tbl_df>` object".

**Fix 1**: Wrap with `tibble::as_tibble()` at the start of the pipeline.

**Problem 2**: `dplyr::arrange(.data$col_type, .data$col_name)` after
`pivot_longer`. `.data$col_type` parses as `` `$`(.data, col_type) `` — the
`` `$` `` operator is a bare symbol, triggering the same "not subsettable"
failure.

**Fix 2**: Removed the `arrange()` call entirely (it was purely cosmetic).

---

### 4. `R/check_ind_invalid_entry.R` — factor column from `utils::stack()`

**Problem**: `utils::stack()` produces a `data.frame` with a **factor** `ind`
column. duckplyr cannot create a relation from factor columns, causing a
fallback when the result was filtered with `dplyr::filter()`.

**Fix**: Replaced the dplyr chain with base R:

```r
invalid_indicators <- as.character(pre_result$ind[pre_result$values == "FAIL"])
```

---

### 5. `R/check_filter_group_level.R` — named integer vector from `vapply()` in `mutate()`

**Problem**: `vapply()` always names its output after the input elements. So
`vapply(filters_and_groups$col_name, count_distinct, integer(1))` returns a
**named** integer vector (e.g. `c(filter_col = 5)`). With duckplyr active, two
things broke:

- Multi-element named vector passed to `dplyr::mutate()` → duckplyr calls
  `relexpr_constant()` on the whole vector → error: "length(val) == 1 is not
  TRUE"
- Length-1 named vector → passes the length check but then hits: "Can't convert
  named vectors to relational. Affected column: `filter_levels`"

Additionally, `filters_and_groups` (derived from `meta` with
`methods_overwrite()` active) is a duckplyr lazy tibble, so even the subsequent
`dplyr::filter()` on the mutated result triggered another fallback.

**Fix**: Three changes together:

```r
# 1. Materialise to a plain data frame immediately
filters_and_groups <- meta |>
  dplyr::filter(...) |>
  dplyr::select(...) |>
  as.data.frame()

# 2. Strip names from vapply output
filter_levels <- unname(vapply(filters_and_groups$col_name, count_distinct, integer(1)))
group_levels  <- unname(vapply(filters_and_groups$filter_grouping_column, count_distinct, integer(1)))

# 3. Use base R column assignment and subsetting instead of dplyr mutate/filter
filters_and_groups[["filter_levels"]] <- filter_levels
filters_and_groups[["group_levels"]]  <- group_levels
filters_and_groups[["pre_result"]]    <- ifelse(filter_levels >= group_levels, "PASS", "FAIL")
failed_pairs <- filters_and_groups[filters_and_groups[["pre_result"]] == "FAIL", ]
```

---

### 6. `R/check_geog_other_dupes.R` — `.data$col` in `count()` cascading into `group_by()`

**Problem**: `dplyr::count(.data$name, name = "n")` — duckplyr's `count()`
cannot translate the `.data$col` pronoun style in `...`. This caused a
"Cannot process" fallback, which then cascaded: dplyr's internal implementation
of `count()` calls `group_by()` and `ungroup()`, which duckplyr intercepted and
also fell back on, producing a second "Cannot process" message.

**Fix**: Use `!!rlang::sym()` — the established pattern in this codebase for
duckplyr-safe column references. Pre-create symbols for the renamed columns and
use `!!` in `distinct()` and `count()`:

```r
name_sym <- rlang::sym("name")
code_sym <- rlang::sym("code")

dupe_rows <- data_tmp |>
  dplyr::distinct(!!name_sym, !!code_sym) |>
  dplyr::count(!!name_sym) |>
  dplyr::filter(.data$n > 1) |>
  dplyr::collect()
```

Using bare symbols (e.g. `count(name)`) would also fix the duckplyr issue but
triggers R CMD check "no visible binding for global variable" NOTEs. The
`!!rlang::sym()` approach avoids both problems.

---

## General Patterns That Cause Duckplyr Fallbacks

| Pattern | Error / symptom |
|---|---|
| `dplyr::mutate(col = local_var)` bare symbol RHS | "object of type 'symbol' is not subsettable" |
| `dplyr::arrange(.data$col)` | same bare-symbol error via `` `$` `` operator |
| `dplyr::count(.data$col)` | "Cannot process: `count()` requires columns in `...`"; cascades into `group_by()` fallback |
| `spec_tbl_df` without `tibble::as_tibble()` conversion | "Must pass a plain data frame or a tibble" |
| `utils::stack()` output passed to dplyr verbs | factor columns — duckplyr can't build a relation |
| `vapply()` result used directly in `dplyr::mutate()` | named/multi-element vector → "length(val) == 1 is not TRUE" or "Can't convert named vectors" |

---

## Patterns That Work Fine With Duckplyr

- `dplyr::filter(!!col_sym == value)` — bang-bang with `rlang::sym()` is fine
- `dplyr::filter(.data$col == value)` — `.data$` in `filter()` works (the issue
  is specific to `arrange()` and `count()`)
- `dplyr::distinct(!!!syms_vec)` — spliced symbols work
- `dplyr::select("quoted_col_name")` — string selectors work
- `dplyr::count(!!rlang::sym("col"))` — bang-bang in `count()` works

---

## Test Verification

All fallbacks eliminated. Final state:

```
devtools::test(filter='screen_dfs')    → [ FAIL 0 | WARN 0 | SKIP 0 | PASS 7 ]
devtools::test(filter='ees-robot')     → [ FAIL 0 | WARN 0 | SKIP 0 | PASS 28 ]
devtools::check(args='--no-tests')     → no "no visible binding" NOTEs from modified files
```

---

## Key Debugging Technique

When diagnosing which operation causes a fallback:

1. Use `pkgload::load_all("C:/code_projects/eesyscreener", quiet=TRUE)` to load
   the source (not installed) package
2. Call `duckplyr::methods_overwrite()` to activate duckplyr globally
3. Wrap `screen_csv()` (or individual check functions) with
   `withCallingHandlers(..., rlang_message = function(m) { ... })` to intercept
   fallback messages and inspect `sys.calls()` for the originating function
4. Isolate by running individual check functions; the step that triggers a
   condition with an error parent is the culprit

Use temporary `.R` files (`cat > /tmp/script.R`) rather than complex
`Rscript -e "..."` invocations to avoid shell escaping issues with multi-line
code.
