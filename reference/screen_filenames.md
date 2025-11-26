# Run all checks against filenames

Run all of the checks from the package that relate to the names of the
files themselves.

## Usage

``` r
screen_filenames(
  datafilename,
  metafilename,
  verbose = FALSE,
  stop_on_error = FALSE
)
```

## Arguments

- datafilename:

  Character string, name of the data file

- metafilename:

  Character string, name of the metadata file

- verbose:

  Logical, if TRUE prints feedback messages to console for every test,
  if FALSE run silently

- stop_on_error:

  Logical, if TRUE will stop with an error if the result is "FAIL", and
  will throw genuine warning if result is "WARNING"

## Value

data.frame containing the results of the screening

## Details

Provide a pair of filenames, e.g. "myfile.csv" and "myfile.meta.csv" and
it will check they follow the filename conventions.

## Examples

``` r
screen_filenames("myfile.csv", "myfile.meta.csv")
#>                             check result
#> 1      check_filename_data_spaces   PASS
#> 2  check_filename_metadata_spaces   PASS
#> 3     check_filename_data_special   PASS
#> 4 check_filename_metadata_special   PASS
#> 5           check_filenames_match   PASS
#>                                                            message guidance_url
#> 1               'myfile.csv' does not have spaces in the filename.           NA
#> 2          'myfile.meta.csv' does not have spaces in the filename.           NA
#> 3            'myfile.csv' does not contain any special characters.           NA
#> 4       'myfile.meta.csv' does not contain any special characters.           NA
#> 5 The names of the files follow the recommended naming convention.           NA
#>      stage
#> 1 filename
#> 2 filename
#> 3 filename
#> 4 filename
#> 5 filename
screen_filenames("myfile.csv", "mymeta.csv", verbose = TRUE)
#> ✔ 'myfile.csv' does not have spaces in the filename.
#> ✔ 'mymeta.csv' does not have spaces in the filename.
#> ✔ 'myfile.csv' does not contain any special characters.
#> ✔ 'mymeta.csv' does not contain any special characters.
#> ✖ The filenames do not follow the recommended naming convention. Based on the given data filename, the metadata filename is expected to be 'myfile.meta.csv''.
#> ✔ Filenames passed all checks
#>                             check result
#> 1      check_filename_data_spaces   PASS
#> 2  check_filename_metadata_spaces   PASS
#> 3     check_filename_data_special   PASS
#> 4 check_filename_metadata_special   PASS
#> 5           check_filenames_match   FAIL
#>                                                                                                                                                        message
#> 1                                                                                                           'myfile.csv' does not have spaces in the filename.
#> 2                                                                                                           'mymeta.csv' does not have spaces in the filename.
#> 3                                                                                                        'myfile.csv' does not contain any special characters.
#> 4                                                                                                        'mymeta.csv' does not contain any special characters.
#> 5 The filenames do not follow the recommended naming convention. Based on the given data filename, the metadata filename is expected to be 'myfile.meta.csv''.
#>   guidance_url    stage
#> 1           NA filename
#> 2           NA filename
#> 3           NA filename
#> 4           NA filename
#> 5           NA filename
```
