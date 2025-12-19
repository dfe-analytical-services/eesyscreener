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
[`check_meta_col_name_duplicate()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_col_name_duplicate.md),
[`check_meta_filter_group()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_filter_group.md),
[`check_meta_filter_group_match()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_filter_group_match.md),
[`check_meta_filter_hint()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_filter_hint.md),
[`check_meta_ind_dp_set()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_ind_dp_set.md),
[`check_meta_label()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_label.md)

## Examples

``` r
check_meta_indicator_dp(example_meta)
#>          check result                                message guidance_url
#> 1 indicator_dp   PASS No filters have an indicator_dp value.           NA
check_meta_indicator_dp(example_meta, verbose = TRUE)
#> ✔ No filters have an indicator_dp value.
#>          check result                                message guidance_url
#> 1 indicator_dp   PASS No filters have an indicator_dp value.           NA
```
