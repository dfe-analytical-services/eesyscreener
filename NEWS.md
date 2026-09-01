# eesyscreener 0.3.0

Significant rewrite of the package around a consistent `screen_csv()` /
`screen_dfs()` orchestration layer, with all checks following the
`check_*()` / `precheck_*()` naming and return-value conventions.

Performance optimisations including a small file (<5 MB) in-memory screening route.

## New checks

- `check_col_var_start()`
- `check_col_var_characteristic()`
- `check_col_ind_smushed()`
- `check_filter_ob_total()` (migrated from `observational_total`)
- `check_filter_blanks()` (migrated from `blanks_filters`)
- `check_geog_ignored_rows()` (migrated from `ignored_rows`)
- `check_geog_region_for_la()` and `check_geog_region_for_lad()`
  (migrated from `region_for_la`)
- `check_geog_na_code()` and `check_geog_na()`
- `check_geog_other_dupes()` and `check_geog_other_code_dupes()`
- `check_geog_la_col_present()`, `check_geog_region_col_present()`,
  `check_geog_level_completed()`, `check_geog_overcompleted_cols()`
- `check_general_null()` and `check_general_dupes()`
- `precheck_cross_meta_to_data()` and `precheck_cross_data_to_meta()`
- `precheck_filter_not_singular()` (migrated from `filter_level`)
- Data dictionary checks

## Infrastructure

- Geography combo checks consolidated into a single
  `check_geog_combos.R` with thin per-level wrappers.
- Integration tests added to exercise full CSV screening end-to-end.
- Testthat output no longer dumps unrelated messages.

# eesyscreener 0.2.4

- Added `check_meta_filter_group_duplicate()`.
- Added `check_meta_geog_catch()`.
- Added `precheck_geog_level()` (Hackathon/geographic level).
- Added column snake-case validation (Hackathon/col snake case).
- Implemented indicator exclusion for the filter item limit check.

# eesyscreener 0.2.3

- Added `dd_check = FALSE` option to exclude data dictionary checks
  from a screening run.
- Cleared out non-accepted test results.

# eesyscreener 0.2.2

- Filter default check now handles `NA` values in the meta column.
- Clean-up around log file handling and associated tests.

# eesyscreener 0.2.1

- New filter item limit check.
- Added remaining time checks (Hackathon).
- Added indicator unit validation.
- Added indicator decimal-places validation.
- Added data dictionary column name checks.
- Added stripped filter group check.
- Added whitespace-in-filters check.
- Added `check_col_name_spaces()` (equivalent to `data_variable_spaces`).

# eesyscreener 0.2.0

- Bugfix: better handling of commas in strings.
- Added indicator grouping checks.
- Added Docker support with precompiled binaries and instructions.
- Added default filter items check.
- Added `col_name_spaces` and tests (ported from the dashboard).
- Added `check_meta_filter_group_is_filter()`.
- Added `precheck_meta_duplicate_label()`.
- Added result logging.

# eesyscreener 0.1.5

- File read-in now fixes all columns to `VARCHAR` type.

# eesyscreener 0.1.4

- Added filter group checks and filter group match function.
- Scan all rows of CSV to guess file types.
- Removed use of `ncol()` to prevent unnecessary materialisation of
  data.
- Added `check_meta_label()`.

# eesyscreener 0.1.3

- File read-in validation now allows gzipped files as well as CSVs.
- Added filter hint (Hackathon).
- Added `parent_filter` as a legitimate metadata column.
- Added `precheck_col_name_duplicate()`.
- Added `check_meta_indicator_dp()`.

# eesyscreener 0.1.2

- Tidy up DuckDB usage.

# eesyscreener 0.1.1

- Increment version number.

# eesyscreener 0.1.0

- First tagged release. Adds the API to pkgdown.
