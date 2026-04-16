# Check if location codes exceed a character limit

Uses the `api_char_limit` function to check if any location codes in the
provided metadata frame exceed the character limit specified in the
`api_char_limits` data frame.

## Usage

``` r
check_api_char_loc_code(data, verbose = FALSE, stop_on_error = FALSE)
```

## Arguments

- data:

  A data frame of the data file

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
[`check_api_char_filter_items()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_api_char_filter_items.md)

## Examples

``` r
check_api_char_loc_code(example_data)
#>               check result
#> 1 api_char_loc_code   PASS
#>                                                                   message
#> 1 All location codes are less than or equal to the character limit of 30.
#>   guidance_url
#> 1           NA
```
