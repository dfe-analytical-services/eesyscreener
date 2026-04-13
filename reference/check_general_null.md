# Check for null and legacy no-data symbols

Checks for null-like values (such as "NULL", "NA", and similar) in the
data and metadata files, and for legacy no-data symbols (such as "N/A",
".", "..") in the data file.

## Usage

``` r
check_general_null(data, meta, verbose = FALSE, stop_on_error = FALSE)
```

## Arguments

- data:

  A data frame of the data file

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

## Details

Null-like symbols cause a failure; finding legacy no-data symbols
produces a warning. The GSS provides guidance on the accepted symbols to
use for representing missing or suppressed data.

## See also

Other check_general:
[`check_general_dupes()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_general_dupes.md)

## Examples

``` r
check_general_null(example_data, example_meta)
#>          check result
#> 1 general_null   PASS
#>                                                                                   message
#> 1 No problematic null or legacy no-data symbols were found in the data or metadata files.
#>   guidance_url
#> 1           NA
```
