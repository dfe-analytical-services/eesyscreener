# Run all checks against data and metadata

Run all of the checks from the package against the data and metadata
objects.

## Usage

``` r
screen_dfs(
  data,
  meta,
  log_key = NULL,
  log_dir = "./",
  dd_checks = TRUE,
  verbose = FALSE,
  stop_on_error = FALSE,
  prudence = "lavish"
)
```

## Arguments

- data:

  data.frame, for the data table, more efficient if supplied as a lazy
  duckplyr data.frame

- meta:

  data.frame, for the metadata table

- log_key:

  Keystring for creating log file. If given, the screening will write a
  log file to disk called eesyscreening_log\_\<log_key\>.json
  default=NULL

- log_dir:

  Directory within which to place the log file. default="./"

- dd_checks:

  Run the Data dictionary tests, default=TRUE (this is implemented to
  allow devs to update robot test data to be consistent with data
  dictionary tests).

- verbose:

  logical, if TRUE prints feedback messages to console for every test,
  if FALSE run silently

- stop_on_error:

  logical, if TRUE will stop with an error if the result is "FAIL", and
  will throw genuine warning if result is "WARNING"

- prudence:

  prudence as used by duckplyr, default = "lavish". Can also be "stingy"
  and "thrifty".

## Value

data.frame containing the results of the screening

## Details

Provide a pair of data.frames and this will run through the checks in
order.

## Examples

