# Package index

## Screen files

- [`screen_csv()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_csv.md)
  : Run all checks against files
- [`screen_dfs()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_dfs.md)
  : Run all checks against data and metadata
- [`screen_filenames()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_filenames.md)
  : Run all checks against filenames

## Data dictionary

- [`data_dictionary`](https://dfe-analytical-services.github.io/eesyscreener/reference/data_dictionary.md)
  : Data dictionary

## Example datasets

- [`example_api_long`](https://dfe-analytical-services.github.io/eesyscreener/reference/example_api_long.md)
  : Example data that has a column name too long for the API
- [`example_api_long_meta`](https://dfe-analytical-services.github.io/eesyscreener/reference/example_api_long_meta.md)
  : Example metadata that has a column name too long for the API
- [`example_comma_data`](https://dfe-analytical-services.github.io/eesyscreener/reference/example_comma_data.md)
  : Example data that contains strings containing commas beyond the
  default sniffing length. The original can be obtained from the EES
  test suite
- [`example_comma_meta`](https://dfe-analytical-services.github.io/eesyscreener/reference/example_comma_meta.md)
  : Meta data to be used with comma_data
- [`example_data`](https://dfe-analytical-services.github.io/eesyscreener/reference/example_data.md)
  : Example data
- [`example_filter_group`](https://dfe-analytical-services.github.io/eesyscreener/reference/example_filter_group.md)
  : Example filter group data
- [`example_filter_group_meta`](https://dfe-analytical-services.github.io/eesyscreener/reference/example_filter_group_meta.md)
  : Example filter group metadata
- [`example_filter_group_wrow`](https://dfe-analytical-services.github.io/eesyscreener/reference/example_filter_group_wrow.md)
  : Example filter group with extra row data
- [`example_filter_group_wrow_meta`](https://dfe-analytical-services.github.io/eesyscreener/reference/example_filter_group_wrow_meta.md)
  : Example filter group metadata with extra row
- [`example_meta`](https://dfe-analytical-services.github.io/eesyscreener/reference/example_meta.md)
  : Example metadata
- [`example_output`](https://dfe-analytical-services.github.io/eesyscreener/reference/example_output.md)
  : Example screening output pre-generated from example_data and
  example_meta
- [`ees_robot_test_data`](https://dfe-analytical-services.github.io/eesyscreener/reference/ees_robot_test_data.md)
  : A set of the robot test files as used in EES UI tests. These are
  available from:
  https://github.com/dfe-analytical-services/explore-education-statistics/tree/dev/tests/robot-tests/tests/files

## Generate test files

- [`generate_test_dfs()`](https://dfe-analytical-services.github.io/eesyscreener/reference/generate_test_dfs.md)
  : EES-ily generate some beefy test files

## Reference values

Objects containing required, acceptable, or reference values,
e.g. mandatory column names

- [`req_data_cols`](https://dfe-analytical-services.github.io/eesyscreener/reference/req_data_cols.md)
  : Required data columns
- [`req_meta_cols`](https://dfe-analytical-services.github.io/eesyscreener/reference/req_meta_cols.md)
  : Required metadata columns
- [`optional_meta_cols`](https://dfe-analytical-services.github.io/eesyscreener/reference/optional_meta_cols.md)
  : Optional metadata columns
- [`acceptable_indicator_units`](https://dfe-analytical-services.github.io/eesyscreener/reference/acceptable_indicator_units.md)
  : Acceptable values for indicator units
- [`acceptable_time_ids`](https://dfe-analytical-services.github.io/eesyscreener/reference/acceptable_time_ids.md)
  : Acceptable time identifiers
- [`geography_df`](https://dfe-analytical-services.github.io/eesyscreener/reference/geography_df.md)
  : Acceptable geographic levels and their associated columns
- [`api_char_limits`](https://dfe-analytical-services.github.io/eesyscreener/reference/api_char_limits.md)
  : API character limits
- [`four_digit_identifiers`](https://dfe-analytical-services.github.io/eesyscreener/reference/four_digit_identifiers.md)
  : Time identifiers that should have 4 digit numbers
- [`six_digit_identifiers`](https://dfe-analytical-services.github.io/eesyscreener/reference/six_digit_identifiers.md)
  : Time identifiers that should have 6 digit numbers

## Filename checks

- [`check_filename_spaces()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_filename_spaces.md)
  : Check for spaces in filename
- [`check_filename_special()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_filename_special.md)
  : Check for special characters in filename
- [`check_filenames_match()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_filenames_match.md)
  : Check filenames line up between data and metadata files

## Pre-check necessary columns exist

Ensure the mandatory columns are present before running other checks on
the files.

