# eesyscreener

This is a package designed to provide documentation and reusable code
supporting the data standards for the [explore education statistics
(EES) platform](https://explore-education-statistics.service.gov.uk/).

This is the current form and single source of truth for the checks that
have steadily evolved over the years, from initial R code replacing
manual checking of CSV files in Excel, to a [screening report generator
using
rmarkdown](https://github.com/dfe-analytical-services/ees-data-screener),
to the [R Shiny
app](https://github.com/dfe-analytical-services/dfe-published-data-qa),
right through to this fully documented R package that has three main use
cases:

- Providing the logic behind the [data screener R Shiny
  app](https://github.com/dfe-analytical-services/dfe-published-data-qa),
  used to check files before upload
- Using that logic within EES itself through a [plumber API
  implementation](https://github.com/dfe-analytical-services/ees-screener-api),
  screening uploads into the service directly
- Analysts using the R functions within their own pipelines as
  pre-emptive quality assurance

The package contains:

- A core
  [`screen_csv()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_csv.md)
  function that will screen a pair of data and meta CSV files. This is
  built from
  [`screen_dfs()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_dfs.md),
  and
  [`screen_filenames()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_filenames.md)
  and the constituent individual `precheck_*()` and `check_*()`
  functions.
- Data objects containing required, optional, and acceptable values for
  use within explore education statistics
- Functions to generate test data
- Example datasets to aid testing and demonstration
- Additional functions to aid in screening / preparing data for EES

## Installation

eesyscreener is not currently available on CRAN. For the time being you
can install the development version from GitHub.

``` r
# install.packages("pak")
pak::pak("dfe-analytical-services/eesyscreener")
```

## Minimal example

This shows a quick reproducible example you can run in the console to
test with. It also shows an example of the output structure from the
core
[`screen_csv()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_csv.md)
function.

``` r
# Create example temporary CSV files
data_file <- tempfile(fileext = ".csv")
meta_file <- tempfile(fileext = ".meta.csv")

write.csv(eesyscreener::example_data, data_file, row.names = FALSE)
write.csv(eesyscreener::example_meta, meta_file, row.names = FALSE)

result <- eesyscreener::screen_csv(
  data_file,
  meta_file,
  "data.csv",
  "data.meta.csv"
)

result$results_table |>
  head()
#>              check result
#> 1  filename_spaces   PASS
#> 2  filename_spaces   PASS
#> 3 filename_special   PASS
#> 4 filename_special   PASS
#> 5  filenames_match   PASS
#> 6     col_req_meta   PASS
#>                                                            message guidance_url
#> 1                 'data.csv' does not have spaces in the filename.           NA
#> 2            'data.meta.csv' does not have spaces in the filename.           NA
#> 3              'data.csv' does not contain any special characters.           NA
#> 4         'data.meta.csv' does not contain any special characters.           NA
#> 5 The names of the files follow the recommended naming convention.           NA
#> 6    All of the required columns are present in the metadata file.           NA
#>              stage
#> 1         filename
#> 2         filename
#> 3         filename
#> 4         filename
#> 5         filename
#> 6 Precheck columns

result$overall_stage
#> [1] "Check meta checks"

result$passed
#> [1] FALSE

result$api_suitable
#> [1] FALSE

# Clean up temporary CSV files
invisible(file.remove(data_file))
invisible(file.remove(meta_file))
```

## Example CSVs

Quick examples of how to make use of the data within the package to
generate CSVs for testing:

``` r
write.csv(eesyscreener::example_data, "example_data.csv", row.names = FALSE)
write.csv(eesyscreener::example_meta, "example_data.meta.csv", row.names = FALSE)

# Generate a file pairing that will fail the tests by dropping a key column
write.csv(eesyscreener::example_data, "example_data.csv", row.names = FALSE)
write.csv(eesyscreener::example_meta[ , -1], "example_data.meta.csv", row.names = FALSE)
```

## Generate big test files

If you want to generate larger files for testing with, you can use the
[`generate_test_dfs()`](https://dfe-analytical-services.github.io/eesyscreener/reference/generate_test_dfs.md)
function to create files with any number of time periods, locations,
filters and indicators.

``` r
files <- eesyscreener::generate_test_dfs(
  years = 2013:2015, 
  pcon_names = "Sheffield Central", 
  pcon_codes = "E14000919", 
  num_filters = 2, 
  num_indicators = 3
)

# Data and metadata are returned in a list, to extract:
df <- files$data
df_meta <- files$meta
```

If you want to go bigger, combine with the [dfeR
package](https://dfe-analytical-services.github.io/dfeR/), to pass in
vectors of Parliamentary Constituencies.

The following example creates an example data and metadata pair with a
data set of just over 6 million rows. Formula to calculate rows is:

- length(years) \* length(pcon_codes) \* (5 ^ num_filters)

``` r
# Get a data frame of all Parliamentary Constituencies in England
pcons <- dfeR::fetch_pcons(countries = "England")

beefy <- eesyscreener::generate_test_dfs(
  years = c(1980:2025),
  pcon_codes = pcons$pcon_code,
  pcon_names = pcons$pcon_name,
  num_filters = 3,
  num_indicators = 45,
  verbose = TRUE
)

# Then to create CSVs, use duckplyr as it's a lot faster than base R
# roughly ~20 seconds compared to ~6 minutes
duckplyr::compute_csv(beefy$data, "beefy_data.csv")
write.csv(beefy$meta, "beefy_data.meta.csv", row.names = FALSE)
```

## Examples of behaviour

### Passing file

``` r
data_file <- tempfile(fileext = ".csv")
meta_file <- tempfile(fileext = ".meta.csv")
write.csv(eesyscreener::example_data, data_file, row.names = FALSE)
write.csv(eesyscreener::example_meta, meta_file, row.names = FALSE)

eesyscreener::screen_csv(data_file, meta_file, "data.csv", "data.meta.csv")
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
#> 11       cross_data_to_meta   PASS
#> 12         col_names_spaces   PASS
#> 13           col_snake_case   PASS
#> 14            col_var_start   PASS
#> 15          col_ind_smushed   PASS
#> 16   col_var_characteristic   PASS
#> 17            meta_col_type   PASS
#> 18             meta_ob_unit   PASS
#> 19            meta_col_name   PASS
#> 20          meta_dupe_label   PASS
#> 21             meta_fil_grp   PASS
#> 22        meta_fil_grp_dupe   PASS
#> 23      meta_fil_grp_is_fil   PASS
#> 24       meta_fil_grp_match   PASS
#> 25    meta_fil_grp_stripped   PASS
#> 26               meta_label   PASS
#> 27         meta_filter_hint   PASS
#> 28          meta_geog_catch   PASS
#> 29        meta_indicator_dp   FAIL
#> 30     meta_col_name_spaces   PASS
#> 31       meta_col_name_dupe   PASS
#> 32          meta_ind_dp_set   PASS
#> 33       meta_ind_dp_values   FAIL
#> 34            meta_ind_unit   PASS
#> 35 meta_ind_unit_validation   PASS
#> 36  meta_indicator_grouping   PASS
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
#> 11            All variables in the data file are observational units or are represented in the metadata file.
#> 12                                                 There are no spaces in the variable names in the datafile.
#> 13                                      The variable names in the data file follow the snake_case convention.
#> 14                                         All variable names in the data file start with a lowercase letter.
#> 15                                                     No indicators found containing typical filter entries.
#> 16      Neither 'characteristic' nor 'characteristic_group' were found as listed fields in the metadata file.
#> 17                                                                col_type is always 'Filter' or 'Indicator'.
#> 18                                            No observational units have been included in the metadata file.
#> 19                                            The col_name column is completed for every row in the metadata.
#> 20                                                                                     All labels are unique.
#> 21                                                         No indicators have a filter_grouping_column value.
#> 22                                                                        There are no filter groups present.
#> 23                                                                        There are no filter groups present.
#> 24                                                                        There are no filter groups present.
#> 25                                                                        There are no filter groups present.
#> 26                                               The label column is completed for every row in the metadata.
#> 27                                                                    No indicators have a filter_hint value.
#> 28                                                     No filters appear to be mislabelled geography columns.
#> 29                                        Filters should not have an indicator_dp value in the metadata file.
#> 30                                                                There are no spaces in the col_name values.
#> 31                                                                            All col_name values are unique.
#> 32                                                   The indicator_dp column is completed for all indicators.
#> 33   The indicator_dp column must only contain blanks, zero, or positive integer values in the metadata file.
#> 34                                                                   No filters have an indicator_unit value.
#> 35                                                                        The indicator_unit values are valid
#> 36                                                               No filters have an indicator_grouping value.
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
#> 11           NA Precheck cross-file
#> 12           NA       Check columns
#> 13           NA       Check columns
#> 14           NA       Check columns
#> 15           NA       Check columns
#> 16           NA       Check columns
#> 17           NA       Precheck meta
#> 18           NA       Precheck meta
#> 19           NA       Precheck meta
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
#> 36           NA          Check meta
#> 
#> $overall_stage
#> [1] "Check meta checks"
#> 
#> $passed
#> [1] FALSE
#> 
#> $api_suitable
#> [1] FALSE

invisible(file.remove(data_file))
invisible(file.remove(meta_file))
```

### Failing file

``` r
data_file <- tempfile(fileext = ".csv")
meta_file <- tempfile(fileext = ".meta.csv")
write.csv(eesyscreener::example_data, data_file, row.names = FALSE)
write.csv(eesyscreener::example_meta[, -1], meta_file, row.names = FALSE)

eesyscreener::screen_csv(data_file, meta_file, "data.csv", "data.meta.csv")
#> $results_table
#>              check result
#> 1  filename_spaces   PASS
#> 2  filename_spaces   PASS
#> 3 filename_special   PASS
#> 4 filename_special   PASS
#> 5  filenames_match   PASS
#> 6     col_req_meta   FAIL
#> 7 col_invalid_meta   PASS
#> 8     col_req_data   PASS
#> 9      col_to_rows   PASS
#>                                                                                                      message
#> 1                                                           'data.csv' does not have spaces in the filename.
#> 2                                                      'data.meta.csv' does not have spaces in the filename.
#> 3                                                        'data.csv' does not contain any special characters.
#> 4                                                   'data.meta.csv' does not contain any special characters.
#> 5                                           The names of the files follow the recommended naming convention.
#> 6                               The following required column is missing from the metadata file: 'col_name'.
#> 7                                                         There are no invalid columns in the metadata file.
#> 8                                                  All of the required columns are present in the data file.
#> 9 There are an equal number of rows in the metadata file (3) and non-mandatory columns in the data file (3).
#>   guidance_url            stage
#> 1           NA         filename
#> 2           NA         filename
#> 3           NA         filename
#> 4           NA         filename
#> 5           NA         filename
#> 6           NA Precheck columns
#> 7           NA Precheck columns
#> 8           NA Precheck columns
#> 9           NA Precheck columns
#> 
#> $overall_stage
#> [1] "Precheck columns checks"
#> 
#> $passed
#> [1] FALSE
#> 
#> $api_suitable
#> [1] FALSE

invisible(file.remove(data_file))
invisible(file.remove(meta_file))
```

### Failed test with guidance URL

``` r
data_file <- tempfile(fileext = ".csv")
meta_file <- tempfile(fileext = ".meta.csv")
write.csv(
  eesyscreener::example_data |> dplyr::mutate(time_identifier = "parsec"),
  data_file,
  row.names = FALSE
)
write.csv(eesyscreener::example_meta, meta_file, row.names = FALSE)

eesyscreener::screen_csv(data_file, meta_file, "data.csv", "data.meta.csv")
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
#> 11       cross_data_to_meta   PASS
#> 12         col_names_spaces   PASS
#> 13           col_snake_case   PASS
#> 14            col_var_start   PASS
#> 15          col_ind_smushed   PASS
#> 16   col_var_characteristic   PASS
#> 17            meta_col_type   PASS
#> 18             meta_ob_unit   PASS
#> 19            meta_col_name   PASS
#> 20          meta_dupe_label   PASS
#> 21             meta_fil_grp   PASS
#> 22        meta_fil_grp_dupe   PASS
#> 23      meta_fil_grp_is_fil   PASS
#> 24       meta_fil_grp_match   PASS
#> 25    meta_fil_grp_stripped   PASS
#> 26               meta_label   PASS
#> 27         meta_filter_hint   PASS
#> 28          meta_geog_catch   PASS
#> 29        meta_indicator_dp   FAIL
#> 30     meta_col_name_spaces   PASS
#> 31       meta_col_name_dupe   PASS
#> 32          meta_ind_dp_set   PASS
#> 33       meta_ind_dp_values   FAIL
#> 34            meta_ind_unit   PASS
#> 35 meta_ind_unit_validation   PASS
#> 36  meta_indicator_grouping   PASS
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
#> 11            All variables in the data file are observational units or are represented in the metadata file.
#> 12                                                 There are no spaces in the variable names in the datafile.
#> 13                                      The variable names in the data file follow the snake_case convention.
#> 14                                         All variable names in the data file start with a lowercase letter.
#> 15                                                     No indicators found containing typical filter entries.
#> 16      Neither 'characteristic' nor 'characteristic_group' were found as listed fields in the metadata file.
#> 17                                                                col_type is always 'Filter' or 'Indicator'.
#> 18                                            No observational units have been included in the metadata file.
#> 19                                            The col_name column is completed for every row in the metadata.
#> 20                                                                                     All labels are unique.
#> 21                                                         No indicators have a filter_grouping_column value.
#> 22                                                                        There are no filter groups present.
#> 23                                                                        There are no filter groups present.
#> 24                                                                        There are no filter groups present.
#> 25                                                                        There are no filter groups present.
#> 26                                               The label column is completed for every row in the metadata.
#> 27                                                                    No indicators have a filter_hint value.
#> 28                                                     No filters appear to be mislabelled geography columns.
#> 29                                        Filters should not have an indicator_dp value in the metadata file.
#> 30                                                                There are no spaces in the col_name values.
#> 31                                                                            All col_name values are unique.
#> 32                                                   The indicator_dp column is completed for all indicators.
#> 33   The indicator_dp column must only contain blanks, zero, or positive integer values in the metadata file.
#> 34                                                                   No filters have an indicator_unit value.
#> 35                                                                        The indicator_unit values are valid
#> 36                                                               No filters have an indicator_grouping value.
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
#> 11           NA Precheck cross-file
#> 12           NA       Check columns
#> 13           NA       Check columns
#> 14           NA       Check columns
#> 15           NA       Check columns
#> 16           NA       Check columns
#> 17           NA       Precheck meta
#> 18           NA       Precheck meta
#> 19           NA       Precheck meta
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
#> 36           NA          Check meta
#> 
#> $overall_stage
#> [1] "Check meta checks"
#> 
#> $passed
#> [1] FALSE
#> 
#> $api_suitable
#> [1] FALSE

invisible(file.remove(data_file))
invisible(file.remove(meta_file))
```

### Passing with warning

``` r
data_file <- tempfile(fileext = ".csv")
meta_file <- tempfile(fileext = ".meta.csv")
write.csv(eesyscreener::example_data, data_file, row.names = FALSE)
write.csv(
  eesyscreener::example_meta |>
    dplyr::mutate(indicator_dp = NA),
  meta_file,
  row.names = FALSE
)

eesyscreener::screen_csv(data_file, meta_file, "data.csv", "data.meta.csv")
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
#> 11       cross_data_to_meta   PASS
#> 12         col_names_spaces   PASS
#> 13           col_snake_case   PASS
#> 14            col_var_start   PASS
#> 15          col_ind_smushed   PASS
#> 16   col_var_characteristic   PASS
#> 17            meta_col_type   PASS
#> 18             meta_ob_unit   PASS
#> 19            meta_col_name   PASS
#> 20          meta_dupe_label   PASS
#> 21             meta_fil_grp   PASS
#> 22        meta_fil_grp_dupe   PASS
#> 23      meta_fil_grp_is_fil   PASS
#> 24       meta_fil_grp_match   PASS
#> 25    meta_fil_grp_stripped   PASS
#> 26               meta_label   PASS
#> 27         meta_filter_hint   PASS
#> 28          meta_geog_catch   PASS
#> 29        meta_indicator_dp   FAIL
#> 30     meta_col_name_spaces   PASS
#> 31       meta_col_name_dupe   PASS
#> 32          meta_ind_dp_set   PASS
#> 33       meta_ind_dp_values   FAIL
#> 34            meta_ind_unit   PASS
#> 35 meta_ind_unit_validation   PASS
#> 36  meta_indicator_grouping   PASS
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
#> 11            All variables in the data file are observational units or are represented in the metadata file.
#> 12                                                 There are no spaces in the variable names in the datafile.
#> 13                                      The variable names in the data file follow the snake_case convention.
#> 14                                         All variable names in the data file start with a lowercase letter.
#> 15                                                     No indicators found containing typical filter entries.
#> 16      Neither 'characteristic' nor 'characteristic_group' were found as listed fields in the metadata file.
#> 17                                                                col_type is always 'Filter' or 'Indicator'.
#> 18                                            No observational units have been included in the metadata file.
#> 19                                            The col_name column is completed for every row in the metadata.
#> 20                                                                                     All labels are unique.
#> 21                                                         No indicators have a filter_grouping_column value.
#> 22                                                                        There are no filter groups present.
#> 23                                                                        There are no filter groups present.
#> 24                                                                        There are no filter groups present.
#> 25                                                                        There are no filter groups present.
#> 26                                               The label column is completed for every row in the metadata.
#> 27                                                                    No indicators have a filter_hint value.
#> 28                                                     No filters appear to be mislabelled geography columns.
#> 29                                        Filters should not have an indicator_dp value in the metadata file.
#> 30                                                                There are no spaces in the col_name values.
#> 31                                                                            All col_name values are unique.
#> 32                                                   The indicator_dp column is completed for all indicators.
#> 33   The indicator_dp column must only contain blanks, zero, or positive integer values in the metadata file.
#> 34                                                                   No filters have an indicator_unit value.
#> 35                                                                        The indicator_unit values are valid
#> 36                                                               No filters have an indicator_grouping value.
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
#> 11           NA Precheck cross-file
#> 12           NA       Check columns
#> 13           NA       Check columns
#> 14           NA       Check columns
#> 15           NA       Check columns
#> 16           NA       Check columns
#> 17           NA       Precheck meta
#> 18           NA       Precheck meta
#> 19           NA       Precheck meta
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
#> 36           NA          Check meta
#> 
#> $overall_stage
#> [1] "Check meta checks"
#> 
#> $passed
#> [1] FALSE
#> 
#> $api_suitable
#> [1] FALSE

invisible(file.remove(data_file))
invisible(file.remove(meta_file))
```

### Failing with warning

``` r
data_file <- tempfile(fileext = ".csv")
meta_file <- tempfile(fileext = ".meta.csv")
write.csv(
  eesyscreener::example_data |> dplyr::mutate(time_identifier = "parsec"),
  data_file,
  row.names = FALSE
)
write.csv(
  eesyscreener::example_meta |>
    dplyr::mutate(indicator_dp = NA),
  meta_file,
  row.names = FALSE
)
eesyscreener::screen_csv(data_file, meta_file, "data.csv", "data.meta.csv")
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
#> 11       cross_data_to_meta   PASS
#> 12         col_names_spaces   PASS
#> 13           col_snake_case   PASS
#> 14            col_var_start   PASS
#> 15          col_ind_smushed   PASS
#> 16   col_var_characteristic   PASS
#> 17            meta_col_type   PASS
#> 18             meta_ob_unit   PASS
#> 19            meta_col_name   PASS
#> 20          meta_dupe_label   PASS
#> 21             meta_fil_grp   PASS
#> 22        meta_fil_grp_dupe   PASS
#> 23      meta_fil_grp_is_fil   PASS
#> 24       meta_fil_grp_match   PASS
#> 25    meta_fil_grp_stripped   PASS
#> 26               meta_label   PASS
#> 27         meta_filter_hint   PASS
#> 28          meta_geog_catch   PASS
#> 29        meta_indicator_dp   FAIL
#> 30     meta_col_name_spaces   PASS
#> 31       meta_col_name_dupe   PASS
#> 32          meta_ind_dp_set   PASS
#> 33       meta_ind_dp_values   FAIL
#> 34            meta_ind_unit   PASS
#> 35 meta_ind_unit_validation   PASS
#> 36  meta_indicator_grouping   PASS
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
#> 11            All variables in the data file are observational units or are represented in the metadata file.
#> 12                                                 There are no spaces in the variable names in the datafile.
#> 13                                      The variable names in the data file follow the snake_case convention.
#> 14                                         All variable names in the data file start with a lowercase letter.
#> 15                                                     No indicators found containing typical filter entries.
#> 16      Neither 'characteristic' nor 'characteristic_group' were found as listed fields in the metadata file.
#> 17                                                                col_type is always 'Filter' or 'Indicator'.
#> 18                                            No observational units have been included in the metadata file.
#> 19                                            The col_name column is completed for every row in the metadata.
#> 20                                                                                     All labels are unique.
#> 21                                                         No indicators have a filter_grouping_column value.
#> 22                                                                        There are no filter groups present.
#> 23                                                                        There are no filter groups present.
#> 24                                                                        There are no filter groups present.
#> 25                                                                        There are no filter groups present.
#> 26                                               The label column is completed for every row in the metadata.
#> 27                                                                    No indicators have a filter_hint value.
#> 28                                                     No filters appear to be mislabelled geography columns.
#> 29                                        Filters should not have an indicator_dp value in the metadata file.
#> 30                                                                There are no spaces in the col_name values.
#> 31                                                                            All col_name values are unique.
#> 32                                                   The indicator_dp column is completed for all indicators.
#> 33   The indicator_dp column must only contain blanks, zero, or positive integer values in the metadata file.
#> 34                                                                   No filters have an indicator_unit value.
#> 35                                                                        The indicator_unit values are valid
#> 36                                                               No filters have an indicator_grouping value.
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
#> 11           NA Precheck cross-file
#> 12           NA       Check columns
#> 13           NA       Check columns
#> 14           NA       Check columns
#> 15           NA       Check columns
#> 16           NA       Check columns
#> 17           NA       Precheck meta
#> 18           NA       Precheck meta
#> 19           NA       Precheck meta
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
#> 36           NA          Check meta
#> 
#> $overall_stage
#> [1] "Check meta checks"
#> 
#> $passed
#> [1] FALSE
#> 
#> $api_suitable
#> [1] FALSE

invisible(file.remove(data_file))
invisible(file.remove(meta_file))
```

### Passing but issues on API checks

Currently the API checks will only give warnings, as they are a warning
for all files and don’t stop upload. However, any warnings in the API
checks will prevent a dataset from being able to be published through
the API.

A api_suitable boolean is returned to allow for easy determination of
suitability for publishing through the API.

``` r
data_file <- tempfile(fileext = ".csv")
meta_file <- tempfile(fileext = ".meta.csv")
write.csv(eesyscreener::example_api_long, data_file, row.names = FALSE)
write.csv(eesyscreener::example_api_long_meta, meta_file, row.names = FALSE)

eesyscreener::screen_csv(data_file, meta_file, "data.csv", "data.meta.csv")
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
#> 11       cross_data_to_meta   PASS
#> 12         col_names_spaces   PASS
#> 13           col_snake_case   PASS
#> 14            col_var_start   PASS
#> 15          col_ind_smushed   PASS
#> 16   col_var_characteristic   PASS
#> 17            meta_col_type   PASS
#> 18             meta_ob_unit   PASS
#> 19            meta_col_name   PASS
#> 20          meta_dupe_label   PASS
#> 21             meta_fil_grp   PASS
#> 22        meta_fil_grp_dupe   PASS
#> 23      meta_fil_grp_is_fil   PASS
#> 24       meta_fil_grp_match   PASS
#> 25    meta_fil_grp_stripped   PASS
#> 26               meta_label   PASS
#> 27         meta_filter_hint   PASS
#> 28          meta_geog_catch   PASS
#> 29        meta_indicator_dp   FAIL
#> 30     meta_col_name_spaces   PASS
#> 31       meta_col_name_dupe   PASS
#> 32          meta_ind_dp_set   PASS
#> 33       meta_ind_dp_values   FAIL
#> 34            meta_ind_unit   PASS
#> 35 meta_ind_unit_validation   PASS
#> 36  meta_indicator_grouping   PASS
#>                                                                                                       message
#> 1                                                            'data.csv' does not have spaces in the filename.
#> 2                                                       'data.meta.csv' does not have spaces in the filename.
#> 3                                                         'data.csv' does not contain any special characters.
#> 4                                                    'data.meta.csv' does not contain any special characters.
#> 5                                            The names of the files follow the recommended naming convention.
#> 6                                               All of the required columns are present in the metadata file.
#> 7                                                          There are no invalid columns in the metadata file.
#> 8                                                   All of the required columns are present in the data file.
#> 9  There are an equal number of rows in the metadata file (4) and non-mandatory columns in the data file (4).
#> 10                                               All variables from the metadata were found in the data file.
#> 11            All variables in the data file are observational units or are represented in the metadata file.
#> 12                                                 There are no spaces in the variable names in the datafile.
#> 13                                      The variable names in the data file follow the snake_case convention.
#> 14                                         All variable names in the data file start with a lowercase letter.
#> 15                                                     No indicators found containing typical filter entries.
#> 16      Neither 'characteristic' nor 'characteristic_group' were found as listed fields in the metadata file.
#> 17                                                                col_type is always 'Filter' or 'Indicator'.
#> 18                                            No observational units have been included in the metadata file.
#> 19                                            The col_name column is completed for every row in the metadata.
#> 20                                                                                     All labels are unique.
#> 21                                                         No indicators have a filter_grouping_column value.
#> 22                                                                        There are no filter groups present.
#> 23                                                                        There are no filter groups present.
#> 24                                                                        There are no filter groups present.
#> 25                                                                        There are no filter groups present.
#> 26                                               The label column is completed for every row in the metadata.
#> 27                                                                    No indicators have a filter_hint value.
#> 28                                                     No filters appear to be mislabelled geography columns.
#> 29                                        Filters should not have an indicator_dp value in the metadata file.
#> 30                                                                There are no spaces in the col_name values.
#> 31                                                                            All col_name values are unique.
#> 32                                                   The indicator_dp column is completed for all indicators.
#> 33   The indicator_dp column must only contain blanks, zero, or positive integer values in the metadata file.
#> 34                                                                   No filters have an indicator_unit value.
#> 35                                                                        The indicator_unit values are valid
#> 36                                                               No filters have an indicator_grouping value.
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
#> 11           NA Precheck cross-file
#> 12           NA       Check columns
#> 13           NA       Check columns
#> 14           NA       Check columns
#> 15           NA       Check columns
#> 16           NA       Check columns
#> 17           NA       Precheck meta
#> 18           NA       Precheck meta
#> 19           NA       Precheck meta
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
#> 36           NA          Check meta
#> 
#> $overall_stage
#> [1] "Check meta checks"
#> 
#> $passed
#> [1] FALSE
#> 
#> $api_suitable
#> [1] FALSE

invisible(file.remove(data_file))
invisible(file.remove(meta_file))
```

## Contributing

Ideas for eesyscreener should first be raised as a [GitHub
issue](https://github.com/dfe-analytical-services/eesyscreener/issues/new/choose)
after which anyone is free to write the code and create a pull request
for review.

For more details on contributing to eesyscreener, see our [contributing
guidelines](https://dfe-analytical-services.github.io/eesyscreener/CONTRIBUTING.html).

Any questions regarding the package or wider service should be directed
to <explore.statistics@education.gov.uk>.
