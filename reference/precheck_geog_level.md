# Check that the geographic_level values are all valid.

Throw an error if geographic_level values used in the data file are not
present in the list of acceptable geographic levels

## Usage

``` r
precheck_geog_level(data, verbose = FALSE, stop_on_error = FALSE)
```

## Arguments

- data:

  A data frame to be checked for spaces in variable names.

- verbose:

  Logical, if TRUE prints feedback messages to console for every test,
  if FALSE run silently. Default is FALSE.

- stop_on_error:

  Logical, if TRUE will stop with an error if the result is "FAIL", and
  will throw genuine warning if result is "WARNING". Default is FALSE.

## Value

a single row data frame

## Examples

``` r
precheck_geog_level(example_data)
#>              check result                                    message
#> 1 geographic_level   PASS The geographic_level values are all valid.
#>   guidance_url
#> 1           NA
precheck_geog_level(example_data, verbose = TRUE)
#> ✔ The geographic_level values are all valid.
#>              check result                                    message
#> 1 geographic_level   PASS The geographic_level values are all valid.
#>   guidance_url
#> 1           NA
```
