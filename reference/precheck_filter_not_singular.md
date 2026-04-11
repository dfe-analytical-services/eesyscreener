# Check all filters have more than one level

Validates that every filter column in the data has at least two distinct
values. A filter with only one level provides no analytical value and
should be removed from the metadata.

## Usage

``` r
precheck_filter_not_singular(
  data,
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
)
```

## Arguments

- data:

  A data frame of the data file

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

## Examples

``` r
precheck_filter_not_singular(example_data, example_meta)
#>                 check result                              message guidance_url
#> 1 filter_not_singular   PASS All filters have two or more levels.           NA
precheck_filter_not_singular(example_data, example_meta, verbose = TRUE)
#> ✔ All filters have two or more levels.
#>                 check result                              message guidance_url
#> 1 filter_not_singular   PASS All filters have two or more levels.           NA
```
