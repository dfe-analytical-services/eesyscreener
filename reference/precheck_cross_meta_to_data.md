# Check all metadata variables exist in the data file

Ensure that every variable named in the metadata file can be found as a
column in the data file. This covers both `col_name` entries and any
`filter_grouping_column` values.

## Usage

``` r
precheck_cross_meta_to_data(data, meta, verbose = FALSE, stop_on_error = FALSE)
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
precheck_cross_meta_to_data(example_data, example_meta)
#>                check result
#> 1 cross_meta_to_data   PASS
#>                                                        message guidance_url
#> 1 All variables from the metadata were found in the data file.           NA
precheck_cross_meta_to_data(example_data, example_meta, verbose = TRUE)
#> ✔ All variables from the metadata were found in the data file.
#>                check result
#> 1 cross_meta_to_data   PASS
#>                                                        message guidance_url
#> 1 All variables from the metadata were found in the data file.           NA
```
