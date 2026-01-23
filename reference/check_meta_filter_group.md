# Check filter_group is not set for indicator rows

Throw warning if there are any indicator rows that have filter_group as
non-blank, to encourage users to correct the metadata.

## Usage

``` r
check_meta_filter_group(meta, verbose = FALSE, stop_on_error = FALSE)
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
[`check_meta_filter_group_is_filter()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_filter_group_is_filter.md),
[`check_meta_filter_group_match()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_filter_group_match.md),
[`check_meta_filter_hint()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_filter_hint.md),
[`check_meta_ind_dp_set()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_ind_dp_set.md),
[`check_meta_indicator_dp()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_indicator_dp.md),
[`check_meta_indicator_grouping()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_indicator_grouping.md),
[`check_meta_label()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_label.md)

## Examples

``` r
check_meta_filter_group(example_meta)
#>           check result                                            message
#> 1 meta_col_name   PASS No indicators have a filter_grouping_column value.
#>   guidance_url
#> 1           NA
check_meta_filter_group(example_meta, verbose = TRUE)
#> ✔ No indicators have a filter_grouping_column value.
#>           check result                                            message
#> 1 meta_col_name   PASS No indicators have a filter_grouping_column value.
#>   guidance_url
#> 1           NA
```
