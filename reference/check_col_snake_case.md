# Check that column names follow snake_case convention

Check if all column names in the data file follow the snake_case
convention (lowercase letters, numbers, and underscores only). Flags any
capital letters or special characters as a warning.

## Usage

``` r
check_col_snake_case(data, verbose = FALSE, stop_on_error = FALSE)
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
[`check_col_var_start()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_col_var_start.md)

## Examples

``` r
check_col_snake_case(example_data)
#>            check result
#> 1 col_snake_case   PASS
#>                                                                 message
#> 1 The variable names in the data file follow the snake_case convention.
#>   guidance_url
#> 1           NA
check_col_snake_case(example_data, verbose = TRUE)
#> ✔ The variable names in the data file follow the snake_case convention.
#>            check result
#> 1 col_snake_case   PASS
#>                                                                 message
#> 1 The variable names in the data file follow the snake_case convention.
#>   guidance_url
#> 1           NA
```
