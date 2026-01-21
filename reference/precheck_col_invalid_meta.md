# Check there are no invalid columns in the metadata

Make sure that all column names are expected metadata columns. Checks
across both `req_meta_cols` and `optional_meta_cols`.

## Usage

``` r
precheck_col_invalid_meta(meta, verbose = FALSE, stop_on_error = FALSE)
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

## See also

Other precheck_col:
[`check_meta_col_name_spaces()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_col_name_spaces.md),
[`precheck_col_req_data()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_col_req_data.md),
[`precheck_col_req_meta()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_col_req_meta.md),
[`precheck_col_to_rows()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_col_to_rows.md)

## Examples

``` r
precheck_col_invalid_meta(example_meta)
#>              check result                                            message
#> 1 col_invalid_meta   PASS There are no invalid columns in the metadata file.
#>   guidance_url
#> 1           NA
precheck_col_invalid_meta(example_meta, verbose = TRUE)
#> ✔ There are no invalid columns in the metadata file.
#>              check result                                            message
#> 1 col_invalid_meta   PASS There are no invalid columns in the metadata file.
#>   guidance_url
#> 1           NA
```
