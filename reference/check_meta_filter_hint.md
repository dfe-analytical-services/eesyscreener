# Check filter_hint is not set for indicator rows

Throw warning if there are any indicator rows that have filter_hint as
non-blank, to encourage users to correct the metadata.

## Usage

``` r
check_meta_filter_hint(meta, verbose = FALSE, stop_on_error = FALSE)
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
[`check_meta_ind_dp_set()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_ind_dp_set.md)

## Examples

``` r
check_meta_filter_hint(example_meta)
#>           check result                                 message guidance_url
#> 1 meta_col_name   PASS No indicators have a filter_hint value.           NA
check_meta_filter_hint(example_meta, verbose = TRUE)
#> ✔ No indicators have a filter_hint value.
#>           check result                                 message guidance_url
#> 1 meta_col_name   PASS No indicators have a filter_hint value.           NA
```
