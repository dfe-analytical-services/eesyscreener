# Check filter groups are unique when stripping non-alphanumeric characters

Throw error when there are not the same number of unique filter groups
when they are stripped of characters that are not alpha-numeric

## Usage

``` r
check_meta_filter_group_stripped(
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

## See also

Other check_meta:
[`check_meta_col_name_duplicate()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_col_name_duplicate.md),
[`check_meta_duplicate_label()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_duplicate_label.md),
[`check_meta_filter_group()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_filter_group.md),
[`check_meta_filter_group_is_filter()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_filter_group_is_filter.md),
[`check_meta_filter_group_match()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_filter_group_match.md),
[`check_meta_filter_hint()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_filter_hint.md),
[`check_meta_ind_dp_set()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_ind_dp_set.md),
[`check_meta_ind_dp_values()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_ind_dp_values.md),
[`check_meta_ind_unit()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_ind_unit.md),
[`check_meta_indicator_dp()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_indicator_dp.md),
[`check_meta_indicator_grouping()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_indicator_grouping.md),
[`check_meta_label()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_label.md)

## Examples

``` r
check_meta_filter_group_stripped(example_data, example_meta)
#>                   check result                             message guidance_url
#> 1 filter_group_stripped   PASS There are no filter groups present.           NA
check_meta_filter_group_stripped(example_data, example_meta, verbose = TRUE)
#> ✔ There are no filter groups present.
#>                   check result                             message guidance_url
#> 1 filter_group_stripped   PASS There are no filter groups present.           NA
```
