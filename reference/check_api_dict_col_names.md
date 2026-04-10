# Check if col_names are present in the data dictionary

Uses the exported `data_dictionary` data.frame as a reference for the
acceptable col_names.

## Usage

``` r
check_api_dict_col_names(meta, verbose = FALSE, stop_on_error = FALSE)
```

## Arguments

- meta:

  dataframe containing a data set's meta data

- verbose:

  Logical, if TRUE prints feedback messages to console for every test,
  if FALSE run silently

- stop_on_error:

  Logical, if TRUE will stop with an error if the result is "FAIL", and
  will throw genuine warning if result is "WARNING"

## See also

Other check_api:
[`check_api_char_col_label()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_api_char_col_label.md),
[`check_api_char_col_name()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_api_char_col_name.md),
[`check_api_char_filter_items()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_api_char_filter_items.md),
[`check_api_char_loc_code()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_api_char_loc_code.md)

## Examples

``` r
check_api_dict_col_names(example_meta)
#>                check result
#> 1 api_dict_col_names   PASS
#>                                                  message guidance_url
#> 1 All col_names are consistent with the data dictionary.           NA
```
