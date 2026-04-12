# Migration Context Pack

Reference document for migrating legacy R Shiny checks from [dfe-published-data-qa](https://github.com/dfe-analytical-services/dfe-published-data-qa/) into the `eesyscreener` R package. See also `.github/CONTRIBUTING.md`.

---

## 1. Migration Principles

Functions from `dfe-published-data-qa` (primarily `R/mainTests.r`, `R/preCheck1.r`, `R/preCheck2.r`, `R/knownVariables.r`) are extracted one-at-a-time into a standalone, tested R package.

- One check at a time. Simplify during migration — do not carry over legacy complexity unnecessarily.
- Speed is king. Prefer dplyr (duckplyr-compatible) over base R. Avoid forcing materialisation of lazy data frames.
- Minimise new dependencies. Prefer base R or dplyr.
- Strip HTML tags from all message strings — plain text only.

---

## 2. Naming & File Conventions

| Entity | Convention | Example |
|--------|-----------|---------|
| Exported check | `check_<area>_<what>()` | `check_meta_dupe_label()` |
| Exported precheck | `precheck_<area>_<what>()` | `precheck_geog_level()` |
| Exported screen | `screen_<scope>()` | `screen_csv()` |
| Internal validator | `validate_arg_<what>()` | `validate_arg_dfs()` |
| Test name (in `test_output()`) | Short snake_case, no `check_`/`precheck_` prefix | `"meta_dupe_label"` |
| R file | Match function name exactly | `R/check_meta_dupe_label.R` |
| Test file | `test-<function_name>.R` | `tests/testthat/test-check_meta_dupe_label.R` |

Use standard abbreviations from CONTRIBUTING.md (e.g. `dupe`, `fil_grp`, `ind`). Check names in `_pkgdown.yml` must match these conventions.

### Function signature (mandatory argument order)

```r
check_something <- function(data, meta, verbose = FALSE, stop_on_error = FALSE)
```

`data`/`meta` first, then `verbose`, then `stop_on_error`, then any function-specific optional params (always passed by name at call sites). This fixed order lets `screen_dfs()` call checks positionally.

**Do NOT validate arguments inside `check_*()` or `precheck_*()`** — validation belongs in `screen_*()` orchestrators via `validate_arg_*()`.

### Return value

Every check returns `test_output(check_name, result, message, verbose, stop_on_error)` — a single-row data frame with columns: `check`, `result` (`"PASS"`/`"FAIL"`/`"WARNING"`), `message`, `guidance_url`.

### Message patterns

- **PASS**: `"All labels are unique."` / `"The geographic level values are all valid."`
- **FAIL**: Use `cli::pluralize()` for singular/plural: `"The following label is/are duplicated: 'X'."`
- Format failing values: `paste0("'", paste0(values, collapse = "', '"), "'")`

### Dependency rules

- Use `.data$column_name` pronoun (rlang) in dplyr package code.
- Use base R pipe `|>` (not `%>%`).
- `cli::cli_abort()` for errors, `cli::cli_warn()` for warnings (not `stop()`/`warning()`).
- All internal helpers go in `R/utils.R` (`@keywords internal`, `@noRd`). **Read `R/utils.R` in full before writing any new logic** — many helpers already exist.

---

## 3. Documentation Conventions

Every exported function needs:

```r
#' Title (sentence case)
#'
#' Description.
#'
#' @inheritParams precheck_meta_col_type   # or precheck_col_to_rows / check_col_names_spaces
#' @inherit check_filename_spaces return
#' @family check_meta                      # match _pkgdown.yml grouping
#' @examples
#' check_something(example_meta)
#' check_something(example_meta, verbose = TRUE)
#' @export
```

Key `@inheritParams` sources:

| Params needed | Inherit from |
|---------------|-------------|
| `meta`, `verbose`, `stop_on_error` | `precheck_meta_col_type` |
| `data`, `meta`, `verbose`, `stop_on_error` | `precheck_col_to_rows` |
| `data`, `verbose`, `stop_on_error` | `check_col_names_spaces` |

Family tags (must match `_pkgdown.yml`): `filename`, `precheck_col`, `precheck_meta`, `check_meta`, `precheck_time`, `check_time`, `precheck_geog`, `check_filter`, `check_api`.

---

## 4. Testing Conventions

Canonical test file reference: `tests/testthat/test-check_geog_lad_combos.R`

Every test file must cover:

1. PASS with package example data (also `expect_no_error(..., stop_on_error = TRUE)`)
2. FAIL with one problem (singular message form)
3. FAIL with multiple problems (plural message form, `expect_error(..., stop_on_error = TRUE)`)
4. Edge cases: NAs, empty strings, single values

Prefer building on package example datasets via `rbind()` or `dplyr::mutate()` over fully inline `data.frame()` construction. Only use inline construction when no example dataset provides the required schema.

Do NOT test argument validation (that's the orchestrator's job) or pipeline integration (that's `test-screen_dfs.R`).

---

## 5. Migration Workflow

**Before starting**: create a branch `claude/<function-name>` off latest `main`.

| Step | Action |
|------|--------|
| 1. Analyse | Find function in legacy repo. Identify inputs, outputs, hardcoded reference data. Read `R/utils.R` in full. |
| 2. Create function file | `R/<name>.R` with standard signature, `test_output()` returns, full roxygen2 docs, two `@examples`. |
| 3. Reference data | If using `R/knownVariables.r` values: create `data-raw/` script, run it, document in `R/reference_values.R`. If from a CSV: `render_url("data/file.csv", domain = "screener_app_repo")` — see `data-raw/` for existing examples. |
| 4. Wire into pipeline | Add to appropriate stage in `R/screen_dfs.R` via `rbind()`. |
| 4b. Regenerate example output | `devtools::load_all(); source("data-raw/example_output.R")` — required whenever a check is added to the pipeline. |
| 5. Write tests | `tests/testthat/test-<name>.R` — see Section 4. |
| 6. Format & document | `air format .` (terminal, not R), then `devtools::document()`. Add to `_pkgdown.yml` if new section needed. |
| 7. Verify | `devtools::test()` — all tests must pass. |
| 8. Simplify | Replace `sapply` with vectorised/dplyr. Consolidate singular/plural messages with `cli::pluralize()`. Re-run tests, format, lint: `devtools::load_all(); lintr::lint_package()`. |
| 9. Commit & PR | Commit function + tests + NAMESPACE + man pages + screen_dfs.R + any data. PR title: `"Add <function_name>()"`. Description: what it checks, legacy source file/function, any in-flight conflicts. |
| 10. CI | Confirm all GitHub Actions pass; fix failures in a follow-up commit. |

### Canonical function examples

- Meta-only check: `R/check_meta_duplicate_label.R`
- Data + meta check: `R/check_meta_fil_grp_match.R`
- Check with reference data: `R/check_geog_region_combos.R` + `data-raw/acceptable_regions.R`

---

## 6. What a Migration PR Contains

Function file, test file, `NAMESPACE`, `man/` pages, `R/screen_dfs.R`, `data/example_output.rda`. Plus `data/*.rda` + `data-raw/*.R` and `_pkgdown.yml` only if new reference data or a new section is needed.
