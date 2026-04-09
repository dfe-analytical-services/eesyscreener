# Check we have the right columns for the geographic level

Check we have the right columns for the geographic level

## Usage

``` r
precheck_geog_level_present(data, verbose = FALSE, stop_on_error = FALSE)
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
[`precheck_geog_level()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_geog_level.md)

## Examples

``` r
precheck_geog_level_present(example_data)
#>                         check result
#> 1 precheck_geog_level_present   PASS
#>                                          message guidance_url
#> 1 There is only National level data in the file.           NA
precheck_geog_level_present(example_data, verbose = TRUE)
#> ✔ There is only National level data in the file.
#>                         check result
#> 1 precheck_geog_level_present   PASS
#>                                          message guidance_url
#> 1 There is only National level data in the file.           NA
precheck_geog_level_present(example_comma_data, verbose = TRUE)
#> ✔ The geography columns are present as expected for the geographic_level values in the file.
#>                         check result
#> 1 precheck_geog_level_present   PASS
#>                                                                                      message
#> 1 The geography columns are present as expected for the geographic_level values in the file.
#>   guidance_url
#> 1           NA
```
