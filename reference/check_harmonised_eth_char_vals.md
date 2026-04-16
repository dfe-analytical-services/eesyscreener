# Check ethnicity characteristic values against GSS standards

Validates that `characteristic` values for rows where
`characteristic_group` relates to ethnicity conform to the GSS ethnicity
standards. Values are checked against the union of all accepted
ethnicity major and minor values.

## Usage

``` r
check_harmonised_eth_char_vals(data, verbose = FALSE, stop_on_error = FALSE)
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

## Details

If either the `characteristic_group` or `characteristic` column is
absent the check passes immediately.

## See also

Other check_harmonised:
[`check_harmonised_eth_char_grp()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_harmonised_eth_char_grp.md),
[`check_harmonised_eth_vals()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_harmonised_eth_vals.md),
[`check_harmonised_variables()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_harmonised_variables.md)

## Examples

``` r
check_harmonised_eth_char_vals(example_data)
#>                      check result
#> 1 harmonised_eth_char_vals   PASS
#>                                                     message guidance_url
#> 1 No characteristic_group and characteristic columns found.           NA
check_harmonised_eth_char_vals(example_data, verbose = TRUE)
#> ✔ No characteristic_group and characteristic columns found.
#>                      check result
#> 1 harmonised_eth_char_vals   PASS
#>                                                     message guidance_url
#> 1 No characteristic_group and characteristic columns found.           NA
```
