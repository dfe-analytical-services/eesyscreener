# Check NA geography codes have the correct name

For geographic levels that have both a code and a name column, checks
that any location with the GSS not-available code `"x"` also has the
corresponding name `"Not available"`. Applies to all geographic levels
except those with their own combinations checks, RSC region,
Institution, and Planning area.

## Usage

``` r
check_geog_na(data, verbose = FALSE, stop_on_error = FALSE)
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
[`check_geog_na_code()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_na_code.md),
[`check_geog_other_code_dupes()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_other_code_dupes.md),
[`check_geog_other_dupes()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_other_dupes.md),
[`check_geog_overcompleted_cols()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_overcompleted_cols.md),
[`check_geog_pcon_combos()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_pcon_combos.md),
[`check_geog_region_col_present()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_region_col_present.md),
[`check_geog_region_combos()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_region_combos.md),
[`check_geog_region_for_la()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_region_for_la.md),
[`check_geog_region_for_lad()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_region_for_lad.md),
[`check_geog_ward_combos()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_ward_combos.md)

## Examples

``` r
check_geog_na(example_data)
#>     check result                                  message guidance_url
#> 1 geog_na   PASS No applicable geographic levels to test.           NA
check_geog_na(example_data, verbose = TRUE)
#> ✔ No applicable geographic levels to test.
#>     check result                                  message guidance_url
#> 1 geog_na   PASS No applicable geographic levels to test.           NA
```
