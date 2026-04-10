# Check filter groups have an equal or lower number of levels

Ensure all filter groups have an equal or lower number of levels than
their corresponding filter.

## Usage

``` r
check_filter_group_level(data, meta, verbose = TRUE, stop_on_error = FALSE)
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
[`check_filter_item_limit()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_filter_item_limit.md),
[`check_filter_whitespace()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_filter_whitespace.md)

## Examples

``` r
check_filter_group_level(example_data, example_meta)
#> ✔ There are no filter groups present.
#>                check result                             message guidance_url
#> 1 filter_group_level   PASS There are no filter groups present.           NA
```
