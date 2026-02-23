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
#>                               check result
#> 1                      col_req_meta   PASS
#> 2                  col_invalid_meta   PASS
#> 3                      col_req_data   PASS
#> 4                       col_to_rows   PASS
#> 5                   col_name_spaces   PASS
#> 6                col_name_duplicate   PASS
#> 7                     meta_col_type   PASS
#> 8                      meta_ob_unit   PASS
#> 9                     meta_col_name   PASS
#> 10                  meta_ind_dp_set   PASS
#> 11             meta_duplicate_label   PASS
#> 12                    meta_col_name   PASS
#> 13           filter_group_is_filter   PASS
#> 14              filter_groups_match   PASS
#> 15                 check_meta_label   PASS
#> 16                 meta_filter_hint   PASS
#> 17                     indicator_dp   PASS
#> 18                    time_id_valid   PASS
#> 19 check_api_char_limit_column-name   PASS
#>                                                                                                       message
#> 1                                               All of the required columns are present in the metadata file.
#> 2                                                          There are no invalid columns in the metadata file.
#> 3                                                   All of the required columns are present in the data file.
#> 4  There are an equal number of rows in the metadata file (3) and non-mandatory columns in the data file (3).
#> 5                                                                 There are no spaces in the col_name values.
#> 6                                                                             All col_name values are unique.
#> 7                                                                 col_type is always 'Filter' or 'Indicator'.
#> 8                                             No observational units have been included in the metadata file.
#> 9                                             The col_name column is completed for every row in the metadata.
#> 10                                                   The indicator_dp column is completed for all indicators.
#> 11                                                                                     All labels are unique.
#> 12                                                         No indicators have a filter_grouping_column value.
#> 13                                                                        There are no filter groups present.
#> 14                                                                        There are no filter groups present.
#> 15                                               The label column is completed for every row in the metadata.
#> 16                                                                    No indicators have a filter_hint value.
#> 17                                                                     No filters have an indicator_dp value.
#> 18                                                                  The time_identifier values are all valid.
#> 19                          All filter / indicator names are less than or equal to the character limit of 50.
#>    guidance_url            stage
#> 1            NA Precheck columns
#> 2            NA Precheck columns
#> 3            NA Precheck columns
#> 4            NA Precheck columns
#> 5            NA Precheck columns
#> 6            NA Precheck columns
#> 7            NA    Precheck meta
#> 8            NA    Precheck meta
#> 9            NA    Precheck meta
#> 10           NA       Check meta
#> 11           NA       Check meta
#> 12           NA       Check meta
#> 13           NA       Check meta
#> 14           NA       Check meta
#> 15           NA       Check meta
#> 16           NA       Check meta
#> 17           NA       Check meta
#> 18           NA    Precheck time
#> 19           NA        Check API
```
