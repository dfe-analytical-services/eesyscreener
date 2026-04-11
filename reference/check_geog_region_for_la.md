# Check that region columns are complete for Local authority rows

Checks that `region_code` and `region_name` columns are present in the
data file and contain no missing values for rows at the Local authority
geographic level. Regional information should ideally be provided for
all Local authority level data.

## Usage

``` r
check_geog_region_for_la(data, verbose = FALSE, stop_on_error = FALSE)
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

## Details

If no Local authority level data is present in the file, the check
passes immediately.

## See also

Other check_geog:
[`check_geog_ignored_rows()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_ignored_rows.md),
[`check_geog_region_for_lad()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_region_for_lad.md)

## Examples

``` r
check_geog_region_for_la(example_data)
#>                check result
#> 1 geog_region_for_la   PASS
#>                                                    message guidance_url
#> 1 There is no Local authority level data in the data file.           NA
```
