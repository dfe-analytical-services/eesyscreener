# Check every row has a label

Ensure there are no blank cells in the label column for every row in the
metafile

## Usage

``` r
check_meta_label(meta, verbose = FALSE, stop_on_error = FALSE)
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
[`check_meta_indicator_dp()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_indicator_dp.md)

## Examples

``` r
check_meta_label(example_meta)
#>              check result
#> 1 check_meta_label   PASS
#>                                                        message guidance_url
#> 1 The label column is completed for every row in the metadata.           NA
check_meta_label(example_meta, verbose = TRUE)
#> ✔ The label column is completed for every row in the metadata.
#>              check result
#> 1 check_meta_label   PASS
#>                                                        message guidance_url
#> 1 The label column is completed for every row in the metadata.           NA
```
