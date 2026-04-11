# Migration Context Pack

Reference document for migrating legacy R Shiny checks from
[dfe-published-data-qa](https://github.com/dfe-analytical-services/dfe-published-data-qa/)
into the `eesyscreener` R package.

------------------------------------------------------------------------

## 1. Migration Principles

### What the migration is

Functions from a monolithic Shiny app (`dfe-published-data-qa`) are
being extracted one-at-a-time into a standalone, documented, tested R
package (`eesyscreener`). The legacy code lives primarily in
`R/mainTests.r`, `R/preCheck1.r`, `R/preCheck2.r`, and
`R/knownVariables.r` in the Shiny app repo.

### Why

- **Reusability**: The package is consumed in at least three contexts: a
  Shiny app, a Plumber API, and direct R usage by analysts.
- **Performance**: The Shiny app and API must be responsive even with
  files of 5+ million rows. DuckDB/duckplyr is used for speed.
- **Maintainability**: One function per file, one test file per
  function, consistent interfaces, roxygen2 documentation.

### Core philosophy

- One check at a time, unless a utility function covers multiple checks.
- Minimise new dependencies; prefer base R or dplyr (which piggybacks on
  duckplyr for performance).
- Simplify during migration, do not bring over legacy complexity if it
  is unnecessary, use the opportunity to improve the code.
- Strip out any HTML tags from the message strings returned, they are no
  longer required.
- Speed is king. Prioritise large-file performance over small-file
  performance. Avoid operations that force full materialisation of lazy
  duckplyr data frames.

------------------------------------------------------------------------

## 2. Coding Conventions

### 2.1 Naming

| Entity                              | Convention                                                   | Examples                                                                                                                                                                                                                                                                                                         |
|-------------------------------------|--------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Exported check functions            | `check_<area>_<what>()`                                      | [`check_meta_dupe_label()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_dupe_label.md), [`check_filter_defaults()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_filter_defaults.md)                                                                   |
| Exported precheck functions         | `precheck_<area>_<what>()`                                   | [`precheck_col_req_data()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_col_req_data.md), [`precheck_geog_level()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_geog_level.md)                                                                       |
| Exported screen functions           | `screen_<scope>()`                                           | [`screen_csv()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_csv.md), [`screen_dfs()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_dfs.md), [`screen_filenames()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_filenames.md) |
| Internal argument validators        | `validate_arg_<what>()`                                      | `validate_arg_filenames()`, `validate_arg_dfs()`                                                                                                                                                                                                                                                                 |
| Internal helpers                    | Descriptive snake_case                                       | `test_output()`, `null_filename()`, `get_check_name()`                                                                                                                                                                                                                                                           |
| Test name passed to `test_output()` | Short snake_case identifier (no `check_`/`precheck_` prefix) | `"meta_dupe_label"`, `"col_req_meta"`, `"geog_level"`                                                                                                                                                                                                                                                            |
| File names                          | Match function name exactly                                  | `R/check_meta_dupe_label.R`                                                                                                                                                                                                                                                                                      |
| Test file names                     | `test-<function_name>.R`                                     | `tests/testthat/test-check_meta_dupe_label.R`                                                                                                                                                                                                                                                                    |
| Reference data objects              | Descriptive snake_case                                       | `req_meta_cols`, `acceptable_time_ids`, `geography_df`                                                                                                                                                                                                                                                           |

**Important**: - Check names in `_pkgdown.yml` must align with the
naming convention. All individual checks should be named in accordance
with the groupings defined there. - Use standard abbreviations for
brevity (e.g., `dupe` for duplicate, `fil_grp` for filter_group, `ind`
for indicator) — see CONTRIBUTING.md for the full list of abbreviations
used in this codebase.

### 2.2 File Structure

    R/
      check_<area>_<what>.R       # One exported function per file
      precheck_<area>_<what>.R    # One exported function per file
      screen_*.R                  # Orchestrator functions
      utils.R                     # ALL internal/helper functions
      reference_values.R          # Documentation for exported data objects
      example_datasets.R          # Documentation for example data
      eesyscreener-package.R      # Package-level documentation

    tests/
      testthat.R                  # Standard testthat bootstrap
      testthat/
        test-<function_name>.R    # One test file per function
      utils/
        copy_check_data.R         # Script to copy CSV test data from legacy repo
        benchmarking.R            # Benchmarking utilities

    data-raw/                     # Source scripts for .rda files
    data/                         # Compiled .rda reference data

### 2.3 Function Signatures

Every `check_*()` and `precheck_*()` function follows a consistent
signature pattern:

``` r
check_something <- function(
  data,            # and/or meta, or other primary input
  verbose = FALSE,
  stop_on_error = FALSE
)
```

- `verbose` (logical): If TRUE, prints feedback messages via `cli`.
- `stop_on_error` (logical): If TRUE, aborts on FAIL, warns on WARNING.
- Some functions only take `meta`, some take `data`, some take both
  `data` and `meta`.
- Some functions have additional specific parameters (e.g.,
  `custom_name` in
  [`check_filename_spaces()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_filename_spaces.md)).

