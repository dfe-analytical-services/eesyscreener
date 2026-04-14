# Check for geographic columns completed for unexpected rows

Checks that geographic columns (code, name, secondary code) are only
populated for rows where the geographic_level is compatible with that
column.

## Usage

``` r
check_geog_overcompleted_cols(
  data,
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
)
```

## Arguments

- data:

  A data frame of the data file

- meta:

  A data frame of the metadata file

- verbose:

  logical, if TRUE prints feedback messages to console for every test,
  if FALSE run silently

- stop_on_error:

  logical, if TRUE will stop with an error if the result is "FAIL", and
  will throw genuine warning if result is "WARNING"

## Value

a single row data frame

## Details

Geographic data files often contain rows at multiple levels (e.g.
National, Regional, and Local authority). A lower-level row is expected
to carry its parent geography's codes — a Local authority row should
have `region_code` filled in because every LA sits within a region. The
reverse is not true: a Regional row should not have `new_la_code` filled
in, because a region is not a single LA.

The `compatible_levels` table inside this function encodes which
`geographic_level` values are allowed to have each geography's columns
populated. For most geographies this means: the level itself, plus any
lower-level geographies that are geographically nested within it (e.g.
School, Ward). RSC regions, MATs, and Sponsors are treated differently —
they do not map onto the standard regional hierarchy, so Regional
columns are not expected to be populated for those rows.

Two exceptions apply:

- **National columns** (`country_code`, `country_name`) are expected at
  every level and are never checked.

- **School and Provider name columns** — if the school or provider name
  is the only filter in the metadata it is treated as a label column
  that will be populated for all rows, so it is skipped.

## See also

Other check_geog:
[`check_geog_country_combos()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_country_combos.md),
[`check_geog_eda_combos()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_eda_combos.md),
[`check_geog_ignored_rows()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_ignored_rows.md),
[`check_geog_la_col_present()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_la_col_present.md),
[`check_geog_la_combos()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_la_combos.md),
[`check_geog_lad_combos()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_lad_combos.md),
[`check_geog_lep_combos()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_lep_combos.md),
[`check_geog_level_completed()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_level_completed.md),
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
check_geog_overcompleted_cols(example_data, example_meta)
#>                     check result
#> 1 geog_overcompleted_cols   PASS
#>                                            message guidance_url
#> 1 All geographic columns are empty where expected.           NA
check_geog_overcompleted_cols(example_data, example_meta, verbose = TRUE)
#> ✔ All geographic columns are empty where expected.
#>                     check result
#> 1 geog_overcompleted_cols   PASS
#>                                            message guidance_url
#> 1 All geographic columns are empty where expected.           NA
```
