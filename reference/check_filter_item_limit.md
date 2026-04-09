# Check number of filter items are below limit Ensures that no filter contains more than 25,000 unique options, this is to protect the EES service against accidental data issues that can cause performance issues within the admin system.

Check number of filter items are below limit Ensures that no filter
contains more than 25,000 unique options, this is to protect the EES
service against accidental data issues that can cause performance issues
within the admin system.

## Usage

``` r
check_filter_item_limit(
  data,
  meta,
  filter_item_limit = 25000,
  verbose = FALSE,
  stop_on_error = FALSE
)
```

## Arguments

- data:

  A character string of the data filename to check

- meta:

  A character string of the metadata filename to check

- filter_item_limit:

  The maximum number of unique items allowed in a single filter. Default
  as used by the screener: 25000

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
[`check_filter_whitespace()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_filter_whitespace.md)

## Examples

``` r
check_filter_item_limit(example_data, example_meta)
#>                     check result
#> 1 check_filter_item_limit   PASS
#>                                                       message guidance_url
#> 1 All filters and groups have less than 25000 unique entries.           NA
```
