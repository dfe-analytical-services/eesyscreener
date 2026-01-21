# Quick check of data columns vs metadata rows

There are 5 mandatory observational unit columns in every data file, so
there should always be at least 5 more columns in the data file than
there are rows in the metadata file.

## Usage

``` r
precheck_col_to_rows(data, meta, verbose = FALSE, stop_on_error = FALSE)
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

Other precheck_col:
[`check_meta_col_name_spaces()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_col_name_spaces.md),
[`precheck_col_invalid_meta()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_col_invalid_meta.md),
[`precheck_col_req_data()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_col_req_data.md),
[`precheck_col_req_meta()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_col_req_meta.md)

## Examples

``` r
precheck_col_to_rows(example_data, example_meta)
#>         check result
#> 1 col_to_rows   PASS
#>                                                                                                      message
#> 1 There are an equal number of rows in the metadata file (3) and non-mandatory columns in the data file (3).
#>   guidance_url
#> 1           NA
precheck_col_to_rows(example_data, example_meta, verbose = TRUE)
#> ✔ There are an equal number of rows in the metadata file (3) and non-mandatory columns in the data file (3).
#>         check result
#> 1 col_to_rows   PASS
#>                                                                                                      message
#> 1 There are an equal number of rows in the metadata file (3) and non-mandatory columns in the data file (3).
#>   guidance_url
#> 1           NA
```