**Argument order is mandatory**: `data`/`meta` first, then
`verbose = FALSE`, then `stop_on_error = FALSE`, then any
function-specific optional parameters. This fixed order allows
[`screen_dfs()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_dfs.md)
to call all checks with positional arguments for the common parameters
(e.g., `check_foo(data, meta, vb, soe)`). Function-specific parameters
must always be passed by name at the call site.

**Critical rule**: Do NOT validate arguments inside individual
`precheck_*()` or `check_*()` functions. Argument validation happens
only in the `screen_*()` orchestrators via `validate_arg_*()` helpers.

### 2.4 Return Values

Every check function returns the result of `test_output()`, which
produces a single-row `data.frame` with columns:

| Column         | Type            | Values                                           |
|----------------|-----------------|--------------------------------------------------|
| `check`        | character       | Short test name (e.g., `"meta_duplicate_label"`) |
| `result`       | character       | `"PASS"`, `"FAIL"`, or `"WARNING"`               |
| `message`      | character       | Human-readable feedback                          |
| `guidance_url` | character or NA | Optional URL to documentation                    |

The `screen_*()` functions aggregate these via
[`rbind()`](https://rdrr.io/r/base/cbind.html) and add a `stage` column.

### 2.5 Message Patterns

Messages follow consistent grammatical patterns:

- **PASS (nothing found)**: `"All labels are unique."`,
  `"No indicators have a filter group specified."`
- **PASS (positive confirmation)**:
  `"The geographic level values are all valid."`
- **FAIL (singular)**:
  `"The following label is duplicated in the metadata file: 'X'."`
- **FAIL (plural)**:
  `"The following labels are duplicated in the metadata file: 'X', 'Y'."`

When failing values are listed, they are formatted with single quotes
and joined with `"', '"`:

``` r
paste0("'", paste0(values, collapse = "', '"), "'.")
```

Many functions handle singular / plural messages separately (different
wording for 1 vs many failures). This is a convention in the codebase.

Use [`cli::pluralize()`](https://cli.r-lib.org/reference/pluralize.html)
or [`sprintf()`](https://rdrr.io/r/base/sprintf.html) to consolidate
singular and plural messages where appropriate to reduce the number of
lines of code necessary.

**Important**: Do not include HTML tags in message strings. Messages are
used across multiple contexts (CLI, API, Shiny) and should be plain text
only.

### 2.6 Dependency Management

- **Prefer dplyr verbs** that work with duckplyr for performance
  (duckplyr is enabled via
  [`duckplyr::methods_overwrite()`](https://duckplyr.tidyverse.org/reference/methods_overwrite.html)
  in
  [`screen_dfs()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_dfs.md)).
