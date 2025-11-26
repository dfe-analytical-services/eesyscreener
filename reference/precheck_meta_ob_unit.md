# Check there are no observational units with rows in the metadata

Make sure that no observational unit columns are referenced in the
col_name and filter_grouping_column columns.

## Usage

``` r
precheck_meta_ob_unit(meta, verbose = FALSE, stop_on_error = FALSE)
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
[`precheck_meta_col_type()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_meta_col_type.md)

## Examples

``` r
precheck_meta_ob_unit(example_meta)
#>          check result
#> 1 meta_ob_unit   PASS
#>                                                           message guidance_url
#> 1 No observational units have been included in the metadata file.           NA
precheck_meta_ob_unit(example_meta, verbose = TRUE)
#> ✔ No observational units have been included in the metadata file.
#>          check result
#> 1 meta_ob_unit   PASS
#>                                                           message guidance_url
#> 1 No observational units have been included in the metadata file.           NA
```
