# Check indicator_dp is set for all indicator rows

Throw warning if there are any blank cells for indicator_dp in rows, to
encourage users to explicitly specify the behaviour they want.

## Usage

``` r
check_meta_ind_dp_set(meta, verbose = FALSE, stop_on_error = FALSE)
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
[`check_meta_filter_group_match()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_filter_group_match.md),
[`check_meta_filter_hint()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_filter_hint.md),
[`check_meta_indicator_dp()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_indicator_dp.md),
[`check_meta_label()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_label.md)

## Examples

``` r
check_meta_ind_dp_set(example_meta)
#>             check result
#> 1 meta_ind_dp_set   PASS
#>                                                    message guidance_url
#> 1 The indicator_dp column is completed for all indicators.           NA
check_meta_ind_dp_set(example_meta, verbose = TRUE)
#> ✔ The indicator_dp column is completed for all indicators.
#>             check result
#> 1 meta_ind_dp_set   PASS
#>                                                    message guidance_url
#> 1 The indicator_dp column is completed for all indicators.           NA
```
