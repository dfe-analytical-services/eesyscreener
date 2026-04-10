# Check indicator_dp is blank for all filters

Throw an error if, for any filter, indicator_dp is not blank.

## Usage

``` r
check_meta_indicator_dp(meta, verbose = FALSE, stop_on_error = FALSE)
```

## Arguments

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

## See also

Other check_meta:
[`check_meta_col_name_dupe()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_col_name_dupe.md),
[`check_meta_dupe_label()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_dupe_label.md),
[`check_meta_fil_grp()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_fil_grp.md),
[`check_meta_fil_grp_dupe()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_fil_grp_dupe.md),
[`check_meta_fil_grp_is_fil()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_fil_grp_is_fil.md),
[`check_meta_fil_grp_match()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_fil_grp_match.md),
[`check_meta_fil_grp_stripped()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_fil_grp_stripped.md),
[`check_meta_filter_hint()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_filter_hint.md),
[`check_meta_geog_catch()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_geog_catch.md),
[`check_meta_ind_dp_set()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_ind_dp_set.md),
[`check_meta_ind_dp_values()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_ind_dp_values.md),
[`check_meta_ind_unit()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_ind_unit.md),
[`check_meta_ind_unit_validation()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_ind_unit_validation.md),
[`check_meta_indicator_grouping()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_indicator_grouping.md),
[`check_meta_label()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_label.md)

## Examples

``` r
check_meta_indicator_dp(example_meta)
#>               check result                                message guidance_url
#> 1 meta_indicator_dp   PASS No filters have an indicator_dp value.           NA
check_meta_indicator_dp(example_meta, verbose = TRUE)
#> ✔ No filters have an indicator_dp value.
#>               check result                                message guidance_url
#> 1 meta_indicator_dp   PASS No filters have an indicator_dp value.           NA
```
