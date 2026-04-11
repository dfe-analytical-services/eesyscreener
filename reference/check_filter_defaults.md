# Check default filter values are present in data

Ensures that all filter columns and filter groups in the metadata have a
default filter value (usually "Total"), and that this value is present
in the corresponding columns of the data file.

## Usage

``` r
check_filter_defaults(data, meta, verbose = FALSE, stop_on_error = FALSE)
```

## Arguments

- data:

  A character string of the data filename to check

- meta:

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

Other check_filter:
[`check_filter_blanks()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_filter_blanks.md),
[`check_filter_group_level()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_filter_group_level.md),
[`check_filter_item_limit()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_filter_item_limit.md),
[`check_filter_ob_total()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_filter_ob_total.md),
[`check_filter_whitespace()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_filter_whitespace.md)

## Examples

``` r
check_filter_defaults(example_data, example_meta)
#>             check result
#> 1 filter_defaults   PASS
#>                                                      message guidance_url
#> 1 All filters and groups have a default filter item present.           NA
check_filter_defaults(example_filter_group, example_filter_group_meta)
#>             check  result
#> 1 filter_defaults WARNING
#>                                                                                                                                                                        message
#> 1 A 'Total' entry or default filter item should be specified for the following filters and / or filter_groups where applicable: 'education_phase', 'establishment_type_group'.
#>                                                                                                            guidance_url
#> 1 https://dfe-analytical-services.github.io/analysts-guide/statistics-production/ud.html#aggregates-and-default-filters
```
