# Migration Context Pack

Reference document for migrating legacy R Shiny checks from [dfe-published-data-qa](https://github.com/dfe-analytical-services/dfe-published-data-qa/) into the `eesyscreener` R package.

---

## 1. Migration Principles

### What the migration is

Functions from a monolithic Shiny app (`dfe-published-data-qa`) are being extracted one-at-a-time into a standalone, documented, tested R package (`eesyscreener`). The legacy code lives primarily in `R/mainTests.r`, `R/preCheck1.r`, and `R/knownVariables.r` in the Shiny app repo.

### Why

- **Reusability**: The package is consumed by three contexts: a Shiny app, a Plumber API, and direct R usage by analysts.
- **Performance**: The Shiny app and API must be responsive even with files of 5+ million rows. DuckDB/duckplyr is used for speed.
- **Maintainability**: One function per file, one test file per function, consistent interfaces, roxygen2 documentation.
- **Standards enforcement**: The package enforces open data standards for the Explore Education Statistics (EES) platform.

### Core philosophy

- One check at a time, unless a utility function covers multiple checks.
- Simplify during migration --- do not bring over legacy complexity.
- Minimise new dependencies; prefer base R or dplyr (which piggybacks on duckplyr for performance).
- Speed is king. Profile with `microbenchmark` on large files. Prioritise large-file performance over small-file performance.

---

## 2. Coding Conventions

### 2.1 Naming

| Entity | Convention | Examples |
|--------|-----------|----------|
| Exported check functions | `check_<area>_<what>()` | `check_meta_duplicate_label()`, `check_filter_defaults()` |
| Exported precheck functions | `precheck_<area>_<what>()` | `precheck_col_req_data()`, `precheck_geog_level()` |
| Exported screen functions | `screen_<scope>()` | `screen_csv()`, `screen_dfs()`, `screen_filenames()` |
| Internal argument validators | `validate_arg_<what>()` | `validate_arg_filenames()`, `validate_arg_dfs()` |
| Internal helpers | Descriptive snake_case | `test_output()`, `null_filename()`, `get_cols_meta()` |
| Test name passed to `test_output()` | Short snake_case identifier (no `check_`/`precheck_` prefix) | `"meta_duplicate_label"`, `"col_req_meta"`, `"geographic_level"` |
| File names | Match function name exactly | `R/check_meta_duplicate_label.R` |
| Test file names | `test-<function_name>.R` | `tests/testthat/test-check_meta_duplicate_label.R` |
| Reference data objects | Descriptive snake_case | `req_meta_cols`, `acceptable_time_ids`, `geography_df` |

**Important**: Check names in `_pkgdown.yml` must align with the naming convention. All individual checks should be named in accordance with the groupings defined there.

### 2.2 File Structure

```
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
```

### 2.3 Function Signatures

Every `check_*()` and `precheck_*()` function follows a consistent signature pattern:

```r
check_something <- function(
  data,            # and/or meta, or other primary input
  verbose = FALSE,
  stop_on_error = FALSE
)
```

- `verbose` (logical): If TRUE, prints feedback messages via `cli`.
- `stop_on_error` (logical): If TRUE, aborts on FAIL, warns on WARNING.
- Some functions only take `meta`, some take `data`, some take both `data` and `meta`.
- Some functions have additional specific parameters (e.g., `custom_name` in `check_filename_spaces()`).

**Critical rule**: Do NOT validate arguments inside individual `precheck_*()` or `check_*()` functions. Argument validation happens only in the `screen_*()` orchestrators via `validate_arg_*()` helpers.

### 2.4 Return Values

Every check function returns the result of `test_output()`, which produces a single-row `data.frame` with columns:

| Column | Type | Values |
|--------|------|--------|
| `check` | character | Short test name (e.g., `"meta_duplicate_label"`) |
| `result` | character | `"PASS"`, `"FAIL"`, or `"WARNING"` |
| `message` | character | Human-readable feedback |
| `guidance_url` | character or NA | Optional URL to documentation |

The `screen_*()` functions aggregate these via `rbind()` and add a `stage` column.

### 2.5 Message Patterns

Messages follow consistent grammatical patterns:

- **PASS (nothing found)**: `"All labels are unique."`, `"No indicators have a filter_grouping_column value."`
- **PASS (positive confirmation)**: `"The geographic_level values are all valid."`
- **FAIL (singular)**: `"The following label is duplicated in the metadata file: 'X'."`
- **FAIL (plural)**: `"The following labels are duplicated in the metadata file: 'X', 'Y'."`

When failing values are listed, they are formatted with single quotes and joined with `"', '"`:
```r
paste0("'", paste0(values, collapse = "', '"), "'.")
```

Many functions handle singular/plural messages separately (different wording for 1 vs many failures). This is a convention in the codebase.

### 2.6 Dependency Management

- **Prefer dplyr verbs** that work with duckplyr for performance (duckplyr is enabled via `duckplyr::methods_overwrite()` in `screen_dfs()`).
- **Use `.data$column_name`** pronoun from rlang when using dplyr in package code (avoids "no visible binding" notes). The package imports `rlang::.data`.
- **Pipe operator**: Use the base R pipe `|>` (not magrittr `%>%`).
- **Avoid adding new dependencies** unless the performance benefit is substantial and proven via benchmarking.
- **dplyr over base R** for data manipulation --- it's faster on large files via duckplyr.
- **cli** for user-facing messages (`cli::cli_abort()`, `cli::cli_warn()`, `cli::cli_alert_*`).
- **No data.table** --- converting between data.frame and data.table costs time.

### 2.7 Error Handling

- Use `cli::cli_abort()` for errors (not `stop()`).
- Use `cli::cli_warn()` for warnings (not `warning()`).
- The `test_output()` helper handles the `stop_on_error` logic centrally: if `stop_on_error = TRUE`, FAIL results call `cli::cli_abort()` and WARNING results call `cli::cli_warn()`.
- Argument validation uses `cli::cli_abort()` directly in `validate_arg_*()` functions in `utils.R`.

### 2.8 Internal Helper Conventions

- All internal helpers go in `R/utils.R`.
- Mark with `@keywords internal` and `@noRd` (no separate `.Rd` file generated).
- Include `@returns` in roxygen2 documentation even for internal functions.
- Helper functions should be reusable --- avoid duplication between check functions.

### 2.9 Performance

- Always benchmark with `microbenchmark` on large files (5M+ rows).
- Use the `tests/utils/benchmarking.R` script as a starting point.
- Prioritise large-file performance. DuckDB can be slower on tiny files but dramatically faster on large ones.
- Use `prudence = "stingy"` with `screen_dfs()` to identify functions that inadvertently materialise lazy tables.
- Avoid operations that force full materialisation of lazy duckplyr data frames.

---

## 3. Documentation Conventions

### 3.1 roxygen2 Structure

Every exported function must have:

```r
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

| Pattern | Usage |
|---------|-------|
| `@inheritParams precheck_meta_col_type` | Inherit `meta`, `verbose`, `stop_on_error` params |
| `@inheritParams precheck_col_to_rows` | Inherit `data`, `meta`, `verbose`, `stop_on_error` params |
| `@inheritParams check_col_names_spaces` | Inherit `data`, `verbose`, `stop_on_error` params |
| `@inherit check_filename_spaces return` | Copy return documentation |
| `@family check_meta` | Group in pkgdown docs (use the `_pkgdown.yml` categories) |
| `@keywords internal` + `@noRd` | For internal functions in `utils.R` |

**Minimise duplication**: Use `@inheritParams` extensively rather than redefining parameter descriptions. Find the most appropriate existing function that already defines the params you need.

### 3.3 Examples

- Every exported function must have at least two examples: one basic call, one with `verbose = TRUE`.
- Use the package's built-in example datasets (`example_data`, `example_meta`, `example_filter_group`, etc.).
- Examples must be runnable without external files.

### 3.4 Return Documentation

The canonical return description is inherited from `check_filename_spaces`:

```r
#' @return a single row data frame
```

Use `@inherit check_filename_spaces return` rather than rewriting this.

### 3.5 Family Tags

Family tags must correspond to the groupings in `_pkgdown.yml`:

- `@family filename` --- filename checks
- `@family precheck_col` --- precheck column checks
- `@family precheck_meta` --- precheck metadata checks
- `@family check_meta` --- metadata checks
- `@family precheck_time` --- precheck time checks
- `@family check_time` --- time checks
- `@family precheck_geog` --- geography prechecks
- `@family check_filter` --- filter checks
- `@family check_api` --- API-specific checks

---

## 4. Testing Conventions

### 4.1 Test File Naming

- One test file per function: `test-<function_name>.R`
- Located in `tests/testthat/`
- The function name in the filename matches the R file name exactly

### 4.2 Test Structure

Tests use `testthat` edition 3. Each test file contains multiple `test_that()` blocks covering:

1. **Happy path (PASS)** --- with inline data and with package example data
2. **Failure cases** --- one failing value, multiple failing values
3. **Edge cases** --- empty inputs, NAs, blanks, numeric values where strings expected
4. **`stop_on_error` behaviour** --- `expect_no_error()` for PASS, `expect_error()` for FAIL

### 4.3 Canonical Test Pattern

```r
test_that("passes when <condition>", {
  # Inline test data
  meta <- data.frame(col_name = c("A", "B", "C"))
  expect_equal(check_something(meta)$result, "PASS")
  expect_no_error(check_something(meta, stop_on_error = TRUE))
  # Also test with package example data
  expect_no_error(check_something(example_meta, stop_on_error = TRUE))
})

test_that("fails with one <problem>", {
  meta <- data.frame(col_name = c("A", "B", "A"))
  expect_equal(check_something(meta)$result, "FAIL")
  expect_error(check_something(meta, stop_on_error = TRUE))
})

test_that("fails with multiple <problems>", {
  meta <- data.frame(col_name = c("A", "A", "B", "B"))
  expect_equal(check_something(meta)$result, "FAIL")
  expect_error(check_something(meta, stop_on_error = TRUE))
})
```

### 4.4 Test Data

- **Inline `data.frame()` construction** is the primary approach for test data --- create minimal data frames that exercise the specific check.
- **Package example datasets** (`example_data`, `example_meta`) should always be tested as a PASS case via `expect_no_error(fn(example_data, stop_on_error = TRUE))`.
- **RDS files** for more complex or copied-over test data. Use `tests/utils/copy_check_data.R` to import CSVs from the legacy repo and save as RDS.
- **Temp CSV files** when testing file I/O (e.g., `screen_csv` tests).
- **No mocking** --- use real but minimal data.

### 4.5 What to Test

- The `$result` field of the returned data frame (`"PASS"`, `"FAIL"`, `"WARNING"`)
- The `stop_on_error` behaviour (errors and no-errors)
- Message content when it matters (use `grepl()` on `$message`)
- Edge cases: NAs, empty strings, single values, large value sets
- Every function must have at least one test with an expected failure

### 4.6 What NOT to Test in Individual Check Tests

- Argument validation (that's the orchestrator's job)
- Integration with the screening pipeline (that's `test-screen_dfs.R`)

---

## 5. Migration Workflow

### Step-by-step process for migrating a single check function

#### Step 1: Identify and Analyse the Legacy Function

1. Find the function in the legacy repo (`dfe-published-data-qa`), noting its location (e.g., `R/mainTests.r`).
2. Understand what it checks, what inputs it needs, and what output it produces.
3. Identify any hardcoded reference data it uses from `R/knownVariables.r`.

#### Step 2: Create the Function File

0. Create a new branch based off of the latest from main, following the format `claude/<function-name>`
1. Create `R/<check_or_precheck>_<area>_<what>.R`.
2. Write the function with the standard signature (`verbose`, `stop_on_error`).
3. Use `test_output()` for all return paths.
4. Simplify the legacy code during migration:
   - Replace `sapply` patterns with vectorised or dplyr approaches.
   - Use dplyr verbs where possible for duckplyr compatibility.
   - Remove unnecessary intermediate objects.
5. Handle singular/plural messages where appropriate.
6. Add roxygen2 documentation:
   - Use `@inheritParams` from the most appropriate existing function.
   - Use `@inherit check_filename_spaces return`.
   - Set the correct `@family` tag.
   - Add at least two `@examples`.
   - Add `@export`.

#### Step 3: Add Reference Data (if needed)

If the check uses hardcoded values from `R/knownVariables.r`:
1. Create a script in `data-raw/` to generate the data.
2. Execute the script to create the data object as `.rda` in `data/`.
3. Document in `R/reference_values.R`.

#### Step 4: Wire into the Screening Pipeline

1. Add the function call to the appropriate stage in `R/screen_dfs.R`. If the appropriate stage does not already exist, insert a new stage and adapt the code around it accordingly.
2. Follow the existing pattern: `rbind()` the result into the stage's results accumulator.
3. Ensure the stage ordering is correct (prechecks before checks, blocking stages before non-blocking).

#### Step 5: Write Tests

1. Create `tests/testthat/test-<function_name>.R`.
2. Write tests covering:
   - PASS case with inline data
   - PASS case with `example_data`/`example_meta`
   - FAIL case with one problem
   - FAIL case with multiple problems
   - Edge cases (NAs, empty strings, etc.)
   - `stop_on_error = TRUE` for both PASS and FAIL paths

#### Step 6: Update Documentation and Namespace

1. Run `devtools::document()` to regenerate `NAMESPACE` and `man/` pages.
2. Add the function to the appropriate section in `_pkgdown.yml` if a new section is needed.
3. Verify the function appears correctly in documentation with `?function_name`.

#### Step 7: Verify

0. Format the project using Air.
1. Run `devtools::test()` --- all tests must pass.
2. Run `devtools::check()` --- no errors, warnings, or notes related to your changes.

#### Step 8: Commit and PR

1. Commit all changes (function, tests, NAMESPACE, man pages, screen_dfs.R changes, any new data).
2. Create PR following the PR conventions below.

---

## 6. PR Conventions

### 6.1 What a Migration PR Contains

Every migration PR should include changes to:

| File | Change |
|------|--------|
| `R/<function_name>.R` | New file --- the migrated check function |
| `R/screen_dfs.R` | Modified --- wire the new check into the pipeline |
| `tests/testthat/test-<function_name>.R` | New file --- tests for the check |
| `NAMESPACE` | Modified --- auto-generated export declaration |
| `man/<function_name>.Rd` | New file --- auto-generated documentation |
| `man/*.Rd` (other) | Modified --- auto-updated from `@inheritParams` changes |
| `_pkgdown.yml` | Modified --- only if a new section is needed |
| `data/*.rda` | Modified/added --- only if new reference data is needed |

### 6.2 PR Description Pattern

Based on the example PRs (#6, #7, #12, #42), descriptions should:

- State what function was added and what it checks.
- Reference the legacy source (which file/function it was migrated from).
- Note any conflicts with other in-flight PRs.
- Keep it concise (2--4 sentences).

Example:
> Copied across the 'filter group match' function from the dfe-published-data-qa repository. This adds the check as a function named `check_meta_filter_group_match` into the new package.

### 6.3 PR Titles

Based on the examples:
- `"Adding the check_meta_duplicate_label() function"`
- `"Add precheck_col_name_duplicate"`
- `"Adding filter group match function"`

Short, descriptive, focused on what was added.

### 6.4 Scope

- One check function per PR (unless closely related utility functions are needed).
- Do not mix migration work with unrelated refactoring.

---

## 7. Golden Patterns

### 7.1 Canonical Migrated Function (meta-only check)

```r
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

  if (length(duplicated_labels) == 0) {
    test_output(
      "meta_duplicate_label",
      "PASS",
      "All labels are unique.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    if (length(duplicated_labels) == 1) {
      test_output(
        "meta_duplicate_label",
        "FAIL",
        paste0(
          "The following label is duplicated in the metadata file: '",
          duplicated_labels,
          "'."
        ),
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    } else {
      test_output(
        "meta_duplicate_label",
        "FAIL",
        paste0(
          "The following labels are duplicated in the metadata file: '",
          paste0(duplicated_labels, collapse = "', '"),
          "'."
        ),
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    }
  }
}
```

### 7.2 Canonical Migrated Function (data + meta check with dplyr)

```r
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
#' check_meta_filter_group_match(example_data, example_meta)
#' check_meta_filter_group_match(example_data, example_meta, verbose = TRUE)
#' @export
check_meta_filter_group_match <- function(
  data,
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  meta_filter_groups <- meta |>
    dplyr::filter(
      !(is.na(.data$filter_grouping_column) |
        .data$filter_grouping_column == "")
    )

  if (nrow(meta_filter_groups) == 0) {
    test_output(
      "filter_groups_match",
      "PASS",
      "There are no filter groups present.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    filter_groups_not_in_data <- setdiff(
      meta_filter_groups$filter_grouping_column,
      names(data)
    )
    number_filter_groups_not_in_data <- length(filter_groups_not_in_data)

    if (number_filter_groups_not_in_data == 0) {
      test_output(
        "filter_groups_match",
        "PASS",
        "All filter groups from the metadata were found in the data file.",
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    } else {
      if (number_filter_groups_not_in_data == 1) {
        test_output(
          "filter_groups_match",
          "FAIL",
          paste0(
            "The following filter group from the metadata was not found ",
            "as a variable in the data file: '",
            paste0(filter_groups_not_in_data, collapse = "', '"),
            "'."
          ),
          verbose = verbose,
          stop_on_error = stop_on_error
        )
      } else {
        test_output(
          "filter_groups_match",
          "FAIL",
          paste0(
            "The following filter groups from the metadata were not found ",
            "as variables in the data file: '",
            paste0(filter_groups_not_in_data, collapse = "', '"),
            "'."
          ),
          verbose = verbose,
          stop_on_error = stop_on_error
        )
      }
    }
  }
}
```

### 7.3 Canonical Test File

```r
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

### 7.4 Canonical PR Description

> **Title**: Adding the check_meta_duplicate_label() function
>
> Copied across the duplicate label check from the dfe-published-data-qa repository (originally `duplicate_label()` in `R/mainTests.r`). This adds the check as a function named `check_meta_duplicate_label` into the package, with tests and documentation.

---

## 8. Inferred Rules (Not Explicitly Stated)

These rules are implied by the codebase patterns but not written anywhere:

### 8.1 Code Style

- **2-space indentation** (configured in `.Rproj`).
- **Tidyverse style guide** (no trailing whitespace, spaces around operators, etc.).
- **Roxygen2 markdown format** is enabled (`Roxygen: list(markdown = TRUE)` in DESCRIPTION).
- **British English** spelling (`Language: en-GB` in DESCRIPTION).
- **No trailing commas** in function arguments.
- **Function arguments on separate lines** when the function definition is long (one argument per line).

### 8.2 test_output() First Argument

The `test_name` argument passed to `test_output()` should be a short identifier that omits the `check_`/`precheck_` prefix. For example, `check_meta_duplicate_label()` passes `"meta_duplicate_label"` and `precheck_geog_level()` passes `"geographic_level"`. This is the value that appears in the `check` column of the results data frame.

### 8.3 Example Data Always Passes

The package's built-in example datasets (`example_data`, `example_meta`) must always pass all checks. Every test file should include a test confirming this. If a new check would fail on the example data, update the example data.

### 8.4 WARNING vs FAIL

- `precheck_*()` functions produce `"FAIL"` (blocking) --- these are structural problems that prevent further screening.
- `check_*()` functions typically produce `"FAIL"` for data quality issues.
- API checks (`check_api_*()`) produce `"WARNING"` --- they indicate unsuitability for the API but don't block the overall screening.

### 8.5 Stage-Based Early Exit

In `screen_dfs()`, if any check in a stage returns `"FAIL"`, screening stops and returns all results accumulated so far. This means prechecks genuinely gate the later checks.

### 8.6 duckplyr Activation

`duckplyr::methods_overwrite()` is called in `screen_dfs()` only after the metadata checks (since meta is always small). Data-touching checks that run after this point benefit from duckplyr's DuckDB backend. Functions that operate on the `data` argument before this point should still use dplyr verbs (they'll just run as regular dplyr).

### 8.7 No Explicit Return Statements (Usually)

Most check functions rely on implicit return of the last expression (`test_output()` call). Explicit `return()` is used only for early exits (e.g., when a check can short-circuit before the main logic).

### 8.8 Consistent data.frame Construction in Tests

Test data uses simple `data.frame()` calls with named columns. Use `stringsAsFactors = FALSE` when the data contains character columns that might be affected by R's factor-coercion defaults (though this is less of an issue in R >= 4.0 where `stringsAsFactors` defaults to FALSE).

### 8.9 No Snapshot Tests

The codebase does not use `testthat` snapshot tests. All assertions are explicit equality or error/no-error checks.

### 8.10 Namespace Management

- `NAMESPACE` is auto-generated by roxygen2 --- never edit manually.
- Run `devtools::document()` after any changes to `@export`, `@importFrom`, or `@inheritParams`.
- The package imports `rlang::.data` at the package level for use in dplyr expressions.

### 8.11 Guidance URLs

The `guidance_url` parameter in `test_output()` is used sparingly. Most checks pass `NA` (the default). Only API checks and checks where external documentation would help the user include a URL, constructed via the internal `render_url()` helper.

Do not include a guidance URL unless a test has failed, only include guidance URLs if they are included in the original function.

### 8.12 Log Integration

When wiring a new check into `screen_dfs()`, the stage results must be passed to `write_json_log()` after each stage completes. Follow the existing pattern.
