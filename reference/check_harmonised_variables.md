# Check col names against harmonised data standards

Validates that the column names and filter grouping column names in the
metadata are not using non-standard names for variables covered by the
DfE harmonised data standards. Any column name that matches a harmonised
variable search pattern but is not one of the accepted standard names
will fail.

## Usage

``` r
check_harmonised_variables(meta, verbose = FALSE, stop_on_error = FALSE)
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

Other check_harmonised:
[`check_harmonised_eth_char_grp()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_harmonised_eth_char_grp.md),
[`check_harmonised_eth_char_vals()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_harmonised_eth_char_vals.md),
[`check_harmonised_eth_vals()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_harmonised_eth_vals.md)

## Examples

``` r
check_harmonised_variables(example_meta)
#>                  check result                                   message
#> 1 harmonised_variables   PASS No standardised column name issues found.
#>   guidance_url
#> 1           NA
check_harmonised_variables(example_meta, verbose = TRUE)
#> ✔ No standardised column name issues found.
#>                  check result                                   message
#> 1 harmonised_variables   PASS No standardised column name issues found.
#>   guidance_url
#> 1           NA
```
