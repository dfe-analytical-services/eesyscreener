# Check country code and name combinations

Checks that all country_code and country_name combinations in the data
file are valid. Rows where country_code is "x" (the GSS not-available
code) are excluded. All other combinations, including any with blank or
NA codes, are checked against the standard geographies lookup and will
fail if not found.

## Usage

``` r
check_geog_country_combos(data, verbose = FALSE, stop_on_error = FALSE)
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

No geographic_level distinction is made. This matches the legacy
`country_combinations()` behaviour in dfe-published-data-qa, which
filtered out "x" uniformly across all rows. Country columns are
mandatory in the data standard, so blank or NA values at any geographic
level are genuine errors.

## See also

Other check_geog:
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
check_geog_country_combos(example_data)
#>                 check result
#> 1 geog_country_combos   PASS
#>                                                   message guidance_url
#> 1 All country_code / country_name combinations are valid.           NA
check_geog_country_combos(example_data, verbose = TRUE)
#> ✔ All country_code / country_name combinations are valid.
#>                 check result
#> 1 geog_country_combos   PASS
#>                                                   message guidance_url
#> 1 All country_code / country_name combinations are valid.           NA
```
