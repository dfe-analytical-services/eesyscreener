# Check all required columns are present in data

Using the `req_data_cols` object.

## Usage

``` r
precheck_col_req_data(data, verbose = FALSE, stop_on_error = FALSE)
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

Other precheck_col:
[`check_meta_col_name_spaces()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_col_name_spaces.md),
[`precheck_col_invalid_meta()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_col_invalid_meta.md),
[`precheck_col_req_meta()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_col_req_meta.md),
[`precheck_col_to_rows()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_col_to_rows.md)

## Examples

``` r
precheck_col_req_data(example_data)
#>          check result                                                   message
#> 1 col_req_data   PASS All of the required columns are present in the data file.
#>   guidance_url
#> 1           NA
precheck_col_req_data(example_data, verbose = TRUE)
#> ✔ All of the required columns are present in the data file.
#>          check result                                                   message
#> 1 col_req_data   PASS All of the required columns are present in the data file.
#>   guidance_url
#> 1           NA
```
