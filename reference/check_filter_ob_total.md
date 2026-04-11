# Check for Total or All values in observational unit columns

Checks that no observational unit columns (time period, geographic, or
other known structural columns) contain "Total", "total", "All", or
"all" as values. These aggregate placeholders should only appear in
filter columns, not in observation unit columns. Rows containing them in
ob unit columns indicate incorrectly structured data.

## Usage

``` r
check_filter_ob_total(data, meta, verbose = FALSE, stop_on_error = FALSE)
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

School-level and provider-level data where `school_name` or
`provider_name` is the only filter are exempt, as these are acceptable
as filters in that context.

## See also

Other check_filter:
[`check_filter_defaults()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_filter_defaults.md),
[`check_filter_group_level()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_filter_group_level.md),
[`check_filter_item_limit()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_filter_item_limit.md),
[`check_filter_whitespace()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_filter_whitespace.md)

## Examples

``` r
check_filter_ob_total(example_data, example_meta)
#>             check result
#> 1 filter_ob_total   PASS
#>                                                               message
#> 1 There are no Total or All values in the observational unit columns.
#>   guidance_url
#> 1           NA
check_filter_ob_total(example_data, example_meta, verbose = TRUE)
#> ✔ There are no Total or All values in the observational unit columns.
#>             check result
#> 1 filter_ob_total   PASS
#>                                                               message
#> 1 There are no Total or All values in the observational unit columns.
#>   guidance_url
#> 1           NA
```
