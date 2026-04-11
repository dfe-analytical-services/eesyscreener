# Run all checks against files

Run all of the checks in the eesyscreener package against your data file
and associated metadata file. It takes in the paths to the CSV files
then reads and parses the files and runs the checks in multiple stages,
the function will return early if any check in a stage fails.

## Usage

``` r
screen_csv(
  datapath,
  metapath,
  datafilename = NULL,
  metafilename = NULL,
  log_key = NULL,
  log_dir = "./",
  dd_checks = TRUE,
  verbose = FALSE,
  stop_on_error = FALSE
)
```

## Arguments

- datapath:

  Path to the data CSV file

- metapath:

  Path to the meta CSV file

- datafilename:

  Optional - the name of the data file, if not given it will be assumed
  from the path

- metafilename:

  Optional - the name of the metadata file, if not given it will be
  assumed from the path

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

## Value

A list containing

1.  A table with the full results of the checks with four columns:

    - result of the check (PASS / FAIL / WARNING)

    - message giving feedback about the check

    - group that the check belongs to

    - name of the check

2.  Overall stage the checks reached

3.  Boolean indicating if the data passed the screening

4.  Boolean indicating if the data is suitable for the API

## Examples

``` r
# Create temp files for the example
data_path <- file.path(tempdir(), "example.csv")
meta_path <- file.path(tempdir(), "example.meta.csv")

write.csv(example_data, data_path, row.names = FALSE)
write.csv(example_meta, meta_path, row.names = FALSE)

screen_csv(data_path, meta_path)
#> $results_table
#>                       check result
#> 1           filename_spaces   PASS
#> 2           filename_spaces   PASS
#> 3          filename_special   PASS
#> 4          filename_special   PASS
#> 5           filenames_match   PASS
#> 6              col_req_meta   PASS
#> 7          col_invalid_meta   PASS
#> 8              col_req_data   PASS
#> 9               col_to_rows   PASS
#> 10       cross_meta_to_data   PASS
#> 11         col_names_spaces   PASS
#> 12           col_snake_case   PASS
#> 13            col_var_start   PASS
#> 14          col_ind_smushed   PASS
#> 15   col_var_characteristic   PASS
#> 16            meta_col_type   PASS
#> 17             meta_ob_unit   PASS
#> 18            meta_col_name   PASS
#> 19          meta_dupe_label   PASS
#> 20             meta_fil_grp   PASS
#> 21        meta_fil_grp_dupe   PASS
#> 22      meta_fil_grp_is_fil   PASS
#> 23       meta_fil_grp_match   PASS
#> 24    meta_fil_grp_stripped   PASS
#> 25               meta_label   PASS
#> 26         meta_filter_hint   PASS
#> 27          meta_geog_catch   PASS
#> 28        meta_indicator_dp   FAIL
#> 29     meta_col_name_spaces   PASS
#> 30       meta_col_name_dupe   PASS
#> 31          meta_ind_dp_set   PASS
#> 32       meta_ind_dp_values   FAIL
#> 33            meta_ind_unit   PASS
#> 34 meta_ind_unit_validation   PASS
#> 35  meta_indicator_grouping   PASS
#>                                                                                                       message
#> 1                                                         'example.csv' does not have spaces in the filename.
#> 2                                                    'example.meta.csv' does not have spaces in the filename.
#> 3                                                      'example.csv' does not contain any special characters.
#> 4                                                 'example.meta.csv' does not contain any special characters.
#> 5                                            The names of the files follow the recommended naming convention.
#> 6                                               All of the required columns are present in the metadata file.
#> 7                                                          There are no invalid columns in the metadata file.
#> 8                                                   All of the required columns are present in the data file.
#> 9  There are an equal number of rows in the metadata file (3) and non-mandatory columns in the data file (3).
#> 10                                               All variables from the metadata were found in the data file.
#> 11                                                 There are no spaces in the variable names in the datafile.
#> 12                                      The variable names in the data file follow the snake_case convention.
#> 13                                         All variable names in the data file start with a lowercase letter.
#> 14                                                     No indicators found containing typical filter entries.
#> 15      Neither 'characteristic' nor 'characteristic_group' were found as listed fields in the metadata file.
#> 16                                                                col_type is always 'Filter' or 'Indicator'.
#> 17                                            No observational units have been included in the metadata file.
#> 18                                            The col_name column is completed for every row in the metadata.
#> 19                                                                                     All labels are unique.
#> 20                                                         No indicators have a filter_grouping_column value.
#> 21                                                                        There are no filter groups present.
#> 22                                                                        There are no filter groups present.
#> 23                                                                        There are no filter groups present.
#> 24                                                                        There are no filter groups present.
#> 25                                               The label column is completed for every row in the metadata.
#> 26                                                                    No indicators have a filter_hint value.
#> 27                                                     No filters appear to be mislabelled geography columns.
#> 28                                        Filters should not have an indicator_dp value in the metadata file.
#> 29                                                                There are no spaces in the col_name values.
#> 30                                                                            All col_name values are unique.
#> 31                                                   The indicator_dp column is completed for all indicators.
#> 32   The indicator_dp column must only contain blanks, zero, or positive integer values in the metadata file.
#> 33                                                                   No filters have an indicator_unit value.
#> 34                                                                        The indicator_unit values are valid
#> 35                                                               No filters have an indicator_grouping value.
#>    guidance_url               stage
#> 1            NA            filename
#> 2            NA            filename
#> 3            NA            filename
#> 4            NA            filename
#> 5            NA            filename
#> 6            NA    Precheck columns
#> 7            NA    Precheck columns
#> 8            NA    Precheck columns
#> 9            NA    Precheck columns
#> 10           NA Precheck cross-file
#> 11           NA       Check columns
#> 12           NA       Check columns
#> 13           NA       Check columns
#> 14           NA       Check columns
#> 15           NA       Check columns
#> 16           NA       Precheck meta
#> 17           NA       Precheck meta
#> 18           NA       Precheck meta
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
#> 32           NA          Check meta
#> 33           NA          Check meta
#> 34           NA          Check meta
#> 35           NA          Check meta
#> 
#> $overall_stage
#> [1] "Check meta checks"
#> 
#> $passed
#> [1] FALSE
#> 
#> $api_suitable
#> [1] FALSE
#> 

screen_csv(
  data_path,
  meta_path,
  "data.csv",
  "data.meta.csv",
  verbose = TRUE
)
#> ✔ 'data.csv' does not have spaces in the filename.
#> ✔ 'data.meta.csv' does not have spaces in the filename.
#> ✔ 'data.csv' does not contain any special characters.
#> ✔ 'data.meta.csv' does not contain any special characters.
#> ✔ The names of the files follow the recommended naming convention.
#> ✔ Filenames passed all checks
#> ✔ All of the required columns are present in the metadata file.
#> ✔ There are no invalid columns in the metadata file.
#> ✔ All of the required columns are present in the data file.
#> ✔ There are an equal number of rows in the metadata file (3) and non-mandatory columns in the data file (3).
#> ✔ All variables from the metadata were found in the data file.
#> ✔ There are no spaces in the variable names in the datafile.
#> ✔ The variable names in the data file follow the snake_case convention.
#> ✔ All variable names in the data file start with a lowercase letter.
#> ✔ No indicators found containing typical filter entries.
#> ✔ Neither 'characteristic' nor 'characteristic_group' were found as listed fields in the metadata file.
#> ✔ col_type is always 'Filter' or 'Indicator'.
#> ✔ No observational units have been included in the metadata file.
#> ✔ The col_name column is completed for every row in the metadata.
#> ✔ All labels are unique.
#> ✔ No indicators have a filter_grouping_column value.
#> ✔ There are no filter groups present.
#> ✔ There are no filter groups present.
#> ✔ There are no filter groups present.
#> ✔ There are no filter groups present.
#> ✔ The label column is completed for every row in the metadata.
#> ✔ No indicators have a filter_hint value.
#> ✔ No filters appear to be mislabelled geography columns.
#> ✖ Filters should not have an indicator_dp value in the metadata file.
#> ✔ There are no spaces in the col_name values.
#> ✔ All col_name values are unique.
#> ✔ The indicator_dp column is completed for all indicators.
#> ✖ The indicator_dp column must only contain blanks, zero, or positive integer values in the metadata file.
#> ✔ No filters have an indicator_unit value.
#> ✔ The indicator_unit values are valid
#> ✔ No filters have an indicator_grouping value.
#> $results_table
#>                       check result
#> 1           filename_spaces   PASS
#> 2           filename_spaces   PASS
#> 3          filename_special   PASS
#> 4          filename_special   PASS
#> 5           filenames_match   PASS
#> 6              col_req_meta   PASS
#> 7          col_invalid_meta   PASS
#> 8              col_req_data   PASS
#> 9               col_to_rows   PASS
#> 10       cross_meta_to_data   PASS
#> 11         col_names_spaces   PASS
#> 12           col_snake_case   PASS
#> 13            col_var_start   PASS
#> 14          col_ind_smushed   PASS
#> 15   col_var_characteristic   PASS
#> 16            meta_col_type   PASS
#> 17             meta_ob_unit   PASS
#> 18            meta_col_name   PASS
#> 19          meta_dupe_label   PASS
#> 20             meta_fil_grp   PASS
#> 21        meta_fil_grp_dupe   PASS
#> 22      meta_fil_grp_is_fil   PASS
#> 23       meta_fil_grp_match   PASS
#> 24    meta_fil_grp_stripped   PASS
#> 25               meta_label   PASS
#> 26         meta_filter_hint   PASS
#> 27          meta_geog_catch   PASS
#> 28        meta_indicator_dp   FAIL
#> 29     meta_col_name_spaces   PASS
#> 30       meta_col_name_dupe   PASS
#> 31          meta_ind_dp_set   PASS
#> 32       meta_ind_dp_values   FAIL
#> 33            meta_ind_unit   PASS
#> 34 meta_ind_unit_validation   PASS
#> 35  meta_indicator_grouping   PASS
#>                                                                                                       message
#> 1                                                            'data.csv' does not have spaces in the filename.
#> 2                                                       'data.meta.csv' does not have spaces in the filename.
#> 3                                                         'data.csv' does not contain any special characters.
#> 4                                                    'data.meta.csv' does not contain any special characters.
#> 5                                            The names of the files follow the recommended naming convention.
#> 6                                               All of the required columns are present in the metadata file.
#> 7                                                          There are no invalid columns in the metadata file.
#> 8                                                   All of the required columns are present in the data file.
#> 9  There are an equal number of rows in the metadata file (3) and non-mandatory columns in the data file (3).
#> 10                                               All variables from the metadata were found in the data file.
#> 11                                                 There are no spaces in the variable names in the datafile.
#> 12                                      The variable names in the data file follow the snake_case convention.
#> 13                                         All variable names in the data file start with a lowercase letter.
#> 14                                                     No indicators found containing typical filter entries.
#> 15      Neither 'characteristic' nor 'characteristic_group' were found as listed fields in the metadata file.
#> 16                                                                col_type is always 'Filter' or 'Indicator'.
#> 17                                            No observational units have been included in the metadata file.
#> 18                                            The col_name column is completed for every row in the metadata.
#> 19                                                                                     All labels are unique.
#> 20                                                         No indicators have a filter_grouping_column value.
#> 21                                                                        There are no filter groups present.
#> 22                                                                        There are no filter groups present.
#> 23                                                                        There are no filter groups present.
#> 24                                                                        There are no filter groups present.
#> 25                                               The label column is completed for every row in the metadata.
#> 26                                                                    No indicators have a filter_hint value.
#> 27                                                     No filters appear to be mislabelled geography columns.
#> 28                                        Filters should not have an indicator_dp value in the metadata file.
#> 29                                                                There are no spaces in the col_name values.
#> 30                                                                            All col_name values are unique.
#> 31                                                   The indicator_dp column is completed for all indicators.
#> 32   The indicator_dp column must only contain blanks, zero, or positive integer values in the metadata file.
#> 33                                                                   No filters have an indicator_unit value.
#> 34                                                                        The indicator_unit values are valid
#> 35                                                               No filters have an indicator_grouping value.
#>    guidance_url               stage
#> 1            NA            filename
#> 2            NA            filename
#> 3            NA            filename
#> 4            NA            filename
#> 5            NA            filename
#> 6            NA    Precheck columns
#> 7            NA    Precheck columns
#> 8            NA    Precheck columns
#> 9            NA    Precheck columns
#> 10           NA Precheck cross-file
#> 11           NA       Check columns
#> 12           NA       Check columns
#> 13           NA       Check columns
#> 14           NA       Check columns
#> 15           NA       Check columns
#> 16           NA       Precheck meta
#> 17           NA       Precheck meta
#> 18           NA       Precheck meta
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
#> 32           NA          Check meta
#> 33           NA          Check meta
#> 34           NA          Check meta
#> 35           NA          Check meta
#> 
#> $overall_stage
#> [1] "Check meta checks"
#> 
#> $passed
#> [1] FALSE
#> 
#> $api_suitable
#> [1] FALSE
#> 

# Clean up temp files
invisible(file.remove(data_path))
invisible(file.remove(meta_path))
```
