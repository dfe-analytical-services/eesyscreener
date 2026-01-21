# Check all required columns are present in metadata

Using the `req_meta_cols` object.

## Usage

``` r
precheck_col_req_meta(meta, verbose = FALSE, stop_on_error = FALSE)
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
[`precheck_col_invalid_meta()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_col_invalid_meta.md),
[`precheck_col_req_data()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_col_req_data.md),
[`precheck_col_to_rows()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_col_to_rows.md)

## Examples

``` r
precheck_col_req_meta(example_meta)
#>          check result
#> 1 col_req_meta   PASS
#>                                                         message guidance_url
#> 1 All of the required columns are present in the metadata file.           NA
precheck_col_req_meta(example_meta, verbose = TRUE)
#> ✔ All of the required columns are present in the metadata file.
#>          check result
#> 1 col_req_meta   PASS
#>                                                         message guidance_url
#> 1 All of the required columns are present in the metadata file.           NA
```