``` r
screen_dfs(example_data, example_meta)
#>                       check result
#> 1              col_req_meta   PASS
#> 2          col_invalid_meta   PASS
#> 3              col_req_data   PASS
#> 4               col_to_rows   PASS
#> 5        cross_meta_to_data   PASS
#> 6          col_names_spaces   PASS
#> 7            col_snake_case   PASS
#> 8             col_var_start   PASS
#> 9    col_var_characteristic   PASS
#> 10            meta_col_type   PASS
#> 11             meta_ob_unit   PASS
#> 12            meta_col_name   PASS
#> 13          meta_dupe_label   PASS
#> 14             meta_fil_grp   PASS
#> 15        meta_fil_grp_dupe   PASS
#> 16      meta_fil_grp_is_fil   PASS
#> 17       meta_fil_grp_match   PASS
#> 18    meta_fil_grp_stripped   PASS
#> 19               meta_label   PASS
#> 20         meta_filter_hint   PASS
#> 21          meta_geog_catch   PASS
#> 22        meta_indicator_dp   PASS
#> 23     meta_col_name_spaces   PASS
#> 24       meta_col_name_dupe   PASS
#> 25          meta_ind_dp_set   PASS
#> 26       meta_ind_dp_values   PASS
#> 27            meta_ind_unit   PASS
#> 28 meta_ind_unit_validation   PASS
#> 29  meta_indicator_grouping   PASS
#> 30          time_period_num   PASS
#> 31            time_id_valid   PASS
#> 32              time_id_mix   PASS
#> 33               geog_level   PASS
#> 34       geog_level_present   PASS
#> 35              time_period   PASS
#> 36          time_period_six   PASS
#> 37          filter_defaults   PASS
#> 38       filter_group_level   PASS
#> 39        filter_item_limit   PASS
#> 40        filter_whitespace   PASS
#> 41        ind_invalid_entry   PASS
#> 42        api_char_col_name   PASS
#> 43       api_char_col_label   PASS
#> 44        api_char_loc_code   PASS
#> 45    api_char_filter_items   PASS
#> 46       api_dict_col_names   PASS
#>                                                                                                       message
#> 1                                               All of the required columns are present in the metadata file.
#> 2                                                          There are no invalid columns in the metadata file.
#> 3                                                   All of the required columns are present in the data file.
#> 4  There are an equal number of rows in the metadata file (3) and non-mandatory columns in the data file (3).
#> 5                                                All variables from the metadata were found in the data file.
#> 6                                                  There are no spaces in the variable names in the datafile.
#> 7                                       The variable names in the data file follow the snake_case convention.
#> 8                                          All variable names in the data file start with a lowercase letter.
#> 9       Neither 'characteristic' nor 'characteristic_group' were found as listed fields in the metadata file.
#> 10                                                                col_type is always 'Filter' or 'Indicator'.
#> 11                                            No observational units have been included in the metadata file.
#> 12                                            The col_name column is completed for every row in the metadata.
#> 13                                                                                     All labels are unique.
#> 14                                                         No indicators have a filter_grouping_column value.
#> 15                                                                        There are no filter groups present.
#> 16                                                                        There are no filter groups present.
#> 17                                                                        There are no filter groups present.
#> 18                                                                        There are no filter groups present.
#> 19                                               The label column is completed for every row in the metadata.
#> 20                                                                    No indicators have a filter_hint value.
#> 21                                                     No filters appear to be mislabelled geography columns.
#> 22                                                                     No filters have an indicator_dp value.
#> 23                                                                There are no spaces in the col_name values.
#> 24                                                                            All col_name values are unique.
#> 25                                                   The indicator_dp column is completed for all indicators.
#> 26                            The indicator_dp column only contains blanks, zero, or positive integer values.
#> 27                                                                   No filters have an indicator_unit value.
#> 28                                                                        The indicator_unit values are valid
#> 29                                                               No filters have an indicator_grouping value.
#> 30                                                       The time_period column only contains numeric values.
#> 31                                                                  The time_identifier values are all valid.
#> 32                                                       There is only one time_identifier value in the data.
#> 33                                                                 The geographic_level values are all valid.
#> 34                                                             There is only National level data in the file.
#> 35                                The time_period length matches the time_identifier values in the data file.
#> 36                                               The six digit time_period values refer to consecutive years.
#> 37                                                 All filters and groups have a default filter item present.
#> 38                                                                        There are no filter groups present.
#> 39                                                All filters and groups have less than 25000 unique entries.
#> 40                                                   No filter labels contain leading or trailing whitespace.
#> 41                                         There are no blank values or GSS legacy symbols in any indicators.
#> 42                          All filter / indicator names are less than or equal to the character limit of 50.
#> 43                        All filter / indicator labels are less than or equal to the character limit of 100.
#> 44                                    All location codes are less than or equal to the character limit of 30.
#> 45                    All filter items / location names are less than or equal to the character limit of 120.
#> 46                                                     All col_names are consistent with the data dictionary.
#>    guidance_url               stage
#> 1            NA    Precheck columns
#> 2            NA    Precheck columns
#> 3            NA    Precheck columns
#> 4            NA    Precheck columns
#> 5            NA Precheck cross-file
#> 6            NA       Check columns
#> 7            NA       Check columns
#> 8            NA       Check columns
#> 9            NA       Check columns
#> 10           NA       Precheck meta
#> 11           NA       Precheck meta
#> 12           NA       Precheck meta
#> 13           NA          Check meta
#> 14           NA          Check meta
#> 15           NA          Check meta
#> 16           NA          Check meta
#> 17           NA          Check meta
#> 18           NA          Check meta
#> 19           NA          Check meta
#> 20           NA          Check meta
#> 21           NA          Check meta
#> 22           NA          Check meta
#> 23           NA          Check meta
#> 24           NA          Check meta
#> 25           NA          Check meta
#> 26           NA          Check meta
#> 27           NA          Check meta
#> 28           NA          Check meta
#> 29           NA          Check meta
#> 30           NA       Precheck time
#> 31           NA       Precheck time
#> 32           NA       Precheck time
#> 33           NA  Precheck geography
#> 34           NA  Precheck geography
#> 35           NA          Check time
#> 36           NA          Check time
#> 37           NA       Check filters
#> 38           NA       Check filters
#> 39           NA       Check filters
#> 40           NA       Check filters
#> 41           NA    Check indicators
#> 42           NA           Check API
#> 43           NA           Check API
#> 44           NA           Check API
#> 45           NA           Check API
#> 46           NA           Check API
```
