# Check for rows ignored by the EES table tool

Identifies rows at geographic levels that are ignored by the EES table
tool: School, Provider, Institution, and Planning area. Highlights in
the message if any such rows are present alongside other levels, and
fails if:

- School and Provider data have been mixed together OR

- The file only contains Planning area or Institution data

## Usage

``` r
check_geog_ignored_rows(data, verbose = FALSE, stop_on_error = FALSE)
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

Other check_geog:
[`check_geog_region_for_la()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_region_for_la.md),
[`check_geog_region_for_lad()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_region_for_lad.md)

## Examples

``` r
check_geog_ignored_rows(example_data)
#>               check result
#> 1 geog_ignored_rows   PASS
#>                                                      message guidance_url
#> 1 No rows in the file will be ignored by the EES table tool.           NA
```
