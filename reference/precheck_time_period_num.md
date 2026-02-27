# Check for any non-numeric time_period values

Check that all time_period values are numeric.

## Usage

``` r
precheck_time_period_num(data, verbose = FALSE, stop_on_error = FALSE)
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
[`precheck_time_id_mix()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_time_id_mix.md),
[`precheck_time_id_valid()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_time_id_valid.md)

## Examples

``` r
precheck_time_period_num(example_data)
#>             check result                                              message
#> 1 time_period_num   PASS The time_period column only contains numeric values.
#>   guidance_url
#> 1           NA
```
