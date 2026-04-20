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
  prudence = "lavish",
  use_duckdb = TRUE
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

- use_duckdb:

  logical, if TRUE converts `data` to a duckdb tibble and runs checks
  via duckplyr. If FALSE runs checks with plain dplyr on the data as
  provided. Default is TRUE. Note:
  [`screen_csv()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_csv.md)
  sets this automatically based on file size (files under 5 MB use
  FALSE); direct callers of `screen_dfs()` must choose the flag
  themselves.

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
#> 32          time_period_num   PASS
#> 33            time_id_valid   PASS
#> 34              time_id_mix   PASS
#> 35      filter_not_singular   PASS
#> 36               geog_level   PASS
#> 37       geog_level_present   PASS
#> 38              time_period   PASS
#> 39          time_period_six   PASS
#> 40          filter_defaults   PASS
#> 41       filter_group_level   PASS
#> 42        filter_item_limit   PASS
#> 43        filter_whitespace   PASS
#> 44          filter_ob_total   PASS
#> 45            filter_blanks   PASS
#> 46      geog_country_combos   PASS
#> 47       geog_region_combos   PASS
#> 48         geog_ward_combos   PASS
#> 49         geog_pcon_combos   PASS
#> 50          geog_lad_combos   PASS
#> 51          geog_lep_combos   PASS
#> 52         geog_lsip_combos   PASS
#> 53          geog_eda_combos   PASS
#> 54           geog_la_combos   PASS
#> 55     geog_level_completed   PASS
#> 56        geog_ignored_rows   PASS
#> 57         geog_other_dupes   PASS
#> 58      geog_la_col_present   PASS
#> 59  geog_region_col_present   PASS
#> 60       geog_region_for_la   PASS
#> 61      geog_region_for_lad   PASS
#> 62                  geog_na   PASS
#> 63             geog_na_code   PASS
#> 64    geog_other_code_dupes   PASS
#> 65  geog_overcompleted_cols   PASS
#> 66            general_dupes   PASS
#> 67             general_null   PASS
#> 68        ind_invalid_entry   PASS
#> 69     harmonised_variables   PASS
#> 70      harmonised_eth_vals   PASS
#> 71  harmonised_eth_char_grp   PASS
#> 72 harmonised_eth_char_vals   PASS
#> 73        api_char_col_name   PASS
#> 74       api_char_col_label   PASS
#> 75        api_char_loc_code   PASS
#> 76    api_char_filter_items   PASS
#> 77       data_dict_col_name   PASS
#> 78       data_dict_fil_item   PASS
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
#> 30                                                                                                           The indicator_unit values are valid.
#> 31                                                                                                   No filters have an indicator_grouping value.
#> 32                                                                                           The time_period column only contains numeric values.
#> 33                                                                                                      The time_identifier values are all valid.
#> 34                                                                                           There is only one time_identifier value in the data.
#> 35                                                                                                           All filters have two or more levels.
#> 36                                                                                                     The geographic_level values are all valid.
#> 37                                                                                                 There is only National level data in the file.
#> 38                                                                    The time_period length matches the time_identifier values in the data file.
#> 39                                                                                   The six digit time_period values refer to consecutive years.
#> 40                                                                                     All filters and groups have a default filter item present.
#> 41                                                                                                            There are no filter groups present.
#> 42                                                                                    All filters and groups have less than 25000 unique entries.
#> 43                                                                                       No filter labels contain leading or trailing whitespace.
#> 44                                                                            There are no Total or All values in the observational unit columns.
#> 45                                                                               There are no blank values in any filter or filter group columns.
#> 46                                                                                        All country_code / country_name combinations are valid.
#> 47                                                        At least one of the region_code / region_name columns is not present in this data file.
#> 48                                                            At least one of the ward_code / ward_name columns is not present in this data file.
#> 49                                                            At least one of the pcon_code / pcon_name columns is not present in this data file.
#> 50                                                              At least one of the lad_code / lad_name columns is not present in this data file.
#> 51            At least one of the local_enterprise_partnership_code / local_enterprise_partnership_name columns is not present in this data file.
#> 52                                                            At least one of the lsip_code / lsip_name columns is not present in this data file.
#> 53                          At least one of the english_devolved_area_code / english_devolved_area_name columns is not present in this data file.
#> 54                                              At least one of the old_la_code / new_la_code / la_name columns is not present in this data file.
#> 55                                                                                        All geographic level columns are completed as expected.
#> 56                                                                                     No rows in the file will be ignored by the EES table tool.
#> 57                                                                                   Lower-level geography data is not present in this data file.
#> 58                                                                                      No local authority columns are present in this data file.
#> 59                                                                                             No regional columns are present in this data file.
#> 60                                                                                       There is no Local authority level data in the data file.
#> 61                                                                              There is no Local authority district level data in the data file.
#> 62                                                                                                       No applicable geographic levels to test.
#> 63                                                                            No applicable geographic levels to check for 'Not available' codes.
#> 64                                                                                   Lower-level geography data is not present in this data file.
#> 65                                                                                               All geographic columns are empty where expected.
#> 66 There are no duplicate rows in the data file. Note that School, Provider, Institution, and Planning area rows were not included in this check.
#> 67                                                        No problematic null or legacy no-data symbols were found in the data or metadata files.
#> 68                                                                             There are no blank values or GSS legacy symbols in any indicators.
#> 69                                                                                                      No standardised column name issues found.
#> 70                                                                                                                    No ethnicity columns found.
#> 71                                                                                                          No characteristic_group column found.
#> 72                                                                                      No characteristic_group and characteristic columns found.
#> 73                                                              All filter / indicator names are less than or equal to the character limit of 50.
#> 74                                                            All filter / indicator labels are less than or equal to the character limit of 100.
#> 75                                                                        All location codes are less than or equal to the character limit of 30.
#> 76                                                        All filter items / location names are less than or equal to the character limit of 120.
#> 77                                                                                         All col_names are consistent with the data dictionary.
#> 78                                                                                      All filter items are consistent with the data dictionary.
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
#> 32           NA       Precheck time
#> 33           NA       Precheck time
#> 34           NA       Precheck time
#> 35           NA    Precheck filters
#> 36           NA  Precheck geography
#> 37           NA  Precheck geography
#> 38           NA          Check time
#> 39           NA          Check time
#> 40           NA       Check filters
#> 41           NA       Check filters
#> 42           NA       Check filters
#> 43           NA       Check filters
#> 44           NA       Check filters
#> 45           NA       Check filters
#> 46           NA     Check geography
#> 47           NA     Check geography
#> 48           NA     Check geography
#> 49           NA     Check geography
#> 50           NA     Check geography
#> 51           NA     Check geography
#> 52           NA     Check geography
#> 53           NA     Check geography
#> 54           NA     Check geography
#> 55           NA     Check geography
#> 56           NA     Check geography
#> 57           NA     Check geography
#> 58           NA     Check geography
#> 59           NA     Check geography
#> 60           NA     Check geography
#> 61           NA     Check geography
#> 62           NA     Check geography
#> 63           NA     Check geography
#> 64           NA     Check geography
#> 65           NA     Check geography
#> 66           NA       Check general
#> 67           NA       Check general
#> 68           NA    Check indicators
#> 69           NA    Check harmonised
#> 70           NA    Check harmonised
#> 71           NA    Check harmonised
#> 72           NA    Check harmonised
#> 73           NA           Check API
#> 74           NA           Check API
#> 75           NA           Check API
#> 76           NA           Check API
#> 77           NA           Check API
#> 78           NA           Check API
```
