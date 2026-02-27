# Check that time periods match the time identifier

Every time identifier is only compatible with either 4 or 6 digit time
periods.

## Usage

``` r
check_time_period(data, verbose = FALSE, stop_on_error = FALSE)
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

Other check_time:
[`check_time_period_six()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_time_period_six.md)

## Examples

``` r
check_time_period(example_data)
#>         check result
#> 1 time_period   PASS
#>                                                                       message
#> 1 The time_period length matches the time_identifier values in the data file.
#>   guidance_url
#> 1           NA
```
