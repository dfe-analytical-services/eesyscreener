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
#> 8             meta_col_type   PASS
#> 9              meta_ob_unit   PASS
#> 10            meta_col_name   PASS
#> 11          meta_dupe_label   PASS
#> 12             meta_fil_grp   PASS
#> 13        meta_fil_grp_dupe   PASS
#> 14      meta_fil_grp_is_fil   PASS
#> 15       meta_fil_grp_match   PASS
#> 16    meta_fil_grp_stripped   PASS
#> 17               meta_label   PASS
#> 18         meta_filter_hint   PASS
#> 19          meta_geog_catch   PASS
#> 20        meta_indicator_dp   PASS
#> 21     meta_col_name_spaces   PASS
#> 22       meta_col_name_dupe   PASS
#> 23          meta_ind_dp_set   PASS
#> 24       meta_ind_dp_values   PASS
#> 25            meta_ind_unit   PASS
#> 26 meta_ind_unit_validation   PASS
#> 27  meta_indicator_grouping   PASS
#> 28          time_period_num   PASS
#> 29            time_id_valid   PASS
#> 30              time_id_mix   PASS
#> 31               geog_level   PASS
#> 32       geog_level_present   PASS
#> 33              time_period   PASS
#> 34          time_period_six   PASS
#> 35          filter_defaults   PASS
#> 36       filter_group_level   PASS
#> 37        filter_item_limit   PASS
#> 38        filter_whitespace   PASS
#> 39        ind_invalid_entry   PASS
#> 40        api_char_col_name   PASS
#> 41       api_char_col_label   PASS
#> 42        api_char_loc_code   PASS
#> 43    api_char_filter_items   PASS
#> 44       api_dict_col_names   PASS
#>                                                                                                       message
#> 1                                               All of the required columns are present in the metadata file.
#> 2                                                          There are no invalid columns in the metadata file.
#> 3                                                   All of the required columns are present in the data file.
#> 4  There are an equal number of rows in the metadata file (3) and non-mandatory columns in the data file (3).
#> 5                                                All variables from the metadata were found in the data file.
#> 6                                                  There are no spaces in the variable names in the datafile.
#> 7                                       The variable names in the data file follow the snake_case convention.
#> 8                                                                 col_type is always 'Filter' or 'Indicator'.
#> 9                                             No observational units have been included in the metadata file.
#> 10                                            The col_name column is completed for every row in the metadata.
#> 11                                                                                     All labels are unique.
#> 12                                                         No indicators have a filter_grouping_column value.
#> 13                                                                        There are no filter groups present.
#> 14                                                                        There are no filter groups present.
#> 15                                                                        There are no filter groups present.
#> 16                                                                        There are no filter groups present.
#> 17                                               The label column is completed for every row in the metadata.
#> 18                                                                    No indicators have a filter_hint value.
#> 19                                                     No filters appear to be mislabelled geography columns.
#> 20                                                                     No filters have an indicator_dp value.
#> 21                                                                There are no spaces in the col_name values.
#> 22                                                                            All col_name values are unique.
#> 23                                                   The indicator_dp column is completed for all indicators.
#> 24                            The indicator_dp column only contains blanks, zero, or positive integer values.
#> 25                                                                   No filters have an indicator_unit value.
#> 26                                                                        The indicator_unit values are valid
#> 27                                                               No filters have an indicator_grouping value.
#> 28                                                       The time_period column only contains numeric values.
#> 29                                                                  The time_identifier values are all valid.
#> 30                                                       There is only one time_identifier value in the data.
#> 31                                                                 The geographic_level values are all valid.
#> 32                                                             There is only National level data in the file.
#> 33                                The time_period length matches the time_identifier values in the data file.
#> 34                                               The six digit time_period values refer to consecutive years.
#> 35                                                 All filters and groups have a default filter item present.
#> 36                                                                        There are no filter groups present.
#> 37                                                All filters and groups have less than 25000 unique entries.
#> 38                                                   No filter labels contain leading or trailing whitespace.
#> 39                                         There are no blank values or GSS legacy symbols in any indicators.
#> 40                          All filter / indicator names are less than or equal to the character limit of 50.
#> 41                        All filter / indicator labels are less than or equal to the character limit of 100.
#> 42                                    All location codes are less than or equal to the character limit of 30.
#> 43                    All filter items / location names are less than or equal to the character limit of 120.
#> 44                                                     All col_names are consistent with the data dictionary.
#>    guidance_url               stage
#> 1            NA    Precheck columns
#> 2            NA    Precheck columns
#> 3            NA    Precheck columns
#> 4            NA    Precheck columns
#> 5            NA Precheck cross-file
#> 6            NA       Check columns
#> 7            NA       Check columns
#> 8            NA       Precheck meta
#> 9            NA       Precheck meta
#> 10           NA       Precheck meta
#> 11           NA          Check meta
#> 12           NA          Check meta
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
#> 28           NA       Precheck time
#> 29           NA       Precheck time
#> 30           NA       Precheck time
#> 31           NA  Precheck geography
#> 32           NA  Precheck geography
#> 33           NA          Check time
#> 34           NA          Check time
#> 35           NA       Check filters
#> 36           NA       Check filters
#> 37           NA       Check filters
#> 38           NA       Check filters
#> 39           NA    Check indicators
#> 40           NA           Check API
#> 41           NA           Check API
#> 42           NA           Check API
#> 43           NA           Check API
#> 44           NA           Check API
```
