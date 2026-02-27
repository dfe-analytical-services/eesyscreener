# Check that 6 digit time periods give consecutive years

Every 6 digit time identifier should be in the format YYYYZZ where YYYY
is a 4 digit year and ZZ is the final two digits of the following year.

## Usage

``` r
check_time_period_six(data, verbose = FALSE, stop_on_error = FALSE)
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

For example, 202122 is valid but 202120 is not.

## See also

Other check_time:
[`check_time_period()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_time_period.md)

## Examples

``` r
check_time_period_six(example_data)
#>             check result
#> 1 time_period_six   PASS
#>                                                        message guidance_url
#> 1 The six digit time_period values refer to consecutive years.           NA
```
