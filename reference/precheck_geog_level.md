# Check that the geographic_level values are all valid.

Throw an error if geographic_level values used in the data file are not
present in the list of acceptable geographic levels

## Usage

``` r
precheck_geog_level(data, verbose = FALSE, stop_on_error = FALSE)
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

Other precheck_geog:
[`precheck_geog_level_present()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_geog_level_present.md)

## Examples

``` r
precheck_geog_level(example_data)
#>        check result                                    message guidance_url
#> 1 geog_level   PASS The geographic_level values are all valid.           NA
precheck_geog_level(example_data, verbose = TRUE)
#> ✔ The geographic_level values are all valid.
#>        check result                                    message guidance_url
#> 1 geog_level   PASS The geographic_level values are all valid.           NA
```
