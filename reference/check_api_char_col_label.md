# Check if column labels exceed a character limit

Uses the `api_char_limit` function to check if any column labels in the
provided metadata frame exceed the character limit specified in the
`api_char_limits` data frame.

## Usage

``` r
check_api_char_col_label(meta, verbose = FALSE, stop_on_error = FALSE)
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

Other check_api:
[`check_api_char_col_name()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_api_char_col_name.md),
[`check_api_char_filter_items()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_api_char_filter_items.md),
[`check_api_char_loc_code()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_api_char_loc_code.md),
[`check_api_dict_col_names()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_api_dict_col_names.md)

## Examples

``` r
check_api_char_col_label(example_meta)
#>                check result
#> 1 api_char_col_label   PASS
#>                                                                               message
#> 1 All filter / indicator labels are less than or equal to the character limit of 100.
#>   guidance_url
#> 1           NA
```