- **Use `.data$column_name`** pronoun from rlang when using dplyr in
  package code (avoids “no visible binding” notes). The package imports
  [`rlang::.data`](https://rlang.r-lib.org/reference/dot-data.html).
- **Pipe operator**: Use the base R pipe `|>` (not magrittr `%>%`).
- **Avoid adding new dependencies** unless the performance benefit is
  substantial and proven via benchmarking.
- **dplyr over base R** for data manipulation - it’s faster on large
  files via duckplyr.
- **cli** for user-facing messages
  ([`cli::cli_abort()`](https://cli.r-lib.org/reference/cli_abort.html),
  [`cli::cli_warn()`](https://cli.r-lib.org/reference/cli_abort.html),
  `cli::cli_alert_*`).
- **No data.table** — converting between data.frame and data.table costs
  time.

### 2.7 Error Handling

- Use
  [`cli::cli_abort()`](https://cli.r-lib.org/reference/cli_abort.html)
  for errors (not [`stop()`](https://rdrr.io/r/base/stop.html)).
- Use
  [`cli::cli_warn()`](https://cli.r-lib.org/reference/cli_abort.html)
  for warnings (not [`warning()`](https://rdrr.io/r/base/warning.html)).
- The `test_output()` helper handles the `stop_on_error` logic
  centrally: if `stop_on_error = TRUE`, FAIL results call
  [`cli::cli_abort()`](https://cli.r-lib.org/reference/cli_abort.html)
  and WARNING results call
  [`cli::cli_warn()`](https://cli.r-lib.org/reference/cli_abort.html).
- Argument validation uses
  [`cli::cli_abort()`](https://cli.r-lib.org/reference/cli_abort.html)
  directly in `validate_arg_*()` functions in `utils.R`.

### 2.8 Internal Helper Conventions

- All internal helpers go in `R/utils.R`.
- Mark with `@keywords internal` and `@noRd` (no separate `.Rd` file
  generated).
- Include `@returns` in roxygen2 documentation even for internal
  functions.
- Helper functions should be reusable and avoid duplication between
  check functions.

------------------------------------------------------------------------

## 3. Documentation Conventions

### 3.1 roxygen2 Structure

Every exported function must have:

``` r
#' Title (one line, sentence case)
#'
#' Description paragraph.
#'
#' @param name Description (or use @inheritParams)
#' @inherit check_filename_spaces return
#' @family <group_name>
#' @examples
#' function_name(example_data)
#' function_name(example_data, verbose = TRUE)
#' @export
```

### 3.2 Key Documentation Patterns

| Pattern                                 | Usage                                                     |
|-----------------------------------------|-----------------------------------------------------------|
| `@inheritParams precheck_meta_col_type` | Inherit `meta`, `verbose`, `stop_on_error` params         |
| `@inheritParams precheck_col_to_rows`   | Inherit `data`, `meta`, `verbose`, `stop_on_error` params |
| `@inheritParams check_col_names_spaces` | Inherit `data`, `verbose`, `stop_on_error` params         |
| `@inherit check_filename_spaces return` | Copy return documentation                                 |
| `@family check_meta`                    | Group in pkgdown docs (use the `_pkgdown.yml` categories) |
| `@keywords internal` + `@noRd`          | For internal functions in `utils.R`                       |

**Minimise duplication**: Use `@inheritParams` extensively rather than
redefining parameter descriptions. Find the most appropriate existing
function that already defines the params you need.

### 3.3 Examples

- Every exported function must have at least two examples: one basic
  call, one with `verbose = TRUE`.
- Use the package’s built-in example datasets (`example_data`,
  `example_meta`, `example_filter_group`, etc.).
- Examples must be runnable without external files.

### 3.4 Return Documentation

The canonical return description is inherited from
`check_filename_spaces`:

``` r
#' @return a single row data frame
```

Use `@inherit check_filename_spaces return` rather than rewriting this.

### 3.5 Family Tags

Family tags must correspond to the groupings in `_pkgdown.yml`:

- `@family filename` — filename checks
- `@family precheck_col` — precheck column checks
- `@family precheck_meta` — precheck metadata checks
- `@family check_meta` — metadata checks
- `@family precheck_time` — precheck time checks
- `@family check_time` — time checks
- `@family precheck_geog` — geography prechecks
- `@family check_filter` — filter checks
- `@family check_api` — API-specific checks

------------------------------------------------------------------------

## 4. Testing Conventions

### 4.1 Test File Naming

- One test file per function: `test-<function_name>.R`
- Located in `tests/testthat/`
- The function name in the filename matches the R file name exactly

### 4.2 Test Structure

Tests use `testthat` edition 3. Each test file contains multiple
`test_that()` blocks covering:

1.  **Happy path (PASS)** — with inline data and with package example
    data
2.  **Failure cases** — one failing value, multiple failing values
3.  **Edge cases** — empty inputs, NAs, blanks, numeric values where
    strings expected
4.  **`stop_on_error` behaviour** — `expect_no_error()` for PASS,
    `expect_error()` for FAIL

### 4.3 Canonical Test Pattern

Prefer building on package example datasets rather than constructing
minimal inline data frames. Use
[`rbind()`](https://rdrr.io/r/base/cbind.html) or
[`dplyr::mutate()`](https://dplyr.tidyverse.org/reference/mutate.html)
to introduce failures on top of the example data. This ensures tests
exercise realistic data shapes and avoids missing columns that real data
has.

``` r
test_that("passes when <condition>", {
  expect_equal(check_something(example_meta)$result, "PASS")
  expect_no_error(check_something(example_meta, stop_on_error = TRUE))
})

test_that("fails with one <problem> (singular message)", {
  bad_meta <- example_meta |>
    rbind(data.frame(col_name = "bad_value", label = "X", ...))
  result <- check_something(bad_meta)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("bad_value", result$message))
  expect_true(grepl("label is", result$message))  # singular form
  expect_error(check_something(bad_meta, stop_on_error = TRUE))
})

test_that("fails with multiple <problems> (plural message)", {
  bad_meta <- example_meta |>
    rbind(data.frame(col_name = c("bad_1", "bad_2"), label = c("X", "Y"), ...))
  result <- check_something(bad_meta)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("bad_1", result$message))
  expect_true(grepl("bad_2", result$message))
  expect_true(grepl("labels are", result$message))  # plural form
  expect_error(check_something(bad_meta, stop_on_error = TRUE))
})
```

Only use a fully inline
[`data.frame()`](https://rdrr.io/r/base/data.frame.html) when the test
genuinely requires a schema that doesn’t exist in any example dataset,
or when testing a very specific edge case that would be awkward to
construct from an example base.

### 4.4 Test Data

- **Package example datasets** (`example_data`, `example_meta`,
  `example_filter_group_wrow`, etc. — see `R/example_datasets.R`) are
  the **preferred base** for test data. Use
  [`rbind()`](https://rdrr.io/r/base/cbind.html) or
  [`dplyr::mutate()`](https://dplyr.tidyverse.org/reference/mutate.html)
  to introduce the failing condition on top of them.
- **Inline [`data.frame()`](https://rdrr.io/r/base/data.frame.html)
  construction** is acceptable only when the test requires a schema that
  no example dataset provides, or when an edge case is too awkward to
  build from example data.
- **Package example datasets must always be tested as a PASS case** via
  `expect_no_error(fn(example_data, stop_on_error = TRUE))`.
- **Temp CSV files** when testing file I/O (e.g., `screen_csv` tests).
- **No mocking** — use real but minimal data.

### 4.5 What to Test

- The `$result` field of the returned data frame (`"PASS"`, `"FAIL"`,
  `"WARNING"`)
- The `stop_on_error` behaviour (errors and no-errors)
- Message content when it matters (use
  [`grepl()`](https://rdrr.io/r/base/grep.html) on `$message`)
- Edge cases: NAs, empty strings, single values, large value sets
- Every function must have at least one test with an expected failure

### 4.6 What NOT to Test in Individual Check Tests

- Argument validation (that’s the orchestrator’s job)
- Integration with the screening pipeline (that’s `test-screen_dfs.R`)

------------------------------------------------------------------------

## 5. Migration Workflow

### Step-by-step process for migrating a single check function

#### Step 1: Identify and Analyse the Legacy Function

1.  Find the function in the legacy repo (`dfe-published-data-qa`),
    noting its location (e.g., `R/mainTests.r`).
2.  Understand what it checks, what inputs it needs, and what output it
    produces.
3.  Identify any hardcoded reference data it uses from
    `R/knownVariables.r`.
4.  Understand what the new function name should be and what family of
    functions (e.g. precheck_time) that it should belong to. Ask for
    clarification if unsure.
5.  **Read `R/utils.R` in full** to understand all available internal
    helpers before writing any logic. Many common operations (filtering
    columns by type, extracting filter groups, removing NAs/blanks,
    etc.) already have helpers. Use them rather than re-implementing
    inline.

#### Step 2: Create the initial Function File

0.  Create a new branch based off of the latest from main, following the
    format `claude/<function-name>`
1.  Create `R/<check_or_precheck>_<area>_<what>.R`.
2.  Write the function with the standard signature (`verbose`,
    `stop_on_error`).
3.  Use `test_output()` for all return paths.
4.  Add roxygen2 documentation:
    - Use `@inheritParams` from the most appropriate existing function.
    - Use `@inherit check_filename_spaces return`.
    - Set the correct `@family` tag.
    - Add at least two `@examples`.
    - Add `@export`.

#### Step 3: Add Reference Data (if needed)

If the check uses hardcoded values from `R/knownVariables.r`: 1. Create
a script in `data-raw/` to generate the data. 2. Execute the script to
create the data object as `.rda` in `data/`. 3. Document in
`R/reference_values.R`. 4. Add tests in `tests/testthat/`.

If the check uses data read in from a CSV file within that original
repo. Add the CSV as a data object, e.g. countries.csv. Then create a
data object that reads from that repo directly like we have for the data
dictionary data object already.

For example where in `R/knownVariables.r` there is
`countries <- suppressMessages(read_csv("data/country.csv"))`.

1.  Create a script in `data-raw/` as follows:

&nbsp;

    countries <- readr::read_csv(
      render_url("data/countries.csv", domain = "screener_app_repo")
    )

    usethis::use_data(countries, overwrite = TRUE)

2.  Execute that script, to generate the data object.
3.  Add documentation for the data object in `R/reference_values.R`.
4.  Add tests for the data object in `tests/testthat/` ensuring that the
    output format and class remains stable, avoid being too strict on
    row rumbers as these can change.

#### Step 4: Wire into the Screening Pipeline

1.  Add the function call to the appropriate stage in `R/screen_dfs.R`.
    If the appropriate stage does not already exist, insert a new stage
    and adapt the code around it accordingly.
2.  Follow the existing pattern:
    [`rbind()`](https://rdrr.io/r/base/cbind.html) the result into the
    stage’s results accumulator.
3.  Ensure the stage ordering is correct (prechecks before checks,
    blocking stages before non-blocking).

#### Step 4b: Regenerate Example Output

Adding a new check to the screening pipeline increases the number of
rows in the results table. The `example_output` dataset must be
regenerated to stay in sync, otherwise the `test-screen_csv.R` log row
count test will fail.

1.  Run the regeneration script:

    ``` r
    devtools::load_all()
    source("data-raw/example_output.R")
    ```

2.  This updates `data/example_output.rda` to include the new check’s
    result row.

3.  Commit the updated `data/example_output.rda` alongside the other
    changes.

#### Step 5: Write Tests

1.  Create `tests/testthat/test-<function_name>.R`.
2.  Write tests covering:
    - PASS case with inline data
    - PASS case with `example_data`/`example_meta`
    - FAIL case with one problem
    - FAIL case with multiple problems
    - Edge cases (NAs, empty strings, etc.)
    - `stop_on_error = TRUE` for both PASS and FAIL paths
    - Any singular and plural versions of error messages to ensure all
      paths work

Note: Use versions of example data as listed in R/example_datasets.R for
the tests, then adapt that as needed, this will ensure minimal but
realistic test data is used. E.g.

``` r
expect_warning(
  check_api_char_loc_code(
    example_data |>
      dplyr::mutate(country_code = paste(rep("E88", 20), collapse = "")),
    stop_on_error = TRUE
  ),
  "exceed the character limit"
)
```

#### Step 6: Update Documentation and Namespace

0.  Run `air format .` (direct in terminal, not an R command) to format
    the files
1.  Run `devtools::document()` to regenerate `NAMESPACE` and `man/`
    pages.
2.  Add the function to the appropriate section in `_pkgdown.yml` if a
    new section is needed.
3.  Verify the function appears correctly in documentation with
    `?function_name`.

#### Step 7: Verify

1.  Run `devtools::test()` - all tests must pass.

#### Step 8: Iterate and improve

1.  Simplify the legacy code that was migrated:
    - Replace `sapply` patterns with vectorised or dplyr approaches.
    - Use dplyr verbs where possible for duckplyr compatibility.
    - Remove unnecessary intermediate objects.
2.  Combine singular / plural messages where appropriate using
    cli::pluralize() or sprintf()
3.  Run `devtools::test()` to ensure the behaviour has not changed at
    all
4.  Run `air format .` (direct in terminal, not an R command) to format
    the files
5.  Run `devtools::load_all(); lintr::lint_package()` to check for
    linting issues

#### Step 9: Commit and PR

0.  Run `air format .` (direct in terminal, not an R command) to format
    the files
1.  Commit all changes (function, tests, NAMESPACE, man pages,
    screen_dfs.R changes, any new data).
2.  Create PR following the PR conventions below.

------------------------------------------------------------------------

## 6. PR Conventions

### 6.1 What a Migration PR Contains

Every migration PR should include changes to:

| File                                    | Change                                                       |
|-----------------------------------------|--------------------------------------------------------------|
| `R/<function_name>.R`                   | New file — the migrated check function                       |
| `R/screen_dfs.R`                        | Modified — wire the new check into the pipeline              |
| `tests/testthat/test-<function_name>.R` | New file — tests for the check                               |
| `NAMESPACE`                             | Modified — auto-generated export declaration                 |
| `man/<function_name>.Rd`                | New file — auto-generated documentation                      |
| `man/*.Rd` (other)                      | Modified — auto-updated from `@inheritParams` changes        |
| `_pkgdown.yml`                          | Modified — only if a new section is needed                   |
| `data/example_output.rda`               | Modified — regenerated to include the new check’s result row |
| `data/*.rda`                            | Modified/added — only if new reference data is needed        |
| `data-raw/*.R`                          | Modified/added — only if new reference data is needed        |

### 6.2 PR Description Pattern

Based on the example PRs (#6, \#7, \#12, \#42), descriptions should:

- State what function was added and what it checks.
- Reference the legacy source (which file/function it was migrated
  from).
- Note any conflicts with other in-flight PRs.
- Keep it concise (2–4 sentences).
- Link to the GitHub main branch version of the script that contains the
  original function to allow for easy review

Example: \> Copied across the ‘filter group match’ function from the
dfe-published-data-qa repository. This adds the check as a function
named `check_meta_filter_group_match` into the new package.

### 6.3 PR Titles

Based on the examples: -
`"Add the check_meta_duplicate_label() function"` -
`"Add precheck_col_name_duplicate"` -
`"Add filter group match function"`

Short, descriptive, focused on what was added.

### 6.4 Scope

- One check function per PR (unless closely related utility functions
  are needed).
- Do not mix migration work with unrelated refactoring.

------------------------------------------------------------------------

## 7. Review the CI on the PR

1.  Check that all GitHub actions are passing on the PR

If any are failing, review the logs to understand the failures then fix
them in an additional commit.

------------------------------------------------------------------------

## 8. Golden Patterns

### 8.1 Canonical Migrated Function (meta-only check)

``` r
#' Check there are no duplicate labels
#'
#' Ensure that each entry under label is unique in the metafile.
#'
#' @inheritParams precheck_meta_col_type
#'
#' @inherit check_filename_spaces return
#'
#' @family check_meta
#'
#' @examples
#' check_meta_duplicate_label(example_meta)
#' check_meta_duplicate_label(example_meta, verbose = TRUE)
#' @export
check_meta_duplicate_label <- function(
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  duplicated_labels <- meta$label[duplicated(meta$label)]
  check_name <- get_check_name()

  if (length(duplicated_labels) == 0) {
    test_output(
      check_name,
      "PASS",
      "All labels are unique.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    test_output(
      check_name,
      "FAIL",
      cli::pluralize(
        "The following {cli::qty(length(duplicated_labels))}label{?s} ",
        "{?is/are} duplicated in the metadata file: '",
        paste0(duplicated_labels, collapse = "', '"),
        "'."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}
```

### 8.2 Canonical Migrated Function (data + meta check with dplyr)

``` r
#' Check filter groups match in meta and data
#'
#' Ensure all filter groups from the meta data are found in the data file.
#'
#' @inheritParams precheck_col_to_rows
#'
#' @inherit check_filename_spaces return
#'
#' @family check_meta
#'
#' @examples
#' check_meta_fil_grp_match(example_data, example_meta)
#' check_meta_fil_grp_match(example_data, example_meta, verbose = TRUE)
#' @export
check_meta_fil_grp_match <- function(
  data,
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  check_name <- get_check_name()

  meta_filter_groups <- meta |>
    dplyr::filter(
      !(is.na(.data$filter_grouping_column) |
        .data$filter_grouping_column == "")
    )

  if (nrow(meta_filter_groups) == 0) {
    return(test_output(
      check_name,
      "PASS",
      "There are no filter groups present.",
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }

  filter_groups_not_in_data <- setdiff(
    meta_filter_groups$filter_grouping_column,
    names(data)
  )

  if (length(filter_groups_not_in_data) == 0) {
    test_output(
      check_name,
      "PASS",
      "All filter groups from the metadata were found in the data file.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    test_output(
      check_name,
      "FAIL",
      cli::pluralize(
        "The following {cli::qty(length(filter_groups_not_in_data))}filter group{?s} ",
        "from the metadata {?was/were} not found as ",
        "{?a variable/variables} in the data file: '",
        paste0(filter_groups_not_in_data, collapse = "', '"),
        "'."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}
```

Key patterns used here (vs the simpler meta-only check in 8.1): -
`check_name <- get_check_name()` — no hardcoded string; stays in sync if
the function is renamed. - Early
[`return()`](https://rdrr.io/r/base/function.html) on the short-circuit
PASS branch (section 9.7). -
[`cli::pluralize()`](https://cli.r-lib.org/reference/pluralize.html)
replaces a nested `if/else` for singular/plural messages (section
2.5). - Intermediate result stored in a named variable before the final
`if/else` — avoids repeating the dplyr chain.

### 8.3 Canonical Test File

``` r
test_that("passes when all labels are unique", {
  meta <- data.frame(label = c("A", "B", "C"))
  expect_equal(check_meta_duplicate_label(meta)$result, "PASS")
  expect_no_error(check_meta_duplicate_label(meta, stop_on_error = TRUE))
  expect_no_error(check_meta_duplicate_label(
    example_meta,
    stop_on_error = TRUE
  ))
})

test_that("fails with one duplicate label", {
  meta <- data.frame(label = c("A", "B", "A"))
  expect_equal(check_meta_duplicate_label(meta)$result, "FAIL")
  expect_error(check_meta_duplicate_label(meta, stop_on_error = TRUE))
})

test_that("fails with multiple duplicate labels", {
  meta <- data.frame(label = c("A", "B", "A", "B"))
  expect_equal(check_meta_duplicate_label(meta)$result, "FAIL")
  expect_error(check_meta_duplicate_label(meta, stop_on_error = TRUE))
})

test_that("handles numeric values in label", {
  meta <- data.frame(label = c(1:3))
  expect_equal(check_meta_duplicate_label(meta)$result, "PASS")
  expect_no_error(check_meta_duplicate_label(meta, stop_on_error = TRUE))

  meta2 <- data.frame(label = c(1, 2, 1))
  expect_equal(check_meta_duplicate_label(meta2)$result, "FAIL")
  expect_error(check_meta_duplicate_label(meta2, stop_on_error = TRUE))
})
```

### 8.4 Canonical PR Description

> **Title**: Adding the check_meta_duplicate_label() function
>
> Copied across the duplicate label check from the dfe-published-data-qa
> repository (originally `duplicate_label()` in `R/mainTests.r`). This
> adds the check as a function named `check_meta_duplicate_label` into
> the package, with tests and documentation.

### 8.5 Canonical `screen_dfs()` stage block

Every stage in
[`screen_dfs()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_dfs.md)
follows this pattern using the `run_and_log_check()` helper:

``` r
# Check <area> ----------------------------------------------------------------
res <- run_and_log_check(
  all_results,
  rbind(
    check_area_thing_one(data, meta, vb, soe),
    check_area_thing_two(data, meta, vb, soe)
  ),
  "Check <area>",
  log_key,
  log_dir,
  data_details
)
all_results <- res$all_results
if (res$early_return) {
  return(as.data.frame(all_results))
}
```

Rules: - `vb` and `soe` are shorthands for `verbose` and `stop_on_error`
set at the top of
[`screen_dfs()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_dfs.md). -
Checks are called with **positional arguments** for the common
parameters (see section 2.3). - `run_and_log_check()` handles: appending
the `stage` column, calling `write_json_log()`, and detecting any
`"FAIL"` for early-exit signalling. - All stages follow this exact
three-line pattern (`res <- ...`, `all_results <- res$all_results`,
`if (res$early_return) ...`). - The Check API stage is the only
exception — it builds `check_api_results` separately before passing to
`run_and_log_check()` because of the conditional `dd_checks` block.

### 8.6 Grouped-export file pattern (shared internal helper)

When several exported `check_api_*()` functions all delegate to one
internal helper that calls `test_output()`, they live together in one
file. The file is named after the shared concept (e.g.,
`check_api_char_limit.R`), not any single exported function.

``` r
# Internal helper — calls test_output() directly, builds its own test_name
some_helper <- function(values, type, verbose = FALSE, stop_on_error = FALSE) {
  test_name <- paste0("api_", type_map[[type]])
  # ... shared logic ...
  if (problem) {
    return(test_output(
      test_name, "WARNING", message,
      guidance_url = render_url("..."),
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  }
  test_output(test_name, "PASS", pass_message, verbose = verbose,
              stop_on_error = stop_on_error)
}

#' Check thing A
#' @inheritParams precheck_col_req_data
#' @inherit check_filename_spaces return
#' @family check_api
#' @examples
#' check_api_thing_a(example_data)
#' check_api_thing_a(example_data, verbose = TRUE)
#' @export
check_api_thing_a <- function(data, verbose = FALSE, stop_on_error = FALSE) {
  some_helper(data |> dplyr::tbl_vars(), "type-a", verbose, stop_on_error)
}

#' Check thing B
#' @inheritParams precheck_col_req_meta
#' @inherit check_filename_spaces return
#' @family check_api
#' @examples
#' check_api_thing_b(example_meta)
#' check_api_thing_b(example_meta, verbose = TRUE)
#' @export
check_api_thing_b <- function(meta, verbose = FALSE, stop_on_error = FALSE) {
  some_helper(as.character(meta$label), "type-b", verbose, stop_on_error)
}
```

This is the only sanctioned deviation from “one exported function per
file”. It applies when: 1. The exported functions are thin wrappers over
one shared internal helper. 2. All belong to the same `@family` group.
3. Keeping them together makes the shared helper easier to find and
maintain.

Because `get_check_name()` walks up the call stack looking for a
`check_`/`precheck_` prefix, it works correctly even when the internal
helper passes through a wrapper — but the internal helper itself cannot
use `get_check_name()` and must construct the test name from its own
logic.

------------------------------------------------------------------------

## 9. Inferred Rules (Not Explicitly Stated)

These rules are implied by the codebase patterns but not written
anywhere:

### 9.1 Code Style

- **2-space indentation** (configured in `.Rproj`).
- **Tidyverse style guide** (no trailing whitespace, spaces around
  operators, etc.).
- **Roxygen2 markdown format** is enabled
  (`Roxygen: list(markdown = TRUE)` in DESCRIPTION).
- **British English** spelling (`Language: en-GB` in DESCRIPTION).
- **No trailing commas** in function arguments.
- **Function arguments on separate lines** when the function definition
  is long (one argument per line).

### 9.2 test_output() First Argument

The `test_name` argument passed to `test_output()` is a short identifier
that omits the `check_`/`precheck_` prefix — for example,
[`check_meta_dupe_label()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_dupe_label.md)
produces `"meta_dupe_label"` and
[`precheck_geog_level()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_geog_level.md)
produces `"geog_level"`. This is the value that appears in the `check`
column of the results data frame.

**Always derive this with `get_check_name()`** rather than writing a
string literal. This keeps the check name automatically in sync if the
function is ever renamed:

``` r
check_name <- get_check_name()
```

Call it at the top of the function body, before any logic. The only
exception is internal non-`check_`/`precheck_` helpers (like
`api_char_limit()`) that call `test_output()` directly — those must
build the test name themselves because `get_check_name()` looks for a
`check_` or `precheck_` prefix in the call stack.

### 9.3 Example Data Always Passes

The package’s built-in example datasets (`example_data`, `example_meta`)
must always pass all checks. Every test file should include a test
confirming this. If a new check would fail on the example data, update
the example data.

### 9.5 Stage-Based Early Exit

In
[`screen_dfs()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_dfs.md),
if any check in a stage returns `"FAIL"`, screening stops and returns
all results accumulated so far. This means prechecks genuinely gate the
later checks.

### 9.6 duckplyr Activation

[`screen_dfs()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_dfs.md)
calls `suppressMessages(duckplyr::methods_restore())` at the very start
of the function (before any check stages run), then converts `data` to a
duckdb tibble with
[`duckplyr::as_duckdb_tibble()`](https://duckplyr.tidyverse.org/reference/duckdb_tibble.html)
— but only if it is not already one (checked via
[`duckplyr::is_duckdb_tibble()`](https://duckplyr.tidyverse.org/reference/duckdb_tibble.html)).
The `meta` data frame is left as a plain data frame throughout since it
is always small.

Individual `check_*()` and `precheck_*()` functions do not activate
duckplyr themselves; they receive whatever frame
[`screen_dfs()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_dfs.md)
has prepared and should use dplyr verbs throughout.

### 9.7 No Explicit Return Statements (Usually)

Most check functions rely on implicit return of the last expression
(`test_output()` call). Explicit
[`return()`](https://rdrr.io/r/base/function.html) is used only for
early exits (e.g., when a check can short-circuit before the main
logic).

### 9.8 Consistent data.frame Construction in Tests

Test data uses simple
[`data.frame()`](https://rdrr.io/r/base/data.frame.html) calls with
named columns. Use `stringsAsFactors = FALSE` when the data contains
character columns that might be affected by R’s factor-coercion defaults
(though this is less of an issue in R \>= 4.0 where `stringsAsFactors`
defaults to FALSE).

### 9.9 No Snapshot Tests

The codebase does not use `testthat` snapshot tests. All assertions are
explicit equality or error/no-error checks.

### 9.10 Namespace Management

- `NAMESPACE` is auto-generated by roxygen2 — never edit manually.
- Run `devtools::document()` after any changes to `@export`,
  `@importFrom`, or `@inheritParams`.
- The package imports
  [`rlang::.data`](https://rlang.r-lib.org/reference/dot-data.html) at
  the package level for use in dplyr expressions.

### 9.11 Guidance URLs

The `guidance_url` parameter in `test_output()` is used sparingly. Most
checks pass `NA` (the default). Only API checks and checks where
external documentation would help the user include a URL, constructed
via the internal `render_url()` helper.

Do not include a guidance URL unless a test has failed, only include
guidance URLs if they are included in the original function.

### 9.12 Log Integration

When wiring a new check into
[`screen_dfs()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_dfs.md),
use the `run_and_log_check()` helper (see section 8.5). It handles
appending the `stage` column, calling `write_json_log()`, and signalling
an early-return if any result is `"FAIL"`. Do not call
`write_json_log()` or `cbind("stage" = ...)` directly in
[`screen_dfs()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_dfs.md).
