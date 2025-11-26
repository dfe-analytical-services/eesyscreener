# Check for spaces in filename

This function checks if the provided filename contains any spaces.

## Usage

``` r
check_filename_spaces(
  filename,
  custom_name = NULL,
  verbose = FALSE,
  stop_on_error = FALSE
)
```

## Arguments

- filename:

  A character string of the filename to check

- custom_name:

  An optional character string to customize the test name in the output

- verbose:

  logical, if TRUE prints feedback messages to console for every test,
  if FALSE run silently

- stop_on_error:

  logical, if TRUE will stop with an error if the result is "FAIL", and
  will throw genuine warning if result is "WARNING"

## Value

a single row data frame

## See also

Other filename:
[`check_filename_special()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_filename_special.md),
[`check_filenames_match()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_filenames_match.md)

## Examples

``` r
check_filename_spaces("datafile.csv")
#>                    check result
#> 1 check_filename__spaces   PASS
#>                                                message guidance_url
#> 1 'datafile.csv' does not have spaces in the filename.           NA
check_filename_spaces("data file.csv", verbose = TRUE)
#> ✖ There are spaces that need removing in 'data file.csv' (filename).
#>                    check result
#> 1 check_filename__spaces   FAIL
#>                                                              message
#> 1 There are spaces that need removing in 'data file.csv' (filename).
#>   guidance_url
#> 1           NA
check_filename_spaces("datafile.meta.csv", custom_name = "meta")
#>                        check result
#> 1 check_filename_meta_spaces   PASS
#>                                                     message guidance_url
#> 1 'datafile.meta.csv' does not have spaces in the filename.           NA
```
