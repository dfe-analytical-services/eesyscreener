# Check there are no duplicated column names

Make sure that all column names are unique.

## Usage

``` r
check_meta_col_name_duplicate(meta, verbose = FALSE, stop_on_error = FALSE)
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

Other check_meta:
[`check_meta_ind_dp_set()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_ind_dp_set.md)

## Examples

``` r
check_meta_col_name_duplicate(example_meta)
#>                check result                         message guidance_url
#> 1 col_name_duplicate   PASS All col_name values are unique.           NA
check_meta_col_name_duplicate(example_meta, verbose = TRUE)
#> ✔ All col_name values are unique.
#>                check result                         message guidance_url
#> 1 col_name_duplicate   PASS All col_name values are unique.           NA
```
