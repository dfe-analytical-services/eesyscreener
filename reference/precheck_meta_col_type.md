# Check col_type entries are valid

Make sure that all col_type values are either 'Filter' or 'Indicator'

## Usage

``` r
precheck_meta_col_type(meta, verbose = FALSE, stop_on_error = FALSE)
```

## Arguments

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

Other precheck_meta:
[`precheck_meta_col_name()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_meta_col_name.md),
[`precheck_meta_ob_unit()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_meta_ob_unit.md)

## Examples

``` r
precheck_meta_col_type(example_meta)
#>           check result                                     message guidance_url
#> 1 meta_col_type   PASS col_type is always 'Filter' or 'Indicator'.           NA
precheck_meta_col_type(example_meta, verbose = TRUE)
#> ✔ col_type is always 'Filter' or 'Indicator'.
#>           check result                                     message guidance_url
#> 1 meta_col_type   PASS col_type is always 'Filter' or 'Indicator'.           NA
```
