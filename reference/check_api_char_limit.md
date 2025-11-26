# Check if values exceed a character limit

Can be used to check individual strings, or vectors of strings.

## Usage

``` r
check_api_char_limit(values, type, verbose = FALSE, stop_on_error = FALSE)
```

## Arguments

- values:

  A character vector of strings to check

- type:

  A character string specifying the type of values being checked, one of
  "location-code", "column-name", "column-label" or "column-item".

- verbose:

  Logical, if TRUE prints feedback messages to console for every test,
  if FALSE run silently

- stop_on_error:

  Logical, if TRUE will stop with an error if the result is "FAIL", and
  will throw genuine warning if result is "WARNING"

## Value

a single row data frame

## Details

Uses the exported `api_char_limits` data.frame as a reference for the
limits.

## Examples

``` r
check_api_char_limit(names(example_data), "column-name")
#>                              check result
#> 1 check_api_char_limit_column-name   PASS
#>                                                                             message
#> 1 All filter / indicator names are less than or equal to the character limit of 50.
#>   guidance_url
#> 1           NA
check_api_char_limit(names(example_data), "column-name", verbose = TRUE)
#> ✔ All filter / indicator names are less than or equal to the character limit of 50.
#>                              check result
#> 1 check_api_char_limit_column-name   PASS
#>                                                                             message
#> 1 All filter / indicator names are less than or equal to the character limit of 50.
#>   guidance_url
#> 1           NA
```
