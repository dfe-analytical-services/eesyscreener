# Check 'Not available' location codes

Checks that for geographic levels with code and name column pairs, any
location with a name of 'Not available' has the corresponding GSS
not-available code 'x'. Levels without a code column (RSC region) and
levels with their own combo lookups (National, Regional etc) are
excluded. Rows at Institution and Planning area level are also excluded
as they are ignored by EES.

## Usage

``` r
check_geog_na_code(data, verbose = FALSE, stop_on_error = FALSE)
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

If no applicable geographic levels are present in the data, the check
passes immediately.

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
check_geog_na_code(example_data)
#>          check result
#> 1 geog_na_code   PASS
#>                                                               message
#> 1 No applicable geographic levels to check for 'Not available' codes.
#>   guidance_url
#> 1           NA
check_geog_na_code(example_data, verbose = TRUE)
#> ✔ No applicable geographic levels to check for 'Not available' codes.
#>          check result
#> 1 geog_na_code   PASS
#>                                                               message
#> 1 No applicable geographic levels to check for 'Not available' codes.
#>   guidance_url
#> 1           NA
```
