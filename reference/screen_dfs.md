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
#> 9           col_ind_smushed   PASS
#> 10   col_var_characteristic   PASS
#> 11            meta_col_type   PASS
#> 12             meta_ob_unit   PASS
#> 13            meta_col_name   PASS
#> 14          meta_dupe_label   PASS
#> 15             meta_fil_grp   PASS
#> 16        meta_fil_grp_dupe   PASS
#> 17      meta_fil_grp_is_fil   PASS
#> 18       meta_fil_grp_match   PASS
#> 19    meta_fil_grp_stripped   PASS
#> 20               meta_label   PASS
#> 21         meta_filter_hint   PASS
#> 22          meta_geog_catch   PASS
#> 23        meta_indicator_dp   PASS
#> 24     meta_col_name_spaces   PASS
#> 25       meta_col_name_dupe   PASS
#> 26          meta_ind_dp_set   PASS
#> 27       meta_ind_dp_values   PASS
#> 28            meta_ind_unit   PASS
#> 29 meta_ind_unit_validation   PASS
#> 30  meta_indicator_grouping   PASS
#> 31          time_period_num   PASS
#> 32            time_id_valid   PASS
#> 33              time_id_mix   PASS
#> 34               geog_level   PASS
#> 35       geog_level_present   PASS
#> 36              time_period   PASS
#> 37          time_period_six   PASS
#> 38          filter_defaults   PASS
#> 39       filter_group_level   PASS
#> 40        filter_item_limit   PASS
#> 41        filter_whitespace   PASS
#> 42        ind_invalid_entry   PASS
#> 43        api_char_col_name   PASS
#> 44       api_char_col_label   PASS
#> 45        api_char_loc_code   PASS
#> 46    api_char_filter_items   PASS
#> 47       api_dict_col_names   PASS
#>                                                                                                       message
#> 1                                               All of the required columns are present in the metadata file.
#> 2                                                          There are no invalid columns in the metadata file.
#> 3                                                   All of the required columns are present in the data file.
#> 4  There are an equal number of rows in the metadata file (3) and non-mandatory columns in the data file (3).
#> 5                                                All variables from the metadata were found in the data file.
#> 6                                                  There are no spaces in the variable names in the datafile.
#> 7                                       The variable names in the data file follow the snake_case convention.
#> 8                                          All variable names in the data file start with a lowercase letter.
#> 9                                                      No indicators found containing typical filter entries.
#> 10      Neither 'characteristic' nor 'characteristic_group' were found as listed fields in the metadata file.
#> 11                                                                col_type is always 'Filter' or 'Indicator'.
#> 12                                            No observational units have been included in the metadata file.
#> 13                                            The col_name column is completed for every row in the metadata.
#> 14                                                                                     All labels are unique.
#> 15                                                         No indicators have a filter_grouping_column value.
#> 16                                                                        There are no filter groups present.
#> 17                                                                        There are no filter groups present.
#> 18                                                                        There are no filter groups present.
#> 19                                                                        There are no filter groups present.
#> 20                                               The label column is completed for every row in the metadata.
#> 21                                                                    No indicators have a filter_hint value.
#> 22                                                     No filters appear to be mislabelled geography columns.
#> 23                                                                     No filters have an indicator_dp value.
#> 24                                                                There are no spaces in the col_name values.
#> 25                                                                            All col_name values are unique.
#> 26                                                   The indicator_dp column is completed for all indicators.
#> 27                            The indicator_dp column only contains blanks, zero, or positive integer values.
#> 28                                                                   No filters have an indicator_unit value.
#> 29                                                                        The indicator_unit values are valid
#> 30                                                               No filters have an indicator_grouping value.
#> 31                                                       The time_period column only contains numeric values.
#> 32                                                                  The time_identifier values are all valid.
#> 33                                                       There is only one time_identifier value in the data.
#> 34                                                                 The geographic_level values are all valid.
#> 35                                                             There is only National level data in the file.
#> 36                                The time_period length matches the time_identifier values in the data file.
#> 37                                               The six digit time_period values refer to consecutive years.
#> 38                                                 All filters and groups have a default filter item present.
#> 39                                                                        There are no filter groups present.
#> 40                                                All filters and groups have less than 25000 unique entries.
#> 41                                                   No filter labels contain leading or trailing whitespace.
#> 42                                         There are no blank values or GSS legacy symbols in any indicators.
#> 43                          All filter / indicator names are less than or equal to the character limit of 50.
#> 44                        All filter / indicator labels are less than or equal to the character limit of 100.
#> 45                                    All location codes are less than or equal to the character limit of 30.
#> 46                    All filter items / location names are less than or equal to the character limit of 120.
#> 47                                                     All col_names are consistent with the data dictionary.
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
#> 10           NA       Check columns
#> 11           NA       Precheck meta
#> 12           NA       Precheck meta
#> 13           NA       Precheck meta
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
#> 30           NA          Check meta
#> 31           NA       Precheck time
#> 32           NA       Precheck time
#> 33           NA       Precheck time
#> 34           NA  Precheck geography
#> 35           NA  Precheck geography
#> 36           NA          Check time
#> 37           NA          Check time
#> 38           NA       Check filters
#> 39           NA       Check filters
#> 40           NA       Check filters
#> 41           NA       Check filters
#> 42           NA    Check indicators
#> 43           NA           Check API
#> 44           NA           Check API
#> 45           NA           Check API
#> 46           NA           Check API
#> 47           NA           Check API
```
