# Check parliamentary constituency code and name combinations

Checks that all pcon_code and pcon_name combinations in the data file
are valid. For Parliamentary constituency rows, all combinations must be
valid. For non-PCON rows, only non-empty, non-NA combinations are
checked. Rows where pcon_code is "x" (the GSS not-available code) are
excluded from non-PCON checks.

## Usage

``` r
check_geog_pcon_combos(data, verbose = FALSE, stop_on_error = FALSE)
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

If either pcon column is absent from the data, the check passes
immediately.

## See also

Other check_geog:
[`check_geog_country_combos()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_country_combos.md),
[`check_geog_eda_combos()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_eda_combos.md),
[`check_geog_ignored_rows()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_ignored_rows.md),
[`check_geog_la_combos()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_la_combos.md),
[`check_geog_lad_combos()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_lad_combos.md),
[`check_geog_lep_combos()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_lep_combos.md),
[`check_geog_lsip_combos()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_lsip_combos.md),
[`check_geog_na()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_na.md),
[`check_geog_na_code()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_na_code.md),
[`check_geog_other_dupes()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_other_dupes.md),
[`check_geog_region_combos()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_region_combos.md),
[`check_geog_region_for_la()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_region_for_la.md),
[`check_geog_region_for_lad()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_region_for_lad.md),
[`check_geog_ward_combos()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_ward_combos.md)

## Examples

``` r
check_geog_pcon_combos(example_data)
#>              check result
#> 1 geog_pcon_combos   PASS
#>                                                                               message
#> 1 At least one of the pcon_code / pcon_name columns is not present in this data file.
#>   guidance_url
#> 1           NA
check_geog_pcon_combos(example_data, verbose = TRUE)
#> ✔ At least one of the pcon_code / pcon_name columns is not present in this data file.
#>              check result
#> 1 geog_pcon_combos   PASS
#>                                                                               message
#> 1 At least one of the pcon_code / pcon_name columns is not present in this data file.
#>   guidance_url
#> 1           NA
```
