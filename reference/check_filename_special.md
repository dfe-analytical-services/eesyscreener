# Check for special characters in filename

This function checks if the provided filename contains any special
characters.

## Usage

``` r
check_filename_special(
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
[`check_filename_spaces()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_filename_spaces.md),
[`check_filenames_match()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_filenames_match.md)

## Examples

``` r
check_filename_special("datafile.csv")
#>                     check result
#> 1 check_filename__special   PASS
#>                                                   message guidance_url
#> 1 'datafile.csv' does not contain any special characters.           NA
check_filename_special("data+file.meta.csv", verbose = TRUE)
#> ✖ The following special characters need removing from data+file.meta.csv (filename): +. Filenames must only contain numbers, letters, hyphens or underscores.
#>                     check result
#> 1 check_filename__special   FAIL
#>                                                                                                                                                       message
#> 1 The following special characters need removing from data+file.meta.csv (filename): +. Filenames must only contain numbers, letters, hyphens or underscores.
#>   guidance_url
#> 1           NA
check_filename_special("datafile.meta.csv", custom_name = "meta")
#>                         check result
#> 1 check_filename_meta_special   PASS
#>                                                        message guidance_url
#> 1 'datafile.meta.csv' does not contain any special characters.           NA
```
