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
#> 6        cross_data_to_meta   PASS
#> 7          col_names_spaces   PASS
#> 8            col_snake_case   PASS
#> 9             col_var_start   PASS
#> 10          col_ind_smushed   PASS
#> 11   col_var_characteristic   PASS
#> 12            meta_col_type   PASS
#> 13             meta_ob_unit   PASS
#> 14            meta_col_name   PASS
#> 15          meta_dupe_label   PASS
#> 16             meta_fil_grp   PASS
#> 17        meta_fil_grp_dupe   PASS
#> 18      meta_fil_grp_is_fil   PASS
#> 19       meta_fil_grp_match   PASS
#> 20    meta_fil_grp_stripped   PASS
#> 21               meta_label   PASS
#> 22         meta_filter_hint   PASS
#> 23          meta_geog_catch   PASS
#> 24        meta_indicator_dp   PASS
#> 25     meta_col_name_spaces   PASS
#> 26       meta_col_name_dupe   PASS
#> 27          meta_ind_dp_set   PASS
#> 28       meta_ind_dp_values   PASS
#> 29            meta_ind_unit   PASS
#> 30 meta_ind_unit_validation   PASS
#> 31  meta_indicator_grouping   PASS
#> 32             general_null   PASS
#> 33      filter_not_singular   PASS
#> 34          time_period_num   PASS
#> 35            time_id_valid   PASS
#> 36              time_id_mix   PASS
#> 37               geog_level   PASS
#> 38       geog_level_present   PASS
#> 39              time_period   PASS
#> 40          time_period_six   PASS
#> 41     geog_level_completed   PASS
#> 42        geog_ignored_rows   PASS
#> 43         geog_other_dupes   PASS
#> 44      geog_la_col_present   PASS
#> 45  geog_region_col_present   PASS
#> 46       geog_region_for_la   PASS
#> 47      geog_region_for_lad   PASS
#> 48                  geog_na   PASS
#> 49             geog_na_code   PASS
#> 50    geog_other_code_dupes   PASS
#> 51          filter_defaults   PASS
#> 52       filter_group_level   PASS
#> 53        filter_item_limit   PASS
#> 54        filter_whitespace   PASS
#> 55          filter_ob_total   PASS
#> 56            filter_blanks   PASS
#> 57            general_dupes   PASS
#> 58      geog_country_combos   PASS
#> 59       geog_region_combos   PASS
#> 60         geog_ward_combos   PASS
#> 61         geog_pcon_combos   PASS
#> 62          geog_lad_combos   PASS
#> 63          geog_lep_combos   PASS
#> 64         geog_lsip_combos   PASS
#> 65          geog_eda_combos   PASS
#> 66           geog_la_combos   PASS
#> 67        ind_invalid_entry   PASS
#> 68        api_char_col_name   PASS
#> 69       api_char_col_label   PASS
#> 70        api_char_loc_code   PASS
#> 71    api_char_filter_items   PASS
#> 72       api_dict_col_names   PASS
#>                                                                                                                                           message
#> 1                                                                                   All of the required columns are present in the metadata file.
#> 2                                                                                              There are no invalid columns in the metadata file.
#> 3                                                                                       All of the required columns are present in the data file.
#> 4                                      There are an equal number of rows in the metadata file (3) and non-mandatory columns in the data file (3).
#> 5                                                                                    All variables from the metadata were found in the data file.
#> 6                                                 All variables in the data file are observational units or are represented in the metadata file.
#> 7                                                                                      There are no spaces in the variable names in the datafile.
#> 8                                                                           The variable names in the data file follow the snake_case convention.
#> 9                                                                              All variable names in the data file start with a lowercase letter.
#> 10                                                                                         No indicators found containing typical filter entries.
#> 11                                          Neither 'characteristic' nor 'characteristic_group' were found as listed fields in the metadata file.
#> 12                                                                                                    col_type is always 'Filter' or 'Indicator'.
#> 13                                                                                No observational units have been included in the metadata file.
#> 14                                                                                The col_name column is completed for every row in the metadata.
#> 15                                                                                                                         All labels are unique.
#> 16                                                                                             No indicators have a filter_grouping_column value.
#> 17                                                                                                            There are no filter groups present.
#> 18                                                                                                            There are no filter groups present.
#> 19                                                                                                            There are no filter groups present.
#> 20                                                                                                            There are no filter groups present.
#> 21                                                                                   The label column is completed for every row in the metadata.
#> 22                                                                                                        No indicators have a filter_hint value.
#> 23                                                                                         No filters appear to be mislabelled geography columns.
#> 24                                                                                                         No filters have an indicator_dp value.
#> 25                                                                                                    There are no spaces in the col_name values.
#> 26                                                                                                                All col_name values are unique.
#> 27                                                                                       The indicator_dp column is completed for all indicators.
#> 28                                                                The indicator_dp column only contains blanks, zero, or positive integer values.
#> 29                                                                                                       No filters have an indicator_unit value.
#> 30                                                                                                            The indicator_unit values are valid
#> 31                                                                                                   No filters have an indicator_grouping value.
#> 32                                                        No problematic null or legacy no-data symbols were found in the data or metadata files.
#> 33                                                                                                           All filters have two or more levels.
#> 34                                                                                           The time_period column only contains numeric values.
#> 35                                                                                                      The time_identifier values are all valid.
#> 36                                                                                           There is only one time_identifier value in the data.
#> 37                                                                                                     The geographic_level values are all valid.
#> 38                                                                                                 There is only National level data in the file.
#> 39                                                                    The time_period length matches the time_identifier values in the data file.
#> 40                                                                                   The six digit time_period values refer to consecutive years.
#> 41                                                                                        All geographic level columns are completed as expected.
#> 42                                                                                     No rows in the file will be ignored by the EES table tool.
#> 43                                                                                   Lower-level geography data is not present in this data file.
#> 44                                                                                      No local authority columns are present in this data file.
#> 45                                                                                             No regional columns are present in this data file.
#> 46                                                                                       There is no Local authority level data in the data file.
#> 47                                                                              There is no Local authority district level data in the data file.
#> 48                                                                                                       No applicable geographic levels to test.
#> 49                                                                            No applicable geographic levels to check for 'Not available' codes.
#> 50                                                                                   Lower-level geography data is not present in this data file.
#> 51                                                                                     All filters and groups have a default filter item present.
#> 52                                                                                                            There are no filter groups present.
#> 53                                                                                    All filters and groups have less than 25000 unique entries.
#> 54                                                                                       No filter labels contain leading or trailing whitespace.
#> 55                                                                            There are no Total or All values in the observational unit columns.
#> 56                                                                               There are no blank values in any filter or filter group columns.
#> 57 There are no duplicate rows in the data file. Note that School, Provider, Institution, and Planning area rows were not included in this check.
#> 58                                                                                        All country_code / country_name combinations are valid.
#> 59                                                        At least one of the region_code / region_name columns is not present in this data file.
#> 60                                                            At least one of the ward_code / ward_name columns is not present in this data file.
#> 61                                                            At least one of the pcon_code / pcon_name columns is not present in this data file.
#> 62                                                              At least one of the lad_code / lad_name columns is not present in this data file.
#> 63            At least one of the local_enterprise_partnership_code / local_enterprise_partnership_name columns is not present in this data file.
#> 64                                                            At least one of the lsip_code / lsip_name columns is not present in this data file.
#> 65                          At least one of the english_devolved_area_code / english_devolved_area_name columns is not present in this data file.
#> 66                                              At least one of the old_la_code / new_la_code / la_name columns is not present in this data file.
#> 67                                                                             There are no blank values or GSS legacy symbols in any indicators.
#> 68                                                              All filter / indicator names are less than or equal to the character limit of 50.
#> 69                                                            All filter / indicator labels are less than or equal to the character limit of 100.
#> 70                                                                        All location codes are less than or equal to the character limit of 30.
#> 71                                                        All filter items / location names are less than or equal to the character limit of 120.
#> 72                                                                                         All col_names are consistent with the data dictionary.
#>    guidance_url               stage
#> 1            NA    Precheck columns
#> 2            NA    Precheck columns
#> 3            NA    Precheck columns
#> 4            NA    Precheck columns
#> 5            NA Precheck cross-file
#> 6            NA Precheck cross-file
#> 7            NA       Check columns
#> 8            NA       Check columns
#> 9            NA       Check columns
#> 10           NA       Check columns
#> 11           NA       Check columns
#> 12           NA       Precheck meta
#> 13           NA       Precheck meta
#> 14           NA       Precheck meta
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
#> 31           NA          Check meta
#> 32           NA       Check general
#> 33           NA    Precheck filters
#> 34           NA       Precheck time
#> 35           NA       Precheck time
#> 36           NA       Precheck time
#> 37           NA  Precheck geography
#> 38           NA  Precheck geography
#> 39           NA          Check time
#> 40           NA          Check time
#> 41           NA     Check geography
#> 42           NA     Check geography
#> 43           NA     Check geography
#> 44           NA     Check geography
#> 45           NA     Check geography
#> 46           NA     Check geography
#> 47           NA     Check geography
#> 48           NA     Check geography
#> 49           NA     Check geography
#> 50           NA     Check geography
#> 51           NA       Check filters
#> 52           NA       Check filters
#> 53           NA       Check filters
#> 54           NA       Check filters
#> 55           NA       Check filters
#> 56           NA       Check filters
#> 57           NA       Check general
#> 58           NA     Check geography
#> 59           NA     Check geography
#> 60           NA     Check geography
#> 61           NA     Check geography
#> 62           NA     Check geography
#> 63           NA     Check geography
#> 64           NA     Check geography
#> 65           NA     Check geography
#> 66           NA     Check geography
#> 67           NA    Check indicators
#> 68           NA           Check API
#> 69           NA           Check API
#> 70           NA           Check API
#> 71           NA           Check API
#> 72           NA           Check API
```
