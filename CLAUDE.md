# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**eesyscreener** is an R package providing data quality assurance (QA) checks for CSV files uploaded to the Explore Education Statistics (EES) platform. It's used in three main contexts:

1. **Shiny App** (`dfe-published-data-qa`): Interactive web interface for users to check files before upload
2. **Plumber API** (`ees-screener-api`): Automated screening of uploads in the EES platform itself
3. **Direct R Usage**: Analysts integrating checks into their own data preparation pipelines

## Development Setup

### Running R from the Terminal

R is not on the bash PATH. Always invoke it with the full Windows path:

```bash
"/c/Program Files/R/R-4.5.3/bin/Rscript.exe" -e "..."
```

### Building and Running Tests

```bash
# Load package in development mode (requires R with devtools)
devtools::load_all()

# Run all tests
devtools::test()

# Run tests for a specific file
devtools::test(filter = "test_name")

# Check the package (equivalent to R CMD check)
devtools::check()

# Generate documentation from roxygen2 comments
devtools::document()

# Rebuild the documentation site
pkgdown::build_site()
```

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

**Individual check functions (~39 total):**
- Organized by check type: `precheck_*.R` and `check_*.R`
- Each file contains one public function with roxygen2 documentation
- Checks are composed of simple, focused validation logic

**Utilities (R/utils.R):**
- `test_output()` – Standardizes check result data frames
- `null_filename()` – Handles filename display in messages
- `validate_arg_*()` – Argument validation helpers
- `write_json_log()` – Logging infrastructure for API usage

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

When adding a new validation:

1. **Create R file** – `R/check_my_validation.R` with:
   ```r
   #' @export
   check_my_validation <- function(data, meta, verbose = FALSE, stop_on_error = FALSE) {
     # validation logic
     test_output(
       "check_my_validation",
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

- Tests use example datasets built into the package
- Each check should test its happy path and failure conditions
- Avoid mocking; use real but minimal data
- Tests verify both the result and the message text

## Key Files to Know

| File | Purpose |
|------|---------|
| `DESCRIPTION` | Package metadata, dependencies, version |
| `NAMESPACE` | Export declarations (auto-generated from roxygen2) |
| `_pkgdown.yml` | Documentation site configuration |
| `.github/workflows/` | CI/CD pipelines (R-CMD-check, coverage, docs) |
| `eesyscreener.Rproj` | RStudio project file with build settings |
