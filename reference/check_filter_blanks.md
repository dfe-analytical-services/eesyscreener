# Check for blank values in filter and filter group columns

Checks that no filter or filter group columns contain blank (empty
string) values. Every cell in a filter or filter group column must have
a value. If a row represents no specific breakdown, such as 'All
genders', the value should be 'Total' rather than left blank.

## Usage

``` r
check_filter_blanks(data, meta, verbose = FALSE, stop_on_error = FALSE)
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

## See also

Other check_filter:
[`check_filter_defaults()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_filter_defaults.md),
[`check_filter_group_level()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_filter_group_level.md),
[`check_filter_item_limit()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_filter_item_limit.md),
[`check_filter_ob_total()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_filter_ob_total.md),
[`check_filter_whitespace()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_filter_whitespace.md)

## Examples

``` r
check_filter_blanks(example_data, example_meta)
#>           check result
#> 1 filter_blanks   PASS
#>                                                            message guidance_url
#> 1 There are no blank values in any filter or filter group columns.           NA
check_filter_blanks(example_data, example_meta, verbose = TRUE)
#> ✔ There are no blank values in any filter or filter group columns.
#>           check result
#> 1 filter_blanks   PASS
#>                                                            message guidance_url
#> 1 There are no blank values in any filter or filter group columns.           NA
```
