# Check the mix of time identifiers in the data file

Check that only compatible time identifiers are together in the same
file.

## Usage

``` r
precheck_time_id_mix(data, verbose = FALSE, stop_on_error = FALSE)
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

Other precheck_time:
[`precheck_time_id_valid()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_time_id_valid.md),
[`precheck_time_period_num()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_time_period_num.md)

## Examples

``` r
precheck_time_id_mix(example_data)
#>         check result                                              message
#> 1 time_id_mix   PASS There is only one time_identifier value in the data.
#>   guidance_url
#> 1           NA
```
