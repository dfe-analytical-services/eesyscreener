# Check if filter items or location names exceed character limit

Checks if any values in filters, filter groups, or location names exceed
the character limit specified in the `api_char_limits` data frame, using
the `api_char_limit` function.

## Usage

``` r
check_api_char_filter_items(data, meta, verbose = FALSE, stop_on_error = FALSE)
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

Other check_api:
[`check_api_char_col_label()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_api_char_col_label.md),
[`check_api_char_col_name()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_api_char_col_name.md),
[`check_api_char_loc_code()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_api_char_loc_code.md)

## Examples

``` r
check_api_char_filter_items(example_data, example_meta)
#>                   check result
#> 1 api_char_filter_items   PASS
#>                                                                                   message
#> 1 All filter items / location names are less than or equal to the character limit of 120.
#>   guidance_url
#> 1           NA
```
