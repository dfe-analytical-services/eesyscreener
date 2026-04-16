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
#>                       check  result
#> 1              col_req_meta    PASS
#> 2          col_invalid_meta    PASS
#> 3              col_req_data    PASS
#> 4               col_to_rows    PASS
#> 5        cross_meta_to_data    PASS
#> 6        cross_data_to_meta    PASS
#> 7          col_names_spaces    PASS
#> 8            col_snake_case    PASS
#> 9             col_var_start    PASS
#> 10          col_ind_smushed    PASS
#> 11   col_var_characteristic    PASS
#> 12            meta_col_type    PASS
#> 13             meta_ob_unit    PASS
#> 14            meta_col_name    PASS
#> 15          meta_dupe_label    PASS
#> 16             meta_fil_grp    PASS
#> 17        meta_fil_grp_dupe    PASS
#> 18      meta_fil_grp_is_fil    PASS
#> 19       meta_fil_grp_match    PASS
#> 20    meta_fil_grp_stripped    PASS
#> 21               meta_label    PASS
#> 22         meta_filter_hint    PASS
#> 23          meta_geog_catch    PASS
#> 24        meta_indicator_dp    PASS
#> 25     meta_col_name_spaces    PASS
#> 26       meta_col_name_dupe    PASS
#> 27          meta_ind_dp_set    PASS
#> 28       meta_ind_dp_values    PASS
#> 29            meta_ind_unit    PASS
#> 30 meta_ind_unit_validation    PASS
#> 31  meta_indicator_grouping    PASS
#> 32             general_null    PASS
#> 33      filter_not_singular    PASS
#> 34          time_period_num    PASS
#> 35            time_id_valid    PASS
#> 36              time_id_mix    PASS
#> 37               geog_level    PASS
#> 38       geog_level_present    PASS
#> 39              time_period    PASS
#> 40          time_period_six    PASS
#> 41          filter_defaults    PASS
#> 42       filter_group_level    PASS
#> 43        filter_item_limit    PASS
#> 44        filter_whitespace    PASS
#> 45          filter_ob_total    PASS
#> 46            filter_blanks    PASS
#> 47            general_dupes    PASS
#> 48      geog_country_combos    PASS
#> 49       geog_region_combos    PASS
#> 50         geog_ward_combos    PASS
#> 51         geog_pcon_combos    PASS
#> 52          geog_lad_combos    PASS
#> 53          geog_lep_combos    PASS
#> 54         geog_lsip_combos    PASS
#> 55          geog_eda_combos    PASS
#> 56           geog_la_combos    PASS
#> 57     geog_level_completed    PASS
#> 58        geog_ignored_rows    PASS
#> 59         geog_other_dupes    PASS
#> 60      geog_la_col_present    PASS
#> 61  geog_region_col_present    PASS
#> 62       geog_region_for_la    PASS
#> 63      geog_region_for_lad    PASS
#> 64                  geog_na    PASS
#> 65             geog_na_code    PASS
#> 66    geog_other_code_dupes    PASS
#> 67  geog_overcompleted_cols    PASS
#> 68        ind_invalid_entry    PASS
#> 69     harmonised_variables    PASS
#> 70      harmonised_eth_vals    PASS
#> 71  harmonised_eth_char_grp    PASS
#> 72 harmonised_eth_char_vals    PASS
#> 73        api_char_col_name    PASS
#> 74       api_char_col_label    PASS
#> 75        api_char_loc_code    PASS
#> 76    api_char_filter_items    PASS
#> 77       data_dict_col_name    PASS
#> 78       data_dict_fil_item WARNING
#>                                                                                                                                                                                                           message
#> 1                                                                                                                                                   All of the required columns are present in the metadata file.
#> 2                                                                                                                                                              There are no invalid columns in the metadata file.
#> 3                                                                                                                                                       All of the required columns are present in the data file.
#> 4                                                                                                      There are an equal number of rows in the metadata file (3) and non-mandatory columns in the data file (3).
#> 5                                                                                                                                                    All variables from the metadata were found in the data file.
#> 6                                                                                                                 All variables in the data file are observational units or are represented in the metadata file.
#> 7                                                                                                                                                      There are no spaces in the variable names in the datafile.
#> 8                                                                                                                                           The variable names in the data file follow the snake_case convention.
#> 9                                                                                                                                              All variable names in the data file start with a lowercase letter.
#> 10                                                                                                                                                         No indicators found containing typical filter entries.
#> 11                                                                                                          Neither 'characteristic' nor 'characteristic_group' were found as listed fields in the metadata file.
#> 12                                                                                                                                                                    col_type is always 'Filter' or 'Indicator'.
#> 13                                                                                                                                                No observational units have been included in the metadata file.
#> 14                                                                                                                                                The col_name column is completed for every row in the metadata.
#> 15                                                                                                                                                                                         All labels are unique.
#> 16                                                                                                                                                             No indicators have a filter_grouping_column value.
#> 17                                                                                                                                                                            There are no filter groups present.
#> 18                                                                                                                                                                            There are no filter groups present.
#> 19                                                                                                                                                                            There are no filter groups present.
#> 20                                                                                                                                                                            There are no filter groups present.
#> 21                                                                                                                                                   The label column is completed for every row in the metadata.
#> 22                                                                                                                                                                        No indicators have a filter_hint value.
#> 23                                                                                                                                                         No filters appear to be mislabelled geography columns.
#> 24                                                                                                                                                                         No filters have an indicator_dp value.
#> 25                                                                                                                                                                    There are no spaces in the col_name values.
#> 26                                                                                                                                                                                All col_name values are unique.
#> 27                                                                                                                                                       The indicator_dp column is completed for all indicators.
#> 28                                                                                                                                The indicator_dp column only contains blanks, zero, or positive integer values.
#> 29                                                                                                                                                                       No filters have an indicator_unit value.
#> 30                                                                                                                                                                            The indicator_unit values are valid
#> 31                                                                                                                                                                   No filters have an indicator_grouping value.
#> 32                                                                                                                        No problematic null or legacy no-data symbols were found in the data or metadata files.
#> 33                                                                                                                                                                           All filters have two or more levels.
#> 34                                                                                                                                                           The time_period column only contains numeric values.
#> 35                                                                                                                                                                      The time_identifier values are all valid.
#> 36                                                                                                                                                           There is only one time_identifier value in the data.
#> 37                                                                                                                                                                     The geographic_level values are all valid.
#> 38                                                                                                                                                                 There is only National level data in the file.
#> 39                                                                                                                                    The time_period length matches the time_identifier values in the data file.
#> 40                                                                                                                                                   The six digit time_period values refer to consecutive years.
#> 41                                                                                                                                                     All filters and groups have a default filter item present.
#> 42                                                                                                                                                                            There are no filter groups present.
#> 43                                                                                                                                                    All filters and groups have less than 25000 unique entries.
#> 44                                                                                                                                                       No filter labels contain leading or trailing whitespace.
#> 45                                                                                                                                            There are no Total or All values in the observational unit columns.
#> 46                                                                                                                                               There are no blank values in any filter or filter group columns.
#> 47                                                                 There are no duplicate rows in the data file. Note that School, Provider, Institution, and Planning area rows were not included in this check.
#> 48                                                                                                                                                        All country_code / country_name combinations are valid.
#> 49                                                                                                                        At least one of the region_code / region_name columns is not present in this data file.
#> 50                                                                                                                            At least one of the ward_code / ward_name columns is not present in this data file.
#> 51                                                                                                                            At least one of the pcon_code / pcon_name columns is not present in this data file.
#> 52                                                                                                                              At least one of the lad_code / lad_name columns is not present in this data file.
#> 53                                                                            At least one of the local_enterprise_partnership_code / local_enterprise_partnership_name columns is not present in this data file.
#> 54                                                                                                                            At least one of the lsip_code / lsip_name columns is not present in this data file.
#> 55                                                                                          At least one of the english_devolved_area_code / english_devolved_area_name columns is not present in this data file.
#> 56                                                                                                              At least one of the old_la_code / new_la_code / la_name columns is not present in this data file.
#> 57                                                                                                                                                        All geographic level columns are completed as expected.
#> 58                                                                                                                                                     No rows in the file will be ignored by the EES table tool.
#> 59                                                                                                                                                   Lower-level geography data is not present in this data file.
#> 60                                                                                                                                                      No local authority columns are present in this data file.
#> 61                                                                                                                                                             No regional columns are present in this data file.
#> 62                                                                                                                                                       There is no Local authority level data in the data file.
#> 63                                                                                                                                              There is no Local authority district level data in the data file.
#> 64                                                                                                                                                                       No applicable geographic levels to test.
#> 65                                                                                                                                            No applicable geographic levels to check for 'Not available' codes.
#> 66                                                                                                                                                   Lower-level geography data is not present in this data file.
#> 67                                                                                                                                                               All geographic columns are empty where expected.
#> 68                                                                                                                                             There are no blank values or GSS legacy symbols in any indicators.
#> 69                                                                                                                                                                      No standardised column name issues found.
#> 70                                                                                                                                                                                    No ethnicity columns found.
#> 71                                                                                                                                                                          No characteristic_group column found.
#> 72                                                                                                                                                      No characteristic_group and characteristic columns found.
#> 73                                                                                                                              All filter / indicator names are less than or equal to the character limit of 50.
#> 74                                                                                                                            All filter / indicator labels are less than or equal to the character limit of 100.
#> 75                                                                                                                                        All location codes are less than or equal to the character limit of 30.
#> 76                                                                                                                        All filter items / location names are less than or equal to the character limit of 120.
#> 77                                                                                                                                                         All col_names are consistent with the data dictionary.
#> 78 The following col_name / filter_item combinations are not present in the data dictionary and should not be used as part of an API data set until resolved: 'education_phase / All phases', 'sex / All pupils'.
#>                                                                                              guidance_url
#> 1                                                                                                    <NA>
#> 2                                                                                                    <NA>
#> 3                                                                                                    <NA>
#> 4                                                                                                    <NA>
#> 5                                                                                                    <NA>
#> 6                                                                                                    <NA>
#> 7                                                                                                    <NA>
#> 8                                                                                                    <NA>
#> 9                                                                                                    <NA>
#> 10                                                                                                   <NA>
#> 11                                                                                                   <NA>
#> 12                                                                                                   <NA>
#> 13                                                                                                   <NA>
#> 14                                                                                                   <NA>
#> 15                                                                                                   <NA>
#> 16                                                                                                   <NA>
#> 17                                                                                                   <NA>
#> 18                                                                                                   <NA>
#> 19                                                                                                   <NA>
#> 20                                                                                                   <NA>
#> 21                                                                                                   <NA>
#> 22                                                                                                   <NA>
#> 23                                                                                                   <NA>
#> 24                                                                                                   <NA>
#> 25                                                                                                   <NA>
#> 26                                                                                                   <NA>
#> 27                                                                                                   <NA>
#> 28                                                                                                   <NA>
#> 29                                                                                                   <NA>
#> 30                                                                                                   <NA>
#> 31                                                                                                   <NA>
#> 32                                                                                                   <NA>
#> 33                                                                                                   <NA>
#> 34                                                                                                   <NA>
#> 35                                                                                                   <NA>
#> 36                                                                                                   <NA>
#> 37                                                                                                   <NA>
#> 38                                                                                                   <NA>
#> 39                                                                                                   <NA>
#> 40                                                                                                   <NA>
#> 41                                                                                                   <NA>
#> 42                                                                                                   <NA>
#> 43                                                                                                   <NA>
#> 44                                                                                                   <NA>
#> 45                                                                                                   <NA>
#> 46                                                                                                   <NA>
#> 47                                                                                                   <NA>
#> 48                                                                                                   <NA>
#> 49                                                                                                   <NA>
#> 50                                                                                                   <NA>
#> 51                                                                                                   <NA>
#> 52                                                                                                   <NA>
#> 53                                                                                                   <NA>
#> 54                                                                                                   <NA>
#> 55                                                                                                   <NA>
#> 56                                                                                                   <NA>
#> 57                                                                                                   <NA>
#> 58                                                                                                   <NA>
#> 59                                                                                                   <NA>
#> 60                                                                                                   <NA>
#> 61                                                                                                   <NA>
#> 62                                                                                                   <NA>
#> 63                                                                                                   <NA>
#> 64                                                                                                   <NA>
#> 65                                                                                                   <NA>
#> 66                                                                                                   <NA>
#> 67                                                                                                   <NA>
#> 68                                                                                                   <NA>
#> 69                                                                                                   <NA>
#> 70                                                                                                   <NA>
#> 71                                                                                                   <NA>
#> 72                                                                                                   <NA>
#> 73                                                                                                   <NA>
#> 74                                                                                                   <NA>
#> 75                                                                                                   <NA>
#> 76                                                                                                   <NA>
#> 77                                                                                                   <NA>
#> 78 https://dfe-analytical-services.github.io/analysts-guide/statistics-production/api-data-standards.html
#>                  stage
#> 1     Precheck columns
#> 2     Precheck columns
#> 3     Precheck columns
#> 4     Precheck columns
#> 5  Precheck cross-file
#> 6  Precheck cross-file
#> 7        Check columns
#> 8        Check columns
#> 9        Check columns
#> 10       Check columns
#> 11       Check columns
#> 12       Precheck meta
#> 13       Precheck meta
#> 14       Precheck meta
#> 15          Check meta
#> 16          Check meta
#> 17          Check meta
#> 18          Check meta
#> 19          Check meta
#> 20          Check meta
#> 21          Check meta
#> 22          Check meta
#> 23          Check meta
#> 24          Check meta
#> 25          Check meta
#> 26          Check meta
#> 27          Check meta
#> 28          Check meta
#> 29          Check meta
#> 30          Check meta
#> 31          Check meta
#> 32       Check general
#> 33    Precheck filters
#> 34       Precheck time
#> 35       Precheck time
#> 36       Precheck time
#> 37  Precheck geography
#> 38  Precheck geography
#> 39          Check time
#> 40          Check time
#> 41       Check filters
#> 42       Check filters
#> 43       Check filters
#> 44       Check filters
#> 45       Check filters
#> 46       Check filters
#> 47       Check general
#> 48     Check geography
#> 49     Check geography
#> 50     Check geography
#> 51     Check geography
#> 52     Check geography
#> 53     Check geography
#> 54     Check geography
#> 55     Check geography
#> 56     Check geography
#> 57     Check geography
#> 58     Check geography
#> 59     Check geography
#> 60     Check geography
#> 61     Check geography
#> 62     Check geography
#> 63     Check geography
#> 64     Check geography
#> 65     Check geography
#> 66     Check geography
#> 67     Check geography
#> 68    Check indicators
#> 69    Check harmonised
#> 70    Check harmonised
#> 71    Check harmonised
#> 72    Check harmonised
#> 73           Check API
#> 74           Check API
#> 75           Check API
#> 76           Check API
#> 77           Check API
#> 78           Check API
```
