# Check filter items against the data dictionary

Validates that the filter item values in the data are present in the
data dictionary for columns that are listed in the data dictionary.
Filter items not in the data dictionary should not be used in API data
sets.

## Usage

``` r
check_data_dict_fil_item(data, meta, verbose = FALSE, stop_on_error = FALSE)
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

## Details

Only filter columns from the metadata that are also present in the data
dictionary are checked.

## See also

Other check_data_dict:
[`check_data_dict_col_name()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_data_dict_col_name.md)

## Examples

``` r
check_data_dict_fil_item(example_data, example_meta)
#>                check result
#> 1 data_dict_fil_item   PASS
#>                                                     message guidance_url
#> 1 All filter items are consistent with the data dictionary.           NA
check_data_dict_fil_item(example_data, example_meta, verbose = TRUE)
#> ✔ All filter items are consistent with the data dictionary.
#>                check result
#> 1 data_dict_fil_item   PASS
#>                                                     message guidance_url
#> 1 All filter items are consistent with the data dictionary.           NA
```
