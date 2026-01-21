# Check that no col_name values have spaces

Checks the metadata file's col_name column for values that contain
spaces.

## Usage

``` r
check_meta_col_name_spaces(meta, verbose = FALSE, stop_on_error = FALSE)
```

## Arguments

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

## Details

NA in the column names don't contain spaces so won't count and are
validated against elsewhere.'

## See also

Other precheck_col:
[`precheck_col_invalid_meta()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_col_invalid_meta.md),
[`precheck_col_req_data()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_col_req_data.md),
[`precheck_col_req_meta()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_col_req_meta.md),
[`precheck_col_to_rows()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_col_to_rows.md)

## Examples

``` r
check_meta_col_name_spaces(example_meta)
#>             check result                                     message
#> 1 col_name_spaces   PASS There are no spaces in the col_name values.
#>   guidance_url
#> 1           NA
check_meta_col_name_spaces(example_meta, verbose = TRUE)
#> ✔ There are no spaces in the col_name values.
#>             check result                                     message
#> 1 col_name_spaces   PASS There are no spaces in the col_name values.
#>   guidance_url
#> 1           NA
```
