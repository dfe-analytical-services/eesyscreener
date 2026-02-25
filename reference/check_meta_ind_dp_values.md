# Check indicator_dp only contains blanks or positive integer values.

This function checks that The indicator_dp column only contains blanks
or positive integer values.

## Usage

``` r
check_meta_ind_dp_values(meta, verbose = FALSE, stop_on_error = FALSE)
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
[`check_meta_duplicate_label()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_duplicate_label.md),
[`check_meta_filter_group()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_filter_group.md),
[`check_meta_filter_group_is_filter()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_filter_group_is_filter.md),
[`check_meta_filter_group_match()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_filter_group_match.md),
[`check_meta_filter_group_stripped()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_filter_group_stripped.md),
[`check_meta_filter_hint()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_filter_hint.md),
[`check_meta_ind_dp_set()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_ind_dp_set.md),
[`check_meta_ind_unit()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_ind_unit.md),
[`check_meta_indicator_dp()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_indicator_dp.md),
[`check_meta_indicator_grouping()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_indicator_grouping.md),
[`check_meta_label()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_label.md)

## Examples

``` r
check_meta_ind_dp_values(example_meta)
#>           check result
#> 1 ind_dp_values   PASS
#>                                                                           message
#> 1 The indicator_dp column only contains blanks, zero, or positive integer values.
#>   guidance_url
#> 1           NA
check_meta_ind_dp_values(example_meta, verbose = TRUE)
#> ✔ The indicator_dp column only contains blanks, zero, or positive integer values.
#>           check result
#> 1 ind_dp_values   PASS
#>                                                                           message
#> 1 The indicator_dp column only contains blanks, zero, or positive integer values.
#>   guidance_url
#> 1           NA
```
