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

  keystring for creating log file. If given, the screening will write a
  log file to disk called eesyscreening_log\_\<log_key\>.json
  default=NULL

- log_dir:

  Directory within which to place the log file. default="./"

- verbose:

  logical, if TRUE prints feedback messages to console for every test,
  if FALSE run silently

- stop_on_error:

  logical, if TRUE will stop with an error if the result is "FAIL", and
  will throw genuine warning if result is "WARNING"

## Value

A list containing

1.  A table with the full results of the checks with four columns:

    - result of the check (PASS / FAIL / ADVISORY)

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
#>                               check result
#> 1        check_filename_data_spaces   PASS
#> 2    check_filename_metadata_spaces   PASS
#> 3       check_filename_data_special   PASS
#> 4   check_filename_metadata_special   PASS
#> 5             check_filenames_match   PASS
#> 6                      col_req_meta   PASS
#> 7                  col_invalid_meta   PASS
#> 8                      col_req_data   PASS
#> 9                       col_to_rows   PASS
#> 10                  col_name_spaces   PASS
#> 11               col_name_duplicate   PASS
#> 12                    meta_col_type   PASS
#> 13                     meta_ob_unit   PASS
#> 14                    meta_col_name   PASS
#> 15                  meta_ind_dp_set   PASS
#> 16             meta_duplicate_label   PASS
#> 17                    meta_col_name   PASS
#> 18           filter_group_is_filter   PASS
#> 19              filter_groups_match   PASS
#> 20                 check_meta_label   PASS
#> 21                 meta_filter_hint   PASS
#> 22                     indicator_dp   PASS
#> 23                    time_id_valid   PASS
#> 24 check_api_char_limit_column-name   PASS
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
#> 10                                                                There are no spaces in the col_name values.
#> 11                                                                            All col_name values are unique.
#> 12                                                                col_type is always 'Filter' or 'Indicator'.
#> 13                                            No observational units have been included in the metadata file.
#> 14                                            The col_name column is completed for every row in the metadata.
#> 15                                                   The indicator_dp column is completed for all indicators.
#> 16                                                                                     All labels are unique.
#> 17                                                         No indicators have a filter_grouping_column value.
#> 18                                                                        There are no filter groups present.
#> 19                                                                        There are no filter groups present.
#> 20                                               The label column is completed for every row in the metadata.
#> 21                                                                    No indicators have a filter_hint value.
#> 22                                                                     No filters have an indicator_dp value.
#> 23                                                                  The time_identifier values are all valid.
#> 24                          All filter / indicator names are less than or equal to the character limit of 50.
#>    guidance_url            stage
#> 1            NA         filename
#> 2            NA         filename
#> 3            NA         filename
#> 4            NA         filename
#> 5            NA         filename
#> 6            NA Precheck columns
#> 7            NA Precheck columns
#> 8            NA Precheck columns
#> 9            NA Precheck columns
#> 10           NA Precheck columns
#> 11           NA Precheck columns
#> 12           NA    Precheck meta
#> 13           NA    Precheck meta
#> 14           NA    Precheck meta
#> 15           NA       Check meta
#> 16           NA       Check meta
#> 17           NA       Check meta
#> 18           NA       Check meta
#> 19           NA       Check meta
#> 20           NA       Check meta
#> 21           NA       Check meta
#> 22           NA       Check meta
#> 23           NA    Precheck time
#> 24           NA        Check API
#> 
#> $overall_stage
#> [1] "Passed"
#> 
#> $passed
#> [1] TRUE
#> 
#> $api_suitable
#> [1] TRUE
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
#> ✔ There are no spaces in the col_name values.
#> ✔ All col_name values are unique.
#> ✔ col_type is always 'Filter' or 'Indicator'.
#> ✔ No observational units have been included in the metadata file.
#> ✔ The col_name column is completed for every row in the metadata.
#> ✔ The indicator_dp column is completed for all indicators.
#> ✔ All labels are unique.
#> ✔ No indicators have a filter_grouping_column value.
#> ✔ There are no filter groups present.
#> ✔ There are no filter groups present.
#> ✔ The label column is completed for every row in the metadata.
#> ✔ No indicators have a filter_hint value.
#> ✔ No filters have an indicator_dp value.
#> ✔ The time_identifier values are all valid.
#> ! A 'Total' entry or default filter item should be specified for the following filters and / or filter_groups where applicable: 'sex', 'education_phase'.
#> ✔ All filter / indicator names are less than or equal to the character limit of 50.
#> ✔ Data and metadata passed all checks
#> ✔ Data and metadata passed all checks
#> $results_table
#>                               check result
#> 1        check_filename_data_spaces   PASS
#> 2    check_filename_metadata_spaces   PASS
#> 3       check_filename_data_special   PASS
#> 4   check_filename_metadata_special   PASS
#> 5             check_filenames_match   PASS
#> 6                      col_req_meta   PASS
#> 7                  col_invalid_meta   PASS
#> 8                      col_req_data   PASS
#> 9                       col_to_rows   PASS
#> 10                  col_name_spaces   PASS
#> 11               col_name_duplicate   PASS
#> 12                    meta_col_type   PASS
#> 13                     meta_ob_unit   PASS
#> 14                    meta_col_name   PASS
#> 15                  meta_ind_dp_set   PASS
#> 16             meta_duplicate_label   PASS
#> 17                    meta_col_name   PASS
#> 18           filter_group_is_filter   PASS
#> 19              filter_groups_match   PASS
#> 20                 check_meta_label   PASS
#> 21                 meta_filter_hint   PASS
#> 22                     indicator_dp   PASS
#> 23                    time_id_valid   PASS
#> 24 check_api_char_limit_column-name   PASS
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
#> 10                                                                There are no spaces in the col_name values.
#> 11                                                                            All col_name values are unique.
#> 12                                                                col_type is always 'Filter' or 'Indicator'.
#> 13                                            No observational units have been included in the metadata file.
#> 14                                            The col_name column is completed for every row in the metadata.
#> 15                                                   The indicator_dp column is completed for all indicators.
#> 16                                                                                     All labels are unique.
#> 17                                                         No indicators have a filter_grouping_column value.
#> 18                                                                        There are no filter groups present.
#> 19                                                                        There are no filter groups present.
#> 20                                               The label column is completed for every row in the metadata.
#> 21                                                                    No indicators have a filter_hint value.
#> 22                                                                     No filters have an indicator_dp value.
#> 23                                                                  The time_identifier values are all valid.
#> 24                          All filter / indicator names are less than or equal to the character limit of 50.
#>    guidance_url            stage
#> 1            NA         filename
#> 2            NA         filename
#> 3            NA         filename
#> 4            NA         filename
#> 5            NA         filename
#> 6            NA Precheck columns
#> 7            NA Precheck columns
#> 8            NA Precheck columns
#> 9            NA Precheck columns
#> 10           NA Precheck columns
#> 11           NA Precheck columns
#> 12           NA    Precheck meta
#> 13           NA    Precheck meta
#> 14           NA    Precheck meta
#> 15           NA       Check meta
#> 16           NA       Check meta
#> 17           NA       Check meta
#> 18           NA       Check meta
#> 19           NA       Check meta
#> 20           NA       Check meta
#> 21           NA       Check meta
#> 22           NA       Check meta
#> 23           NA    Precheck time
#> 24           NA        Check API
#> 
#> $overall_stage
#> [1] "Passed"
#> 
#> $passed
#> [1] TRUE
#> 
#> $api_suitable
#> [1] TRUE
#> 

# Clean up temp files
invisible(file.remove(data_path))
invisible(file.remove(meta_path))
```
