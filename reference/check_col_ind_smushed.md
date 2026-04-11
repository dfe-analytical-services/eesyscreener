# Check that no indicator column names contain typical filter entries

Checks the metadata file for any indicators that appear to be 'smushed'.
Flags any indicator col_name that contains common filter entries (e.g.
male, female, asian, black, etc), which suggests the data may not
conform to tidy data principles and should instead be pivoted longer
with a filter column to contain the characteristic choices.

## Usage

``` r
check_col_ind_smushed(meta, verbose = FALSE, stop_on_error = FALSE)
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
[`check_col_snake_case()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_col_snake_case.md),
[`check_col_var_characteristic()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_col_var_characteristic.md),
[`check_col_var_start()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_col_var_start.md)

## Examples

``` r
check_col_ind_smushed(example_meta)
#>             check result                                                message
#> 1 col_ind_smushed   PASS No indicators found containing typical filter entries.
#>   guidance_url
#> 1           NA
check_col_ind_smushed(example_meta, verbose = TRUE)
#> ✔ No indicators found containing typical filter entries.
#>             check result                                                message
#> 1 col_ind_smushed   PASS No indicators found containing typical filter entries.
#>   guidance_url
#> 1           NA
```
