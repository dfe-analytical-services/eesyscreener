# Contributing to eesyscreener

Ideas for eesyscreener should first be raised as a [GitHub issue](https://github.com/dfe-analytical-services/eesyscreener/issues) after which anyone is free to write the code and create a pull request for review.

Please also read and follow our [Code of Conduct](CODE_OF_CONDUCT.md) when participating in the project.

## Introduction

[Explore education statistics (EES)](https://explore-education-statistics.service.gov.uk/) is our bespoke statistics publishing platform, for it to work we rely on standardising the structure of our data files.

This package contains the checks used to enforce our [open data standards](https://dfe-analytical-services.github.io/analysts-guide/statistics-production/ud.html).

Before contributing, read this guide, skim the package vignettes (especially `assumptions_in_checks.Rmd`), and open up a handful of existing `check_*()` functions with their test files side by side. The checks are small, repetitive and well-exampled — the fastest way to understand how a new one should look is to read an existing one.

## Setting up for development

You'll need R >= 4.2.0 (see `DESCRIPTION`) and RStudio or a similar R-aware editor.

1. Fork the repo on GitHub and clone your fork locally.
2. Install the package's development dependencies:

   ```r
   install.packages("devtools")
   devtools::install_dev_deps()
   ```

3. Install the [`air` formatter](https://posit-dev.github.io/air/) — it is used in the pre-PR checklist and CI expects formatted code. Follow the install instructions on the `air` site for your platform.
4. Sanity-check your setup by loading the package and running the test suite:

   ```r
   devtools::load_all()
   devtools::test()
   ```

   The first run is slow (integration tests screen full CSVs). See [Running and skipping tests](#running-and-skipping-tests) for how to skip them during iteration.

## Before opening a PR

Run through this checklist for every contribution, regardless of what you changed:

1. **Regenerate docs** — `Rscript -e "devtools::document()"` (updates `NAMESPACE` and roxygen `.Rd` files).
2. **Format** — `air format .` from the terminal.
3. **Lint** — `Rscript -e "devtools::load_all(); lintr::lint_package()"`.
4. **Run the full test suite** — `Rscript -e "devtools::test()"`. Do not merge with tests skipped.
5. **Regenerate example output** if you added or changed a check in the pipeline, or updated any `data-raw/` source:

   ```r
   devtools::load_all()
   source("data-raw/example_output.R")
   ```

6. **Update `NEWS.md`** with a bullet under the current development version heading for any user-facing change (new check, new argument, changed behaviour, bug fix). Internal refactors usually do not need an entry.

## Other kinds of contribution

The "How to add a new check" section below is the most detailed recipe because new checks are the most common contribution, but not the only one:

- **Bug fixes** — follow the "Before opening a PR" checklist. Regression tests belong in the existing `tests/testthat/test-<function>.R` file for the function you're fixing.
- **Documentation** — roxygen changes still require `devtools::document()`. Vignette edits require a local `devtools::build_vignettes()` to sanity-check.
- **Reference data** (e.g. new geographic lookups, updated acceptable values) — edit the matching `data-raw/*.R` script and regenerate the `.rda` via `source("data-raw/<script>.R")`. Also regenerate example output afterwards.

## Use the unit tests as documentation

Every `check_*()` and `precheck_*()` function has a matching `tests/testthat/test-<name>.R`. These tests are the **canonical spec** for how a check is supposed to behave — they cover the happy path, the singular and plural failure messages, and any edge cases (NAs, empty strings, "x" codes, etc.).

If you are unsure what a function does or what counts as a valid / invalid input, read its test file first. It is usually quicker than reading the implementation.

Good reference test files to learn from:

- `tests/testthat/test-check_geog_lad_combos.R` – canonical structure for check tests (PASS / singular FAIL / plural FAIL / edge cases)
- `tests/testthat/test-check_meta_dupe_label.R` – typical metadata-only check
- `tests/testthat/test-check_meta_fil_grp_match.R` – data + meta check

## Package structure

The `screen_*()` functions are the key user facing exports of the package. `screen_csv()` is expected to be the primary function used, it takes a pair of CSV files and screens them.

- One script per exported function (except for data objects, or if internal and in `R/utils.R`)
- All individual checks should be named in accordance with the naming conventions (see "Naming conventions" below)
- Due to the extensive use of check / test in this package, internal functions handling argument validation should follow the `validate_arg_*()` convention
- All `check_*()` functions must return a consistent list structure (see "Return value" below)
- All `precheck_*()` and `check_*()` functions must use a consistent argument order: `data` / `meta` inputs first, then `verbose = FALSE`, then `stop_on_error = FALSE`, then any function-specific optional parameters. This enables `screen_dfs()` to call checks with positional arguments.
- **Do NOT validate arguments inside `check_*()` or `precheck_*()`** — validation belongs in the top-level `screen_*()` functions only. See `assumptions_in_checks.Rmd` for why.
- `R/utils.R` contains all internal helpers. **Read it in full before writing any filtering, extraction, or transformation logic** — many common operations already have helpers (e.g. `get_filters()`, `get_geo_code_cols()`, `remove_nas_blanks()`, `render_url()`).
- `data-raw/` contains the source code for example data and hardcoded reference values. Each `data-raw/*.R` script regenerates a matching `data/*.rda`.
- Use RDS as the main format for permanent test data (beware it automatically does some cleaning!), make temp CSV files or create a data.frame in code if needed
- Think about dependencies between functions — document any in `assumptions_in_checks.Rmd`

### Return value

Every check returns `test_output(check_name, result, message, verbose, stop_on_error)` — a single-row data frame with columns: `check`, `result` (`"PASS"` / `"FAIL"` / `"WARNING"`), `message`, `guidance_url`. The `stage` column is added by `run_and_log_check()` when the check runs inside `screen_dfs()`.

### Message patterns

- **PASS**: `"All labels are unique."` / `"The geographic level values are all valid."`
- **FAIL (singular/plural)**: use `cli::pluralize()` so the same message covers one or many failing values: `"The following label {?is/are} duplicated: 'X'."`
- Format failing values: `paste0("'", paste0(values, collapse = "', '"), "'")`
- Plain text only. **Do not include HTML** (`<br>`, `<b>`, etc.) — messages are consumed by CLI, API, and Shiny contexts.

### Dependency rules

- Use the `.data$column_name` pronoun (rlang) in dplyr package code.
- Use the base R pipe `|>` (not `%>%`).
- `cli::cli_abort()` for errors, `cli::cli_warn()` for warnings (not `stop()` / `warning()`).
- All internal helpers go in `R/utils.R` (`@keywords internal`, `@noRd`).

## Naming conventions

Follow these patterns when naming new check functions. Consistency is crucial as names are used in `_pkgdown.yml` to group checks for documentation.

### General pattern

```
check_<area>_<what>()      # Content validation (can produce warnings)
precheck_<area>_<what>()   # Early validation (blocks on failure)
```

### Area prefixes

| Area | Prefix | Notes |
|------|--------|-------|
| Columns | `col_` | Generic column properties |
| Metadata | `meta_` | Metadata file validation |
| Data | `data_` | Data file content validation |
| Filters | `filter_` | Filter group logic |
| Indicators | `ind_` | Indicator-specific rules |
| Geography | `geog_` | Geographic hierarchy validation |
| Time | `time_` | Time period validation |
| API | `api_` | API-specific constraints |
| Filename | `filename_` | File naming conventions |

### Abbreviations for brevity

Use these standard abbreviations in function names to keep them concise while remaining readable:

| Full term | Abbreviation | Context |
|-----------|--------------|---------|
| column | `col` | `check_col_names_spaces` |
| metadata | `meta` | `check_meta_label` |
| filter_group | `fil_grp` | `check_meta_fil_grp` |
| duplicate | `dupe` | `check_meta_dupe_label` |
| is_filter | `is_fil` | `check_meta_fil_grp_is_fil` |
| indicator | `ind` | `check_ind_invalid_entry` |
| decimal_places | `dp` | `check_meta_ind_dp_values` |
| geography | `geog` | `precheck_geog_level` |
| observation_unit | `ob` | `precheck_meta_ob_unit` |
| location | `loc` | `check_api_char_loc_code` |

### Examples

**Good naming:**
- `check_meta_dupe_label()` – finds duplicate indicator labels in metadata
- `check_meta_fil_grp_is_fil()` – validates that filter group items are valid filters
- `check_api_char_col_name()` – validates column name length for API publishing
- `precheck_geog_level()` – ensures geographic level column exists
- `check_filter_defaults()` – validates default filter selections

**Anti-patterns to avoid:**
- `check_metadata_duplicate_indicator_label()` – too verbose
- `check_something_validation()` – redundant (checks are validation by nature)
- `check_foo_and_bar()` – combines too many concepts

### Adding to _pkgdown.yml

When adding a new check:
1. Add a new `check_*()` or `precheck_*()` function following the naming pattern
2. Update `_pkgdown.yml` to include it in the appropriate category section
3. The documentation site will automatically group it with related checks

Example in `_pkgdown.yml`:

```yaml
- title: Metadata checks
  contents:
  - starts_with("check_meta_")
```

This automatically picks up all `check_meta_*` functions.

## How to add a new check

1. **Create the R file** – `R/check_<area>_<what>.R` with the standard signature:

   ```r
   #' @export
   check_my_validation <- function(data, meta, verbose = FALSE, stop_on_error = FALSE) {
     check_name <- get_check_name()  # never hardcode the name string
     # validation logic
     test_output(
       check_name,
       "PASS",  # or "FAIL" / "WARNING"
       "message...",
       verbose = verbose,
       stop_on_error = stop_on_error
     )
   }
   ```

2. **Write the tests first or alongside the function** – see "How to add a new test" below.

3. **Wire it into the pipeline** – add a call in `R/screen_dfs.R` in the appropriate stage (`filename`, `precheck_col`, `precheck_meta`, `check_meta`, `precheck_time`, `check_time`, `precheck_geog`, `check_geog`, `check_filter`, `check_api`) via the existing `run_and_log_check()` / `rbind()` pattern.

4. **Regenerate example output** – required whenever a check is added to the pipeline:

   ```r
   devtools::load_all()
   source("data-raw/example_output.R")
   ```

5. **Document** – roxygen2 with `@export`, `@examples`, and the appropriate `@inheritParams` and `@inherit ... return` tags to avoid duplicating parameter documentation. Pick the nearest donor from the table below:

   | Params needed | Inherit from |
   |---------------|-------------|
   | `meta`, `verbose`, `stop_on_error` | `precheck_meta_col_type` |
   | `data`, `meta`, `verbose`, `stop_on_error` | `precheck_col_to_rows` |
   | `data`, `verbose`, `stop_on_error` | `check_col_names_spaces` |

   Use `@family` tags that match the `_pkgdown.yml` groupings: `filename`, `precheck_col`, `precheck_meta`, `check_meta`, `precheck_time`, `check_time`, `precheck_geog`, `check_geog`, `check_filter`, `check_api`.

6. **Update `_pkgdown.yml`** only if a new section is needed (existing sections pick up new functions automatically via `starts_with()`).

7. **Run through the [Before opening a PR](#before-opening-a-pr) checklist.** The `test-example_output_coverage.R` test will fail if you forgot to wire the check into `screen_dfs()`.

### Canonical function examples

- Meta-only check: `R/check_meta_dupe_label.R`
- Data + meta check: `R/check_meta_fil_grp_match.R`
- Check with reference data: `R/check_geog_region_combos.R` + `data-raw/acceptable_geog_combos.R`

## How to add a new test

Every check has a test file at `tests/testthat/test-<function_name>.R`. **Use `tests/testthat/test-check_geog_lad_combos.R` as the template** — it covers the full shape.

A new test file must cover:

1. **PASS with package example data** – usually `example_data` / `example_meta` straight from `R/example_datasets.R`.
2. **FAIL with a single problem** – asserts the singular message form and checks `guidance_url` where relevant.
3. **FAIL with multiple problems** – asserts the plural message form (`cli::pluralize` output) and exercises `stop_on_error = TRUE` with `expect_error(...)`.
4. **Edge cases** – NAs, empty strings, single values, `"x"` not-available codes, `"z"` universal codes, absent optional columns.

### Building test data

- **Prefer package example datasets as the base** — use `rbind()` or `dplyr::mutate()` on `example_data`, `example_meta`, `example_filter_group_wrow`, etc. (see `R/example_datasets.R`) to introduce the failing condition. Only construct a full inline `data.frame()` when no example dataset has the right schema.
- **Extract multi-line construction to a local variable** – assign to `bad_data` / `bad_meta` before asserting, then reuse the same variable for the result check and the `stop_on_error` check. Never construct the same data frame twice in one `test_that()` block.
- **Edge case tests must actually test the edge case** – don't re-run an existing assertion under a different label; construct data that would fail if the edge case were not handled (e.g. set `filter_grouping_column = NA_character_` to verify NAs are ignored, not just re-run the standard PASS case).

### What not to test

- Do not test argument validation — that is the orchestrator's job, already covered by `test-screen_dfs.R` / `test-screen_csv.R`.
- Do not test `verbose` / `stop_on_error` plumbing — covered generically by `test-test_output.R`.
- Do not test pipeline integration — covered by `test-example_output_coverage.R` and the integration tests.

### Running and skipping tests

By default, all tests run via `Rscript -e "devtools::test()"` (also invoked by `devtools::check()`).

We mix unit tests (quick function tests, a few seconds) with integration tests (full CSV screening, a few minutes). The integration tests are essential for end-to-end coverage on realistic files but slow down iteration. Skip them locally with the `SKIP_INTEGRATION_TESTS` environment variable:

```r
withr::with_envvar(
  c(SKIP_INTEGRATION_TESTS = "true"),
  devtools::test()
)
```

This skips `test-zzz_integration.R`, `test-ees-robot-tests.R`, `test-screen_csv.R` and `test-screen_dfs.R`, bringing the run down from minutes to ~30 seconds. The gating logic lives in `tests/testthat/helper-integration.R`.

Integration tests are skipped on CRAN and in R-CMD-check, but have their own GitHub Action so every PR still covers them.

Always run the full suite (no skip flag) before merging.

## Working with geography

Geography is the most branching area of the package — there are ~18 levels (National, Regional, Local authority, etc.) each with their own code / name columns, lookups and per-level checks. When adding, renaming, or tweaking a geographic level, touch these places:

| File | Role |
|------|------|
| `data-raw/geography_df.R` | The master table of levels and their code / name / secondary-code columns. Edit here first. |
| `data-raw/acceptable_geog_combos.R` | Per-level lookups of valid code / name combinations (e.g. `acceptable_lads`, `acceptable_pcons`). |
| `R/utils.R` | `get_geo_code_cols()` / `get_geo_name_cols()` return the full list of geography code / name columns. These drive several generic checks — update when adding a level. |
| `R/check_geog_combos.R` | Houses `.check_geog_combos()` (shared implementation) plus the thin per-level wrappers (`check_geog_lad_combos()`, `check_geog_pcon_combos()`, etc.). To add a level, add another wrapper that calls `.check_geog_combos()` with the right `code_col`, `name_col`, `acceptable_data`, and `restricted_level`. |
| `R/screen_dfs.R` | Wire the new per-level combos check into the `check_geog` stage. |
| `tests/testthat/test-check_geog_<level>_combos.R` | Copy the closest existing level's test (e.g. `test-check_geog_lad_combos.R`) and adapt. |
| `_pkgdown.yml` | Only needs editing if you rename the section heading; new `check_geog_*` functions are picked up by `starts_with()`. |

After editing `data-raw/`, regenerate the `.rda` files:

```r
devtools::load_all()
source("data-raw/geography_df.R")
source("data-raw/acceptable_geog_combos.R")
```

Then regenerate example output if any check or lookup changed:

```r
source("data-raw/example_output.R")
```

## Stylistic preferences

This package has a big priority on efficiency — we need to keep it fast so the Shiny app and API endpoint stay responsive on large files.

- Profile performance and use the fastest available approach
- Test on large files (5 million rows and above), and prioritise large-file performance over small-file performance
- Avoid duplication between functions — lift shared logic into `R/utils.R`
- Use `dplyr` verbs that `duckplyr` can translate to DuckDB. `data.table` is rarely necessary and would force data.frame ↔ data.table switching.

A worked example is in the commit history — the three approaches for checking `time_identifier` values against `acceptable_time_ids` benchmarked at 3,231 ms (base R) vs 61.6 ms (dplyr) vs 5.7 ms (duckplyr) on a ~6 million row frame. On tiny files the ordering flips, which is why we weight toward the larger file.

If you have issues with linting and dplyr variables showing "no visible binding", follow the [guide to using dplyr in packages](https://cran.r-project.org/web/packages/dplyr/vignettes/in-packages.html).

You can use `tests/utils/benchmarking.R` as a starting point for `microbenchmark` experiments on large tables.

### duckplyr fallbacks and silent materialisation

duckplyr will fall back to plain dplyr (often verbosely) when it cannot translate an operation to DuckDB, and some operations will quietly materialise a lazy table and defeat the performance work. Both categories are worth keeping an eye on.

See the [Diagnosing duckplyr fallbacks](https://dfe-analytical-services.github.io/eesyscreener/articles/duckplyr_fallbacks.html) vignette for the common triggering patterns, patterns that work fine, diagnostic recipes, and how to use `prudence = "stingy"` to catch unintended materialisation. `test-avoid_materialisation.R` runs the materialisation check in CI.
