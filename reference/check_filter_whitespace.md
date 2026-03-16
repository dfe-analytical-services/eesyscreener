# Check no filter values have leading or trailing whitespaces

This function checks if the provided filter values contain any leading
or trailing whitespaces.

## Usage

``` r
check_filter_whitespace(data, meta, verbose = FALSE, stop_on_error = FALSE)
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

Other check_filter:
[`check_filter_defaults()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_filter_defaults.md),
[`check_filter_item_limit()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_filter_item_limit.md)

## Examples

``` r
check_filter_whitespace(example_data, example_meta)
#>               check result
#> 1 filter_whitespace   PASS
#>                                                    message guidance_url
#> 1 No filter labels contain leading or trailing whitespace.           NA
check_filter_whitespace(example_data, example_meta, verbose = TRUE)
#> ✔ No filter labels contain leading or trailing whitespace.
#>               check result
#> 1 filter_whitespace   PASS
#>                                                    message guidance_url
#> 1 No filter labels contain leading or trailing whitespace.           NA
```
