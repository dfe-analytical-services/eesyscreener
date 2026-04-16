# Check ethnicity column values against GSS standards

Validates that the values in `ethnicity_major` and/or `ethnicity_minor`
columns in the data file conform to the GSS ethnicity standards. When
both columns are present, major and minor value pairs are checked
together. When only one column is present, its values are checked
independently.

## Usage

``` r
check_harmonised_eth_vals(data, verbose = FALSE, stop_on_error = FALSE)
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

If neither column is present the check passes immediately.

## See also

Other check_harmonised:
[`check_harmonised_eth_char_grp()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_harmonised_eth_char_grp.md),
[`check_harmonised_eth_char_vals()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_harmonised_eth_char_vals.md),
[`check_harmonised_variables()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_harmonised_variables.md)

## Examples

``` r
check_harmonised_eth_vals(example_data)
#>                 check result                     message guidance_url
#> 1 harmonised_eth_vals   PASS No ethnicity columns found.           NA
check_harmonised_eth_vals(example_data, verbose = TRUE)
#> ✔ No ethnicity columns found.
#>                 check result                     message guidance_url
#> 1 harmonised_eth_vals   PASS No ethnicity columns found.           NA
```
