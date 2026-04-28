# AGENTS.md

This file provides guidance to Claude Code (claude.ai/code) or other AI
agents working in this repository.

**Start here, then read `.github/CONTRIBUTING.md`.** Contributing guide
is the authoritative reference for naming conventions, function
signatures, testing, adding a new check, adding a new geographic level,
duckplyr quirks, and style. This file covers only the agent-specific
workflow: how to run things, which helpers already exist, and where to
look when debugging.

## Project overview

**eesyscreener** is an R package providing data quality assurance (QA)
checks for CSV files uploaded to the [Explore Education Statistics (EES)
platform](https://explore-education-statistics.service.gov.uk/). It’s
used in three main contexts:

1.  **Shiny App** (`dfe-published-data-qa`): interactive web interface
    for users to check files before upload.
2.  **Plumber API** (`ees-screener-api`): automated screening of uploads
    inside EES.
3.  **Direct R usage**: analysts integrating checks into their own data
    preparation pipelines.

## Running things

Run R commands via `Rscript -e "..."` from bash. Chain multiple
expressions with `;`:

``` bash
# Load package in development mode
Rscript -e "devtools::load_all()"

# Run one test file (fastest feedback)
Rscript -e "devtools::test(filter = 'test_name')"

# Run all tests (fast, no build — use this for quick iteration)
Rscript -e "devtools::test()"

# Skip integration tests (~30 s instead of a few minutes)
Rscript -e "withr::with_envvar(c(SKIP_INTEGRATION_TESTS = 'true'), devtools::test())"

# Full R CMD check — build, examples, vignettes, tests. Use before committing / pushing.
Rscript -e "devtools::check()"

# Regenerate NAMESPACE and man/ pages from roxygen2 comments
Rscript -e "devtools::document()"

# Lint the package
Rscript -e "devtools::load_all(); lintr::lint_package()"

# Format R code (run directly in terminal, not via Rscript)
air format .

# Rebuild the pkgdown site
Rscript -e "pkgdown::build_site()"

# Regenerate README.md from README.Rmd (always edit the .Rmd, never the .md directly)
Rscript -e "devtools::build_readme()"
```

If the data dictionary test or example output test fails, first try
regenerating the data objects:

``` bash
Rscript -e "devtools::load_all(); source('data-raw/data_dictionary.R')"
Rscript -e "devtools::load_all(); source('data-raw/example_output.R')"
```

Whenever you add a check to
[`screen_dfs()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_dfs.md),
or change a check’s output, you must regenerate
`data-raw/example_output.R`.

## Key dependencies

- **Core**: dplyr, stringr, tidyr
- **Large file performance**: duckplyr (DuckDB-backed dplyr)
- **Testing**: testthat (edition 3)
- **Documentation**: roxygen2, pkgdown

## Architecture

### Main entry points

1.  **`screen_csv(datapath, metapath, ...)`** (`R/screen_csv.R`) —
    high-level wrapper that reads CSVs from disk, handles file I/O and
    logging, and orchestrates all checks. Returns structured results
    with pass/fail status.
2.  **`screen_dfs(data, meta, ...)`** (`R/screen_dfs.R`) — core
    screening logic operating on data frames. Used internally by
    [`screen_csv()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_csv.md).
    Call directly when data is already in memory.
3.  **`screen_filenames(data_filename, meta_filename)`**
    (`R/screen_filenames.R`) — validates file naming conventions only.

### Check pipeline

Checks run in **stages**, executed sequentially. If any check fails in a
stage, screening stops and returns the failing stage. Ordering matters —
later stages assume earlier ones passed, which simplifies the later
checks. See `vignettes/assumptions_in_checks.Rmd`.

Stages (in order):

1.  **Filename** – naming conventions and special characters
2.  **Precheck columns** – required columns, column count matching
3.  **Precheck meta** – metadata structure and types
4.  **Check meta** – metadata content validation (warnings allowed)
5.  **Precheck time** – time period validity
6.  **Precheck geog** / **Check geog** – geography column presence and
    valid code / name combinations
7.  **Check filter** – filter group logic
8.  **Check API** – API-specific constraints (warnings only, never
    blocks)

Individual functions follow `precheck_*` (blocks on FAIL) or `check_*`
(emits warnings). Naming conventions and abbreviations are in
CONTRIBUTING.md.

### Output format

Every check returns a single-row data frame with columns `check`,
`result` (`"PASS"` / `"FAIL"` / `"WARNING"`), `message`, `guidance_url`.
[`screen_dfs()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_dfs.md)
/
[`screen_csv()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_csv.md)
accumulate these and return:

``` r
list(
  results_table = data.frame(...),     # all check results with added `stage` column
  overall_stage = "Precheck columns",  # stage where screening stopped
  passed = TRUE/FALSE,                 # did all required checks pass?
  api_suitable = TRUE/FALSE            # can be published via API?
)
```

If files cannot be read,
[`screen_csv()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_csv.md)
returns early with `passed = FALSE` and `overall_stage = "File read"`
rather than throwing.

## Code organisation

### `R/` directory

- **`screen_csv.R`, `screen_dfs.R`, `screen_filenames.R`** — entry
  points and orchestration.
- **`check_*.R`, `precheck_*.R`** (~39 files) — one exported function
  per file. Must follow the consistent argument order (`data` / `meta`,
  `verbose`, `stop_on_error`, then any function-specific params).
  Conventions in CONTRIBUTING.md.
- **`utils.R`** — all internal helpers. **Read this in full before
  writing any filtering, extraction, or transformation logic.**
  Highlights:
  - `test_output()` — builds the standardised single-row result data
    frame
  - `get_check_name()` — derives the check name from the calling
    function (never hardcode)
  - `run_and_log_check()` — stage handling, logging, early-return logic
  - `get_filters(meta, include_filter_groups = FALSE)` — filter column
    names
  - `get_filter_groups(meta)` — non-NA filter_grouping_column values
  - `get_cols_meta(meta, ...)` — extract column names by type
  - `get_geo_code_cols()` / `get_geo_name_cols()` — geography code /
    name column vectors
  - `remove_nas_blanks(vector)` — strip NAs and empty strings
  - `render_url(slug, domain)` — build guidance URLs
  - `null_filename()` — filename display helper
  - `validate_arg_*()` — argument validation (only ever called from
    `screen_*()`)
  - `write_json_log()` — logging infrastructure for API usage
- **`reference_values.R`, `example_datasets.R`** — exported reference
  data and example datasets used throughout tests.

### `data/` directory

Pre-computed `.rda` files loaded at package start:

- `acceptable_*.rda` — valid lookups per geography level, time ids,
  indicator units, etc.
- `data_dictionary.rda` — official EES column specifications
- `api_char_limits.rda` — API character limits
- `example_*.rda` — minimal example datasets (used heavily in tests)
- `ees_robot_test_data.rda` — large pre-computed test data
- `geography_df.rda` — master table of geographic levels and their code
  / name columns

Source scripts are in `data-raw/`. Re-run the matching script after
editing to regenerate the `.rda`.

### `tests/testthat/` directory

- One test file per check: `test-check_*.R` / `test-precheck_*.R`.
- Uses testthat edition 3.
- `test-example_output_coverage.R` fails if a new check isn’t wired into
  [`screen_dfs()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_dfs.md).
- Integration tests (`test-zzz_integration.R`, `test-ees-robot-tests.R`,
  `test-screen_csv.R`, `test-screen_dfs.R`) are gated by
  `SKIP_INTEGRATION_TESTS=true` — see CONTRIBUTING.md.
- Canonical examples to mirror: `test-check_geog_lad_combos.R` (full
  shape), `test-check_meta_dupe_label.R` (meta-only),
  `test-check_meta_fil_grp_match.R` (data + meta).

## Adding a new check or test

See CONTRIBUTING.md: “How to add a new check” and “How to add a new
test”. Two agent-specific reminders:

- **Do not validate arguments** inside `check_*()` / `precheck_*()`.
  Validation belongs in `screen_*()`. Revalidating would cost 90+ wasted
  checks per run.
- **Do not hardcode the check name string**. Use
  `check_name <- get_check_name()` so rename-refactors don’t silently
  break messages.

## Debugging a check

``` r
devtools::load_all()

# Run the whole pipeline with verbose output
eesyscreener::screen_dfs(example_data, example_meta, verbose = TRUE)

# Run a single check directly
eesyscreener::check_my_validation(example_data, example_meta, verbose = TRUE)

# Force-throw on FAIL to inspect the call stack
eesyscreener::check_my_validation(example_data, example_meta, stop_on_error = TRUE)
```

### Catching unintended materialisation

Large-file performance depends on `duckplyr` keeping tables lazy. To
check for accidental materialisation:

``` r
eesyscreener::screen_dfs(data, meta, prudence = "stingy")
# if it errors, then:
rlang::last_trace()
```

CI runs `test-avoid_materialisation.R` which exercises this.

### duckplyr fallbacks

When duckplyr can’t translate an operation to DuckDB SQL it emits an
`rlang_message` and falls back to dplyr. Common culprits and diagnosis
steps are in CONTRIBUTING.md under “Diagnosing and fixing duckplyr
fallbacks”.

## Style

- Follows the tidyverse style guide.
- Roxygen2 with markdown format.
- **No HTML in check messages** (no `<br>`, `<b>`, etc.) — messages are
  consumed by CLI, API, and Shiny contexts and must be plain text.
- Plural and singular message forms should be collapsed with
  [`cli::pluralize()`](https://cli.r-lib.org/reference/pluralize.html).
- Base R pipe `|>`, not `%>%`.
- [`cli::cli_abort()`](https://cli.r-lib.org/reference/cli_abort.html) /
  [`cli::cli_warn()`](https://cli.r-lib.org/reference/cli_abort.html),
  not [`stop()`](https://rdrr.io/r/base/stop.html) /
  [`warning()`](https://rdrr.io/r/base/warning.html).

## Key files

| File                                  | Purpose                                                                                                                                                |
|---------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------|
| `DESCRIPTION`                         | Package metadata, dependencies, version                                                                                                                |
| `NAMESPACE`                           | Export declarations (auto-generated from roxygen2)                                                                                                     |
| `_pkgdown.yml`                        | pkgdown site configuration and check groupings                                                                                                         |
| `.github/CONTRIBUTING.md`             | Authoritative contributor guide — conventions, testing, geography, style                                                                               |
| `.github/workflows/`                  | CI/CD pipelines (R-CMD-check, coverage, pkgdown, integration)                                                                                          |
| `vignettes/assumptions_in_checks.Rmd` | Explains check ordering and inter-check assumptions                                                                                                    |
| `README.Rmd`                          | Source for README.md — always edit the `.Rmd` and regenerate with [`devtools::build_readme()`](https://devtools.r-lib.org/reference/build_readme.html) |
