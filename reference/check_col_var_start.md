# Check that variable names start with a lowercase letter

Check that all variable names in the data file start with a lowercase
letter. Flags any variables that start with a non-lowercase character as
a warning.

## Usage

``` r
check_col_var_start(data, verbose = FALSE, stop_on_error = FALSE)
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

Other check_col:
[`check_col_snake_case()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_col_snake_case.md)

## Examples

``` r
check_col_var_start(example_data)
#>           check result
#> 1 col_var_start   PASS
#>                                                              message
#> 1 All variable names in the data file start with a lowercase letter.
#>   guidance_url
#> 1           NA
check_col_var_start(example_data, verbose = TRUE)
#> ✔ All variable names in the data file start with a lowercase letter.
#>           check result
#> 1 col_var_start   PASS
#>                                                              message
#> 1 All variable names in the data file start with a lowercase letter.
#>   guidance_url
#> 1           NA
```
