# Check ethnicity characteristic_group values against standards

Validates that any values in the `characteristic_group` column that
relate to ethnicity data conform to the expected standard conventions.
Values matching the ethnicity pattern ("ethnic", case-insensitive) that
do not contain one of the accepted standard phrases are flagged.

## Usage

``` r
check_harmonised_eth_char_grp(data, verbose = FALSE, stop_on_error = FALSE)
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

Standard phrases are: "Ethnicity Major", "Ethnicity Minor", "Ethnicity
Detailed", and "Minority Ethnic". Combined values are also accepted if
they contain one of these (e.g. "Gender and Minority Ethnic").

If the `characteristic_group` column is absent the check passes
immediately.

## See also

Other check_harmonised:
[`check_harmonised_eth_char_vals()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_harmonised_eth_char_vals.md),
[`check_harmonised_eth_vals()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_harmonised_eth_vals.md),
[`check_harmonised_variables()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_harmonised_variables.md)

## Examples

``` r
check_harmonised_eth_char_grp(example_data)
#>                     check result                               message
#> 1 harmonised_eth_char_grp   PASS No characteristic_group column found.
#>   guidance_url
#> 1           NA
check_harmonised_eth_char_grp(example_data, verbose = TRUE)
#> ✔ No characteristic_group column found.
#>                     check result                               message
#> 1 harmonised_eth_char_grp   PASS No characteristic_group column found.
#>   guidance_url
#> 1           NA
```
