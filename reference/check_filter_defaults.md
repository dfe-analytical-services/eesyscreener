# Check filenames line up between data and metadata files

Making sure the data and metadata file follow the pattern of:

- datafile.csv (data file)

- datafile.meta.csv (metadata file)

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
[`check_filter_item_limit()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_filter_item_limit.md),
[`check_filter_whitespace()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_filter_whitespace.md)

## Examples

``` r
check_filter_defaults(example_data, example_meta)
#>                   check result
#> 1 check_filter_defaults   PASS
#>                                                      message guidance_url
#> 1 All filters and groups have a default filter item present.           NA
```
