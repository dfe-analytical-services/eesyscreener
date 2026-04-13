# Check geographic level columns are completed

For each geographic level present in the data, checks that the
associated columns (code field, name field, and secondary code field
where applicable) contain no NA values. The `new_la_code` column is
excluded from this check as it can legitimately be blank for older Local
authority records. Rows at Planning area level are excluded as they are
not used in the table tool.

## Usage

``` r
check_geog_level_completed(data, verbose = FALSE, stop_on_error = FALSE)
```

## Arguments

- data:

  A data frame of the data file

- verbose:

  logical, if TRUE prints feedback messages to console for every test,
  if FALSE run silently

- stop_on_error:

  logical, if TRUE will stop with an error if the result is "FAIL", and
  will throw genuine warning if result is "WARNING"

## Value

a single row data frame

## Details

Three cases result in a silent PASS, each intentionally caught by a
dedicated check elsewhere in the screening pipeline:

- **Planning area rows**: excluded here; flagged by
  [`check_geog_ignored_rows()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_ignored_rows.md).

- **Invalid geographic levels** (not present in `geography_df`): skipped
  here; caught upstream by
  [`precheck_geog_level()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_geog_level.md).

- **Missing geography columns** (e.g. `region_code` absent from the data
  entirely): silently skipped here; caught by
  [`check_geog_la_col_present()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_la_col_present.md)
  and
  [`check_geog_region_col_present()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_region_col_present.md).

## See also

Other check_geog:
[`check_geog_country_combos()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_country_combos.md),
[`check_geog_eda_combos()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_eda_combos.md),
[`check_geog_ignored_rows()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_ignored_rows.md),
[`check_geog_la_col_present()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_la_col_present.md),
[`check_geog_la_combos()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_la_combos.md),
[`check_geog_lad_combos()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_lad_combos.md),
[`check_geog_lep_combos()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_lep_combos.md),
[`check_geog_lsip_combos()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_lsip_combos.md),
[`check_geog_na()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_na.md),
[`check_geog_na_code()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_na_code.md),
[`check_geog_other_code_dupes()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_other_code_dupes.md),
[`check_geog_other_dupes()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_other_dupes.md),
[`check_geog_pcon_combos()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_pcon_combos.md),
[`check_geog_region_col_present()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_region_col_present.md),
[`check_geog_region_combos()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_region_combos.md),
[`check_geog_region_for_la()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_region_for_la.md),
[`check_geog_region_for_lad()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_region_for_lad.md),
[`check_geog_ward_combos()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_ward_combos.md)

## Examples

``` r
check_geog_level_completed(example_data)
#>                  check result
#> 1 geog_level_completed   PASS
#>                                                   message guidance_url
#> 1 All geographic level columns are completed as expected.           NA
check_geog_level_completed(example_data, verbose = TRUE)
#> ✔ All geographic level columns are completed as expected.
#>                  check result
#> 1 geog_level_completed   PASS
#>                                                   message guidance_url
#> 1 All geographic level columns are completed as expected.           NA
```
