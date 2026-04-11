# AGENTS.md

This file provides guidance to Claude Code (claude.ai/code) or other AI agents when working with code in this repository.

## Project Overview

**eesyscreener** is an R package providing data quality assurance (QA) checks for CSV files uploaded to the Explore Education Statistics (EES) platform. It's used in three main contexts:

1. **Shiny App** (`dfe-published-data-qa`): Interactive web interface for users to check files before upload. This is where all the logic was previously held and is currently being migrated from into this package. Eventually that app will use the functions from this package for its validation
2. **Plumber API** (`ees-screener-api`): Automated screening of uploads in the EES platform itself
3. **Direct R Usage**: Analysts integrating checks into their own data preparation pipelines

### Building and Running Tests

Run R commands via `Rscript -e "..."` in the terminal. Chain multiple expressions with `;`.

```bash
# Load package in development mode
Rscript -e "devtools::load_all()"

# Run all tests (fast, no build — use this for quick iteration)
Rscript -e "devtools::test()"

# Run tests for a specific file
Rscript -e "devtools::test(filter = 'test_name')"

# Full package check — R CMD check including build, examples, vignettes, and tests
# Use this as the final verification before committing/pushing
Rscript -e "devtools::check()"

# Generate documentation from roxygen2 comments
Rscript -e "devtools::document()"

# Lint the package
Rscript -e "devtools::load_all(); lintr::lint_package()"

# Format R code (run directly in terminal, not via Rscript)
air format .

# Rebuild the documentation site
Rscript -e "pkgdown::build_site()"
```

If the data dictionary test, or example output test fails, the first fix to try is regenerating the data objects by using `source("data-raw/data_dictionary.R")` (or `source("data-raw/example_output.R")`) and then run the tests again, often that will fix the issue.

### Key Dependencies

- **Core**: dplyr, stringr, tidyr, lubridate (data manipulation)
- **DuckDB Integration**: duckplyr, duckdb (efficient large-file processing)
- **Testing**: testthat (version 3.0.0+)
- **Documentation**: roxygen2, pkgdown
- **Optional**: dfeR (additional utility functions)

## Architecture

### Main Entry Points

1. **`screen_csv(datapath, metapath, ...)`** (R/screen_csv.R)
   - High-level wrapper that reads CSV files from disk
   - Handles file I/O, logging, and orchestrates all checks
   - Returns structured results with pass/fail status

2. **`screen_dfs(data, meta, ...)`** (R/screen_dfs.R)
   - Core screening logic operating on data frames
   - Used internally by `screen_csv()`
   - Called directly when data is already in memory

3. **`screen_filenames(data_filename, meta_filename)`** (R/screen_filenames.R)
   - Validates file naming conventions only
   - Subset of the full screening pipeline

### Check Architecture

Checks are organized into **stages**, executed sequentially. If any check fails in a stage, screening stops and returns the failure stage:

