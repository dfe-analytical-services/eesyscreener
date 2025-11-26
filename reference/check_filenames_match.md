# Check filenames line up between data and metadata files

Making sure the data and metadata file follow the pattern of:

- datafile.csv (data file)

- datafile.meta.csv (metadata file)

## Usage

``` r
check_filenames_match(
  datafilename,
  metafilename,
  verbose = FALSE,
  stop_on_error = FALSE
)
```

## Arguments

- datafilename:

  A character string of the data filename to check

- metafilename:

  A character string of the metadata filename to check

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
[`check_filename_special()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_filename_special.md)

## Examples

``` r
check_filenames_match("datafile.csv", "datafile.meta.csv")
#>                   check result
#> 1 check_filenames_match   PASS
#>                                                            message guidance_url
#> 1 The names of the files follow the recommended naming convention.           NA
check_filenames_match("datafile.csv", "metafile.csv", verbose = TRUE)
#> ✖ The filenames do not follow the recommended naming convention. Based on the given data filename, the metadata filename is expected to be 'datafile.meta.csv''.
#>                   check result
#> 1 check_filenames_match   FAIL
#>                                                                                                                                                          message
#> 1 The filenames do not follow the recommended naming convention. Based on the given data filename, the metadata filename is expected to be 'datafile.meta.csv''.
#>   guidance_url
#> 1           NA
```
