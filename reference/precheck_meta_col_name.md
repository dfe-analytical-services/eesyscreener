# Check col_name is completed for all rows

Ensure there are no blank cells for col_name in the metafile.

## Usage

``` r
precheck_meta_col_name(meta, verbose = FALSE, stop_on_error = FALSE)
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
[`precheck_meta_col_type()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_meta_col_type.md),
[`precheck_meta_ob_unit()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_meta_ob_unit.md)

## Examples

``` r
precheck_meta_col_name(example_meta)
#>           check result
#> 1 meta_col_name   PASS
#>                                                           message guidance_url
#> 1 The col_name column is completed for every row in the metadata.           NA
precheck_meta_col_name(example_meta, verbose = TRUE)
#> ✔ The col_name column is completed for every row in the metadata.
#>           check result
#> 1 meta_col_name   PASS
#>                                                           message guidance_url
#> 1 The col_name column is completed for every row in the metadata.           NA
```
