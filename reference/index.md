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
  https://github.com/dfe-analytical-services/explore-education-statistics/
  tree/dev/tests/robot-tests/tests/files

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
- [`acceptable_countries`](https://dfe-analytical-services.github.io/eesyscreener/reference/acceptable_countries.md)
  : Countries lookup
- [`acceptable_edas`](https://dfe-analytical-services.github.io/eesyscreener/reference/acceptable_edas.md)
  : English devolved areas lookup
- [`acceptable_extra_geog_options`](https://dfe-analytical-services.github.io/eesyscreener/reference/acceptable_extra_geog_options.md)
  : Extra geography options
- [`acceptable_indicator_units`](https://dfe-analytical-services.github.io/eesyscreener/reference/acceptable_indicator_units.md)
  : Acceptable values for indicator units
- [`acceptable_lads`](https://dfe-analytical-services.github.io/eesyscreener/reference/acceptable_lads.md)
  : Local authority districts lookup
- [`acceptable_las`](https://dfe-analytical-services.github.io/eesyscreener/reference/acceptable_las.md)
  : Local authorities lookup
- [`acceptable_leps`](https://dfe-analytical-services.github.io/eesyscreener/reference/acceptable_leps.md)
  : Local enterprise partnerships lookup
- [`acceptable_lsips`](https://dfe-analytical-services.github.io/eesyscreener/reference/acceptable_lsips.md)
  : Local skills improvement plan areas lookup
- [`acceptable_pcons`](https://dfe-analytical-services.github.io/eesyscreener/reference/acceptable_pcons.md)
  : Parliamentary constituencies lookup
- [`acceptable_regions`](https://dfe-analytical-services.github.io/eesyscreener/reference/acceptable_regions.md)
  : Regions lookup
- [`acceptable_time_ids`](https://dfe-analytical-services.github.io/eesyscreener/reference/acceptable_time_ids.md)
  : Acceptable time identifiers
- [`acceptable_wards`](https://dfe-analytical-services.github.io/eesyscreener/reference/acceptable_wards.md)
  : Wards lookup
- [`geography_df`](https://dfe-analytical-services.github.io/eesyscreener/reference/geography_df.md)
  : Acceptable geographic levels and their associated columns
- [`api_char_limits`](https://dfe-analytical-services.github.io/eesyscreener/reference/api_char_limits.md)
  : API character limits
- [`data_dictionary`](https://dfe-analytical-services.github.io/eesyscreener/reference/data_dictionary.md)
  : Data dictionary
- [`gss_symbols`](https://dfe-analytical-services.github.io/eesyscreener/reference/gss_symbols.md)
  : Acceptable values for GSS symbols
- [`legacy_gss_symbols`](https://dfe-analytical-services.github.io/eesyscreener/reference/legacy_gss_symbols.md)
  : Legacy values for GSS symbols
- [`four_digit_identifiers`](https://dfe-analytical-services.github.io/eesyscreener/reference/four_digit_identifiers.md)
  : Time identifiers that should have 4 digit numbers
- [`six_digit_identifiers`](https://dfe-analytical-services.github.io/eesyscreener/reference/six_digit_identifiers.md)
  : Time identifiers that should have 6 digit numbers
- [`potential_ob_units_regex`](https://dfe-analytical-services.github.io/eesyscreener/reference/potential_ob_units_regex.md)
  : Regex pattern for potential observational unit columns

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

## Pre-checks across data and metadata

These checks validate consistency between the data file and metadata
file.

- [`precheck_cross_data_to_meta()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_cross_data_to_meta.md)
  : Check all data variables exist in the metadata file
- [`precheck_cross_meta_to_data()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_cross_meta_to_data.md)
  : Check all metadata variables exist in the data file

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

- [`check_meta_col_name_dupe()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_col_name_dupe.md)
  : Check there are no duplicated column names
- [`check_meta_col_name_spaces()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_col_name_spaces.md)
  : Check that no col_name values have spaces
- [`check_meta_dupe_label()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_dupe_label.md)
  : Check there are no duplicate labels
- [`check_meta_fil_grp()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_fil_grp.md)
  : Check filter_group is not set for indicator rows
- [`check_meta_fil_grp_dupe()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_fil_grp_dupe.md)
  : Check all of the filter_group values are unique
- [`check_meta_fil_grp_is_fil()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_fil_grp_is_fil.md)
  : Check that filter groups are filters
- [`check_meta_fil_grp_match()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_fil_grp_match.md)
  : Check filter groups match in meta and data
- [`check_meta_fil_grp_stripped()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_fil_grp_stripped.md)
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

- [`check_col_ind_smushed()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_col_ind_smushed.md)
  : Check that no indicator column names contain typical filter entries
- [`check_col_names_spaces()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_col_names_spaces.md)
  : Check for spaces in variable names This function checks for spaces
  in the variable names of a given data frame.
- [`check_col_snake_case()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_col_snake_case.md)
  : Check that column names follow snake_case convention
- [`check_col_var_characteristic()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_col_var_characteristic.md)
  : Check for characteristic or characteristic_group variable names
- [`check_col_var_start()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_col_var_start.md)
  : Check that variable names start with a lowercase letter

## General checks

These can be run on any file, regardless of type or structure.

- [`check_general_null()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_general_null.md)
  : Check for null and legacy no-data symbols

## Pre-checks on filters

These checks should be run before any other filter checks, as they
validate core assumptions about the filter columns.

- [`precheck_filter_not_singular()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_filter_not_singular.md)
  : Check all filters have more than one level

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
validate core assumptions about the geography columns.

- [`precheck_geog_level()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_geog_level.md)
  : Check that the geographic_level values are all valid.
- [`precheck_geog_level_present()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_geog_level_present.md)
  : Check we have the right columns for the geographic level

## General data file checks

## Filter checks

- [`check_filter_blanks()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_filter_blanks.md)
  : Check for blank values in filter and filter group columns
- [`check_filter_defaults()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_filter_defaults.md)
  : Check default filter values are present in data
- [`check_filter_group_level()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_filter_group_level.md)
  : Check filter groups have an equal or lower number of levels
- [`check_filter_item_limit()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_filter_item_limit.md)
  : Check number of filter items are below limit Ensures that no filter
  contains more than 25,000 unique options, this is to protect the EES
  service against accidental data issues that can cause performance
  issues within the admin system.
- [`check_filter_ob_total()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_filter_ob_total.md)
  : Check for Total or All values in observational unit columns
- [`check_filter_whitespace()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_filter_whitespace.md)
  : Check no filter values have leading or trailing whitespace

## Indicator checks

- [`check_ind_invalid_entry()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_ind_invalid_entry.md)
  : Check for invalid values in indicators

## Geography checks

- [`check_geog_country_combos()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_country_combos.md)
  : Check country code and name combinations
- [`check_geog_eda_combos()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_eda_combos.md)
  : Check English devolved area code and name combinations
- [`check_geog_ignored_rows()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_ignored_rows.md)
  : Check for rows ignored by the EES table tool
- [`check_geog_la_col_present()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_la_col_present.md)
  : Check that all local authority columns are present together
- [`check_geog_la_combos()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_la_combos.md)
  : Check local authority code and name combinations
- [`check_geog_lad_combos()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_lad_combos.md)
  : Check local authority district code and name combinations
- [`check_geog_lep_combos()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_lep_combos.md)
  : Check local enterprise partnership code and name combinations
- [`check_geog_level_completed()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_level_completed.md)
  : Check geographic level columns are completed
- [`check_geog_lsip_combos()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_lsip_combos.md)
  : Check local skills improvement plan area code and name combinations
- [`check_geog_na()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_na.md)
  : Check NA geography codes have the correct name
- [`check_geog_na_code()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_na_code.md)
  : Check 'Not available' location codes
- [`check_geog_other_code_dupes()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_other_code_dupes.md)
  : Check other geography code duplicates
- [`check_geog_other_dupes()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_other_dupes.md)
  : Check for geography name to code duplicates in lower-level
  geographies
- [`check_geog_pcon_combos()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_pcon_combos.md)
  : Check parliamentary constituency code and name combinations
- [`check_geog_region_col_present()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_region_col_present.md)
  : Check region code and name columns are both present
- [`check_geog_region_combos()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_region_combos.md)
  : Check region code and name combinations
- [`check_geog_region_for_la()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_region_for_la.md)
  : Check that region columns are complete for Local authority rows
- [`check_geog_region_for_lad()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_region_for_lad.md)
  : Check that region columns are complete for Local authority district
  rows
- [`check_geog_ward_combos()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_geog_ward_combos.md)
  : Check ward code and name combinations

## Time checks

- [`check_time_period()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_time_period.md)
  : Check that time periods match the time identifier
- [`check_time_period_six()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_time_period_six.md)
  : Check that 6 digit time periods give consecutive years

## API specific checks

- [`check_api_char_col_label()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_api_char_col_label.md)
  : Check if column labels exceed a character limit
- [`check_api_char_col_name()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_api_char_col_name.md)
  : Check if column names exceed a character limit
- [`check_api_char_filter_items()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_api_char_filter_items.md)
  : Check if filter items or location names exceed character limit
- [`check_api_char_loc_code()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_api_char_loc_code.md)
  : Check if location codes exceed a character limit
- [`check_api_dict_col_names()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_api_dict_col_names.md)
  : Check if col_names are present in the data dictionary