- [`precheck_col_invalid_meta()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_col_invalid_meta.md)
  : Check there are no invalid columns in the metadata
- [`precheck_col_req_data()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_col_req_data.md)
  : Check all required columns are present in data
- [`precheck_col_req_meta()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_col_req_meta.md)
  : Check all required columns are present in metadata
- [`precheck_col_to_rows()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_col_to_rows.md)
  : Quick check of data columns vs metadata rows

## Pre-checks on metadata

These checks should be run before any other metadata checks, as they
validate core assumptions about the metadata file itself.

- [`precheck_meta_col_name()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_meta_col_name.md)
  : Check col_name is completed for all rows
- [`precheck_meta_col_type()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_meta_col_type.md)
  : Check col_type entries are valid
- [`precheck_meta_ob_unit()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_meta_ob_unit.md)
  : Check there are no observational units with rows in the metadata

## Metadata checks

- [`check_meta_col_name_duplicate()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_col_name_duplicate.md)
  : Check there are no duplicated column names
- [`check_meta_col_name_spaces()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_col_name_spaces.md)
  : Check that no col_name values have spaces
- [`check_meta_duplicate_label()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_duplicate_label.md)
  : Check there are no duplicate labels
- [`check_meta_filter_group()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_filter_group.md)
  : Check filter_group is not set for indicator rows
- [`check_meta_filter_group_is_filter()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_filter_group_is_filter.md)
  : Check that filter groups are filters
- [`check_meta_filter_group_match()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_filter_group_match.md)
  : Check filter groups match in meta and data
- [`check_meta_filter_group_stripped()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_filter_group_stripped.md)
  : Check filter groups are unique when stripping non-alphanumeric
  characters
- [`check_meta_filter_hint()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_filter_hint.md)
  : Check filter_hint is not set for indicator rows
- [`check_meta_geog_catch()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_geog_catch.md)
  : Check for geography columns mislabelled as filters
- [`check_meta_ind_dp_set()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_ind_dp_set.md)
  : Check indicator_dp is set for all indicator rows
- [`check_meta_ind_dp_values()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_ind_dp_values.md)
  : Check indicator_dp only contains blanks or positive integer values.
- [`check_meta_ind_unit()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_ind_unit.md)
  : Check indicator_dp is set for all indicator rows
- [`check_meta_ind_unit_validation()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_ind_unit_validation.md)
  : Check indicator values are valid
- [`check_meta_indicator_dp()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_indicator_dp.md)
  : Check indicator_dp is blank for all filters
- [`check_meta_indicator_grouping()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_indicator_grouping.md)
  : Check indicator_grouping is blank for all filters
- [`check_meta_label()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_label.md)
  : Check every row has a label

## Core data file structure

## Checks on column names

These checks validate the names of columns in the data files.

- [`check_col_names_spaces()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_col_names_spaces.md)
  : Check for spaces in variable names This function checks for spaces
  in the variable names of a given data frame.
- [`check_col_snake_case()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_col_snake_case.md)
  : Check that column names follow snake_case convention

## General checks

These can be run on any file, regardless of type or structure.

## Pre-checks on filters

## Pre-checks on time columns

These checks should be run before any other time checks, as they
validate core assumptions about the time columns.

- [`precheck_time_id_mix()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_time_id_mix.md)
  : Check the mix of time identifiers in the data file
- [`precheck_time_id_valid()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_time_id_valid.md)
  : Check all time_identifier values are valid
- [`precheck_time_period_num()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_time_period_num.md)
  : Check for any non-numeric time_period values

## Pre-checks on geography columns

These checks should be run before any other geography checks, as they
validate core assuptions about the geography columns.

- [`precheck_geog_level()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_geog_level.md)
  : Check that the geographic_level values are all valid.

## General data file checks

## Filter checks

- [`check_filter_defaults()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_filter_defaults.md)
  : Check filenames line up between data and metadata files
- [`check_filter_item_limit()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_filter_item_limit.md)
  : Check number of filter items are below limit Ensures that no filter
  contains more than 25,000 unique options, this is to protect the EES
  service against accidental data issues that can cause performance
  issues within the admin system.
- [`check_filter_whitespace()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_filter_whitespace.md)
  : Check no filter values have leading or trailing whitespaces

## Indicator checks

## Geography checks

## Time checks

- [`check_time_period()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_time_period.md)
  : Check that time periods match the time identifier
- [`check_time_period_six()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_time_period_six.md)
  : Check that 6 digit time periods give consecutive years

## API specific checks

- [`check_api_char_limit()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_api_char_limit.md)
  : Check if values exceed a character limit
- [`check_api_dict_col_names()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_api_dict_col_names.md)
  : Check if col_names are present in the data dictionary