1. **Filename** – Naming conventions and special characters
2. **Precheck columns** – Required columns, column count matching
3. **Precheck meta** – Metadata structure and types
4. **Check meta** – Metadata content validation (warnings allowed)
5. **Precheck time** – Time period validity
6. **Check API** – API-specific constraints (warnings only, doesn't block)

Each check function follows the naming pattern:
- **`precheck_*`** – Early validation that blocks on failure
- **`check_*`** – Content validation that can produce warnings

### Naming Conventions for Check Functions

All check and precheck functions follow consistent naming patterns defined in `_pkgdown.yml`. The general structure is:

```
check_<area>_<what>()      # Examples: check_meta_label, check_filter_defaults
precheck_<area>_<what>()   # Examples: precheck_col_req_data, precheck_geog_level
```

**Common abbreviations used for brevity:**
- `col` – column
- `meta` – metadata
- `fil_grp` – filter group
- `dupe` – duplicate
- `ind` – indicator
- `dp` – decimal places
- `geog` – geography
- `ob` – observation
- `loc` – location

**Examples of abbreviated function names:**
- `check_meta_dupe_label()` – checks for duplicate indicator labels
- `check_meta_fil_grp()` – validates filter group structure
- `check_meta_fil_grp_is_fil()` – verifies filter group values are filters
- `check_api_char_col_name()` – validates column name character limits for API

### Output Format

All checks return a consistent data frame with columns:
- `check`: Name of the check function
- `result`: "PASS", "FAIL", or "WARNING"
- `message`: Human-readable feedback
- `guidance_url`: Optional link to documentation
- `stage`: Which screening stage the check belongs to

The `screen_csv()` and `screen_dfs()` functions return a list:
```r
list(
  results_table = data.frame(...),     # All check results
  overall_stage = "Precheck columns",  # Where screening stopped
  passed = TRUE/FALSE,                 # Did all required checks pass?
  api_suitable = TRUE/FALSE            # Can be published via API?
)
```

## Code Organization

### R/ Directory – Core Functions

**Main screening:**
- `screen_csv.R` – Entry point for file-based screening
- `screen_dfs.R` – Core logic orchestrating all checks
- `screen_filenames.R` – File naming validation only

**screen_dfs Architecture:**
The `screen_dfs()` function executes checks in stages using the `run_and_log_check()` helper (defined in `utils.R`). This helper:
- Accumulates results across stages
- Adds stage metadata to each check result
- Logs results to JSON (if `log_key` provided)
- Returns early on FAIL (stops further checks)

Code structure: uses shorthand variables `vb` (verbose) and `soe` (stop_on_error) throughout to reduce function call verbosity and improve readability.

**Individual check functions (~39 total):**
- Organized by check type: `precheck_*.R` and `check_*.R`
- Each file contains one public function with roxygen2 documentation
- Checks are composed of simple, focused validation logic
- Must follow consistent argument order: `data/meta` inputs, `verbose = FALSE`, `stop_on_error = FALSE`, then function-specific parameters

**Utilities (R/utils.R):**
- `test_output()` – Standardizes check result data frames
- `null_filename()` – Handles filename display in messages
- `validate_arg_*()` – Argument validation helpers
- `write_json_log()` – Logging infrastructure for API usage
- `run_and_log_check()` – Helper that handles stage management, logging, and early-return logic
- `get_check_name()` – Automatically extracts check name from calling function (reduces hardcoding)
- `get_filters(meta, include_filter_groups = FALSE)` – Returns character vector of filter column names from meta; set `include_filter_groups = TRUE` to also include `filter_grouping_column` values
- `get_filter_groups(meta)` – Returns non-NA, non-blank `filter_grouping_column` values from meta
- `get_cols_meta(meta, ...)` – Extracts column names from meta by type/criteria
- `get_geo_code_cols()` / `get_geo_name_cols()` – Returns geography code/name column name vectors
- `remove_nas_blanks(vector)` – Removes NAs and empty strings from a vector
- `render_url(slug, domain)` – Constructs guidance URLs for `test_output(guidance_url = ...)`

**Always read `R/utils.R` before writing any filtering, extraction, or transformation logic** — many common operations already have helpers.

**Reference data (R/reference_values.R, R/example_datasets.R):**
- Exports acceptable values, time identifiers, filter groups
- Example data for documentation and testing

### data/ Directory – Compiled Reference Data

Pre-computed RDA files loaded at package startup:
- `acceptable_time_ids.rda` – Valid time periods (e.g., "2023/24", "Academic Year")
- `acceptable_indicator_units.rda` – Valid indicator units
- `data_dictionary.rda` – Official EES column specifications
- `api_char_limits.rda` – Character limits for API publishing
- `example_*.rda` – Minimal example datasets for documentation
- `ees_robot_test_data.rda` – Large pre-computed test data

### tests/testthat/ Directory

- One test file per check function: `test-check_*.R`
- Uses testthat framework (edition 3)
- Generally tests both passing and failing cases
- Test data copied from fixtures via `tests/utils/copy_check_data.R`

## Adding a New Check

### Function argument conventions

All `precheck_*()` and `check_*()` functions must follow a consistent argument order:

1. `data` and/or `meta` (the data inputs)
2. `verbose = FALSE`
3. `stop_on_error = FALSE`
4. Any additional function-specific parameters (with defaults)

This allows `screen_dfs()` to call all checks with positional arguments for the common parameters (e.g. `check_foo(data, meta, vb, soe)`). Function-specific parameters must always be passed by name.

When adding a new validation:

1. **Create R file** – `R/check_my_validation.R` with:
   ```r
   #' @export
   check_my_validation <- function(data, meta, verbose = FALSE, stop_on_error = FALSE) {
     check_name <- get_check_name()  # never hardcode the name string
     # validation logic
     test_output(
       check_name,
       "PASS",  # or "FAIL"/"WARNING"
       "message...",
       verbose = verbose,
       stop_on_error = stop_on_error
     )
   }
   ```

2. **Add to screening pipeline** – Call it from `screen_dfs.R` in the appropriate stage

3. **Create test** – `tests/testthat/test-check_my_validation.R` with passing/failing cases

4. **Document** – roxygen2 comments with `@export`, examples, and `@param` descriptions

5. **Update NAMESPACE** – Run `devtools::document()`

## Important Details

### Logging

- When `log_key` and `log_dir` are provided, screening appends JSON logs for API usage
- Each log entry includes results, file metadata, and screening stage

### Large File Handling

- By default, uses `duckplyr` with DuckDB for efficient processing of large CSVs
- The `prudence` parameter in `screen_dfs()` controls memory/speed trade-offs
- Default is "lavish" (conservative memory use)

### Data Dictionary Checks (`dd_checks` parameter)

- Most metadata validation against `data_dictionary.rda` can be disabled via `dd_checks = FALSE`
- This was added to allow test data updates without breaking robot tests

### Special Features

- **Geographic level support** – Checks validate geographic hierarchy consistency
- **Filter groups** – Validates indicator grouping and default selections
- **Time period handling** – Complex validation of time identifiers and 6-week periods
- **API constraints** – Separate validation for API publishing suitability (warnings only)

## Common Development Tasks

### Debugging a Check

```r
# Load test data
data(example_data)
data(example_meta)

# Run a single check
eesyscreener::screen_dfs(example_data, example_meta, verbose = TRUE)

# Run specific check with error handling
eesyscreener::check_my_validation(example_data, example_meta, verbose = TRUE)
```

### Updating Reference Data

Edit the script in `data-raw/`, then run:
```r
devtools::load_all()
source("data-raw/my_data.R")  # Regenerates data/my_data.rda
```

### Generating Documentation

```r
devtools::document()           # Update NAMESPACE and man/ from roxygen2
pkgdown::build_site()         # Generate HTML documentation site
```

### Code Style

- Follows tidyverse style guide
- 2-space indentation (configured in .Rproj)
- Roxygen2 markdown format for documentation
- Tests should be clear and cover both success and failure paths
- Do not include HTML (e.g. `<br>`) in check message strings — messages are used in CLI, API, and Shiny contexts and should be plain text

## Testing Philosophy

- **Prefer package example datasets as the base for test data** — use `rbind()` or `dplyr::mutate()` on `example_data`, `example_meta`, `example_filter_group_wrow`, etc. (see `R/example_datasets.R`) to introduce the failing condition. Only construct a full inline `data.frame()` when no example dataset has the right schema.
- **Extract test data to a local variable** when construction spans more than one line — assign to `bad_data` / `bad_meta` before asserting, then reuse the same variable for both the result check and the `stop_on_error` check. Never construct the same data frame twice in one `test_that()` block.
- Each check should test its happy path and failure conditions
- Avoid mocking; use real but minimal data
- Tests verify both the result and the message text — including both singular and plural forms of messages where applicable (e.g. `"variable was"` vs `"variables were"`)
- **Edge case tests must actually test the edge case** — don't re-run an existing assertion under a different label; construct data that would fail if the edge case were not handled (e.g. set `filter_grouping_column = NA_character_` to verify NAs are ignored, not just re-run the standard PASS case)

### Test Coverage and Integration

The `test-example_output_coverage.R` test ensures that **every exported `check_*()` and `precheck_*()` function is called by `screen_dfs()`**. This test automatically fails if a new check is added but not integrated into the screening pipeline.

When adding a new check:
1. Create the check function and its test file
2. Add the check to the appropriate stage in `screen_dfs()` (see "Adding a New Check" section above)
3. Run tests — the coverage test will confirm integration
4. If the coverage test fails, verify the check is in the correct `run_and_log_check()` block

## Key Files to Know

| File | Purpose |
|------|---------|
| `DESCRIPTION` | Package metadata, dependencies, version |
| `NAMESPACE` | Export declarations (auto-generated from roxygen2) |
| `_pkgdown.yml` | Documentation site configuration |
| `.github/workflows/` | CI/CD pipelines (R-CMD-check, coverage, docs) |
| `eesyscreener.Rproj` | RStudio project file with build settings |
| `MIGRATION_CONTEXT_PACK.md` | Detailed steps and guidelines for migrating code into this package |
| `migration_examples.md` | Examples of functions before and after adding into this package |
