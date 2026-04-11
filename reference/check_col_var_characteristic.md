# Check for characteristic or characteristic_group variable names

Check whether the fields 'characteristic' or 'characteristic_group' have
been included in the metadata. These are not recommended for use with
the EES Table Tool.

## Usage

``` r
check_col_var_characteristic(meta, verbose = FALSE, stop_on_error = FALSE)
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

Other check_col:
[`check_col_ind_smushed()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_col_ind_smushed.md),
[`check_col_snake_case()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_col_snake_case.md),
[`check_col_var_start()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_col_var_start.md)

## Examples

``` r
check_col_var_characteristic(example_meta)
#>                    check result
#> 1 col_var_characteristic   PASS
#>                                                                                                 message
#> 1 Neither 'characteristic' nor 'characteristic_group' were found as listed fields in the metadata file.
#>   guidance_url
#> 1           NA
check_col_var_characteristic(example_meta, verbose = TRUE)
#> ✔ Neither 'characteristic' nor 'characteristic_group' were found as listed fields in the metadata file.
#>                    check result
#> 1 col_var_characteristic   PASS
#>                                                                                                 message
#> 1 Neither 'characteristic' nor 'characteristic_group' were found as listed fields in the metadata file.
#>   guidance_url
#> 1           NA
```
