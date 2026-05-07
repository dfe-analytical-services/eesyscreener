# Check all time_identifier values are valid

Checks against the `acceptable_time_identifiers` object.

## Usage

``` r
precheck_time_id_valid(data, verbose = FALSE, stop_on_error = FALSE)
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
[`precheck_time_period_num()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_time_period_num.md)

## Examples

``` r
precheck_time_id_valid(example_data)
#>           check result                                   message guidance_url
#> 1 time_id_valid   PASS The time_identifier values are all valid.           NA
#>           duration
#> 1 0.002240658 secs
```
