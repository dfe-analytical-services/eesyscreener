# Check all data variables exist in the metadata file

Ensure that every variable in the data file is either an observational
unit, has only a single unique value, or is represented in the metadata
file as either a `col_name` or `filter_grouping_column` entry.

## Usage

``` r
precheck_cross_data_to_meta(data, meta, verbose = FALSE, stop_on_error = FALSE)
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

## See also

Other precheck_cross:
[`precheck_cross_meta_to_data()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_cross_meta_to_data.md)

## Examples

``` r
precheck_cross_data_to_meta(example_data, example_meta)
#>                check result
#> 1 cross_data_to_meta   PASS
#>                                                                                           message
#> 1 All variables in the data file are observational units or are represented in the metadata file.
#>   guidance_url
#> 1           NA
precheck_cross_data_to_meta(example_data, example_meta, verbose = TRUE)
#> ✔ All variables in the data file are observational units or are represented in the metadata file.
#>                check result
#> 1 cross_data_to_meta   PASS
#>                                                                                           message
#> 1 All variables in the data file are observational units or are represented in the metadata file.
#>   guidance_url
#> 1           NA
```
