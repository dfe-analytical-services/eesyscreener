# Check for duplicate rows in data

Checks for duplicate rows across observational unit and filter columns.
School, Provider, Institution, and Planning area rows are handled
specially: when data contains exclusively School or Provider rows, only
Institution and Planning area rows are excluded before checking. In all
other cases, School, Provider, Institution, and Planning area rows are
all excluded from the duplicate check.

## Usage

``` r
check_general_dupes(
  data,
  meta,
  verbose = FALSE,
  stop_on_error = FALSE,
  return_dupes = FALSE
)
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

- return_dupes:

  logical, if TRUE returns a data frame of the rows that are duplicated
  (across observational unit and filter columns) instead of the standard
  check result. All columns from the original data are included. Rows at
  excluded geographic levels are not included. When there are no
  duplicates, an empty data frame with the same columns is returned.
  Defaults to FALSE.

## Value

a single row data frame

## Details

This check is intended to catch cases where there are multiple
observation values for any option that users would be able to select in
the table on EES. If this were to happen there's no guarantee what the
users would see and the data would be compromised. On top of this, this
check will also catch any full duplicate rows at the same time.

To help with debugging, the check can optionally return the rows that
are duplicated across the observational unit and filter columns. This
way users can see which rows are duplicated to help with debugging their
code. Many an adamant analyst has challenged this code and said it was
wrong before, however, every single time the code has been proven right.
General dupes never lies!

## See also

Other check_general:
[`check_general_null()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_general_null.md)

## Examples

``` r
check_general_dupes(example_data, example_meta)
#>           check result
#> 1 general_dupes   PASS
#>                                                                                                                                          message
#> 1 There are no duplicate rows in the data file. Note that School, Provider, Institution, and Planning area rows were not included in this check.
#>   guidance_url
#> 1           NA
check_general_dupes(example_data, example_meta, return_dupes = TRUE)
#> [1] time_period      time_identifier  geographic_level country_code    
#> [5] country_name     sex              education_phase  enrolment_count 
#> <0 rows> (or 0-length row.names)
```
