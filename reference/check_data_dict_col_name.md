# Check col_names against the data dictionary

Validates that the filter and indicator column names in the metadata are
present in the data dictionary. Columns not in the data dictionary
should not be used in API data sets.

## Usage

``` r
check_data_dict_col_name(meta, verbose = FALSE, stop_on_error = FALSE)
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

Other check_data_dict:
[`check_data_dict_fil_item()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_data_dict_fil_item.md)

## Examples

``` r
check_data_dict_col_name(example_meta)
#>                check result
#> 1 data_dict_col_name   PASS
#>                                                  message guidance_url
#> 1 All col_names are consistent with the data dictionary.           NA
check_data_dict_col_name(example_meta, verbose = TRUE)
#> ✔ All col_names are consistent with the data dictionary.
#>                check result
#> 1 data_dict_col_name   PASS
#>                                                  message guidance_url
#> 1 All col_names are consistent with the data dictionary.           NA
```
