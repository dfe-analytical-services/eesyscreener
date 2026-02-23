# Check for spaces in variable names This function checks for spaces in the variable names of a given data frame.

Check for spaces in variable names This function checks for spaces in
the variable names of a given data frame.

## Usage

``` r
check_col_names_spaces(data, verbose = FALSE, stop_on_error = FALSE)
```

## Arguments

- data:

  A data frame to be checked for spaces in variable names.

- verbose:

  Logical, if TRUE prints feedback messages to console for every test,
  if FALSE run silently. Default is FALSE.

- stop_on_error:

  Logical, if TRUE will stop with an error if the result is "FAIL", and
  will throw genuine warning if result is "WARNING". Default is FALSE.

## Value

a single row data frame indicating the result of the check.

## Examples

``` r
check_col_names_spaces(example_data)
#>              check result
#> 1 col_names_spaces   PASS
#>                                                      message guidance_url
#> 1 There are no spaces in the variable names in the datafile.           NA
```
