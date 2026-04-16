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
#>                check  result
#> 1 data_dict_fil_item WARNING
#>                                                                                                                                                                                                          message
#> 1 The following col_name / filter_item combinations are not present in the data dictionary and should not be used as part of an API data set until resolved: 'education_phase / All phases', 'sex / All pupils'.
#>                                                                                             guidance_url
#> 1 https://dfe-analytical-services.github.io/analysts-guide/statistics-production/api-data-standards.html
check_data_dict_fil_item(example_data, example_meta, verbose = TRUE)
#> ! The following col_name / filter_item combinations are not present in the data dictionary and should not be used as part of an API data set until resolved: 'education_phase / All phases', 'sex / All pupils'.
#>                check  result
#> 1 data_dict_fil_item WARNING
#>                                                                                                                                                                                                          message
#> 1 The following col_name / filter_item combinations are not present in the data dictionary and should not be used as part of an API data set until resolved: 'education_phase / All phases', 'sex / All pupils'.
#>                                                                                             guidance_url
#> 1 https://dfe-analytical-services.github.io/analysts-guide/statistics-production/api-data-standards.html
```
