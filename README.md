
<!-- README.md is generated from README.Rmd. Please edit that file -->

# eesyscreener <a href="https://dfe-analytical-services.github.io/eesyscreener/"><img src="" align="right" height="138" /></a>

<!-- badges: start -->

[![R-CMD-check](https://github.com/dfe-analytical-services/eesyscreener/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/dfe-analytical-services/eesyscreener/actions/workflows/R-CMD-check.yaml)
[![lintr](https://github.com/dfe-analytical-services/eesyscreener/actions/workflows/lint.yaml/badge.svg?branch=main)](https://github.com/dfe-analytical-services/eesyscreener/actions/workflows/lint.yaml)
[![pkgdown](https://github.com/dfe-analytical-services/eesyscreener/actions/workflows/pkgdown.yaml/badge.svg)](https://github.com/dfe-analytical-services/eesyscreener/actions/workflows/pkgdown.yaml)
[![Codecov test
coverage](https://codecov.io/gh/dfe-analytical-services/eesyscreener/graph/badge.svg)](https://app.codecov.io/gh/dfe-analytical-services/eesyscreener)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

\[IN DEVELOPMENT\]

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

- A core `screen_csv()` function, built from `screen_dfs()`, and
  `screen_filenames()` and the constituent individual checks, as well as
  a related wrapper function `screen_zip()`
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
core `screen_csv()` function.

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
#>                             check result
#> 1      check_filename_data_spaces   PASS
#> 2  check_filename_metadata_spaces   PASS
#> 3     check_filename_data_special   PASS
#> 4 check_filename_metadata_special   PASS
#> 5           check_filenames_match   PASS
#> 6                    col_req_meta   PASS
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
#> [1] "Passed"

result$passed
#> [1] TRUE

result$api_suitable
#> [1] TRUE

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
`generate_test_dfs()` function to create files with any number of time
periods, locations, filters and indicators.

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
#>                              check  result
#> 1       check_filename_data_spaces    PASS
#> 2   check_filename_metadata_spaces    PASS
#> 3      check_filename_data_special    PASS
#> 4  check_filename_metadata_special    PASS
#> 5            check_filenames_match    PASS
#> 6                     col_req_meta    PASS
#> 7                 col_invalid_meta    PASS
#> 8                     col_req_data    PASS
#> 9                      col_to_rows    PASS
#> 10                 col_name_spaces    PASS
#> 11              col_name_duplicate    PASS
#> 12                   meta_col_type    PASS
#> 13                    meta_ob_unit    PASS
#> 14                   meta_col_name    PASS
#> 15                 meta_ind_dp_set WARNING
#> 16            meta_duplicate_label    PASS
#> 17                   meta_col_name    PASS
#> 18          filter_group_is_filter    PASS
#> 19             filter_groups_match    PASS
#> 20                check_meta_label    PASS
#> 21                meta_filter_hint    PASS
#> 22                    indicator_dp    PASS
#> 23              indicator_grouping    PASS
#> 24                   time_id_valid    PASS
#> 25      check_api_char_column-name    PASS
#> 26     check_api_char_column-label    PASS
#> 27    check_api_char_location-code    PASS
#>                                                                                                                                   message
#> 1                                                                                        'data.csv' does not have spaces in the filename.
#> 2                                                                                   'data.meta.csv' does not have spaces in the filename.
#> 3                                                                                     'data.csv' does not contain any special characters.
#> 4                                                                                'data.meta.csv' does not contain any special characters.
#> 5                                                                        The names of the files follow the recommended naming convention.
#> 6                                                                           All of the required columns are present in the metadata file.
#> 7                                                                                      There are no invalid columns in the metadata file.
#> 8                                                                               All of the required columns are present in the data file.
#> 9                              There are an equal number of rows in the metadata file (3) and non-mandatory columns in the data file (3).
#> 10                                                                                            There are no spaces in the col_name values.
#> 11                                                                                                        All col_name values are unique.
#> 12                                                                                            col_type is always 'Filter' or 'Indicator'.
#> 13                                                                        No observational units have been included in the metadata file.
#> 14                                                                        The col_name column is completed for every row in the metadata.
#> 15 character(0) does not have a specified number of decimal places in the metadata file, this should be explicitly stated where possible.
#> 16                                                                                                                 All labels are unique.
#> 17                                                                                     No indicators have a filter_grouping_column value.
#> 18                                                                                                    There are no filter groups present.
#> 19                                                                                                    There are no filter groups present.
#> 20                                                                           The label column is completed for every row in the metadata.
#> 21                                                                                                No indicators have a filter_hint value.
#> 22                                                                                                 No filters have an indicator_dp value.
#> 23                                                                                           No filters have an indicator_grouping value.
#> 24                                                                                              The time_identifier values are all valid.
#> 25                                                      All filter / indicator names are less than or equal to the character limit of 50.
#> 26                                                     All filter / indicator labels are less than or equal to the character limit of 80.
#> 27                                                                All location codes are less than or equal to the character limit of 30.
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
#> 23           NA       Check meta
#> 24           NA    Precheck time
#> 25           NA        Check API
#> 26           NA        Check API
#> 27           NA        Check API
#> 
#> $overall_stage
#> [1] "Passed"
#> 
#> $passed
#> [1] TRUE
#> 
#> $api_suitable
#> [1] TRUE

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
#> Warning: Unknown or uninitialised column: `col_name`.
#> Unknown or uninitialised column: `col_name`.
#> Unknown or uninitialised column: `col_name`.
#> $results_table
#>                              check result
#> 1       check_filename_data_spaces   PASS
#> 2   check_filename_metadata_spaces   PASS
#> 3      check_filename_data_special   PASS
#> 4  check_filename_metadata_special   PASS
#> 5            check_filenames_match   PASS
#> 6                     col_req_meta   FAIL
#> 7                 col_invalid_meta   PASS
#> 8                     col_req_data   PASS
#> 9                      col_to_rows   PASS
#> 10                 col_name_spaces   PASS
#> 11              col_name_duplicate   PASS
#>                                                                                                       message
#> 1                                                            'data.csv' does not have spaces in the filename.
#> 2                                                       'data.meta.csv' does not have spaces in the filename.
#> 3                                                         'data.csv' does not contain any special characters.
#> 4                                                    'data.meta.csv' does not contain any special characters.
#> 5                                            The names of the files follow the recommended naming convention.
#> 6                                The following required column is missing from the metadata file: 'col_name'.
#> 7                                                          There are no invalid columns in the metadata file.
#> 8                                                   All of the required columns are present in the data file.
#> 9  There are an equal number of rows in the metadata file (3) and non-mandatory columns in the data file (3).
#> 10                                                                There are no spaces in the col_name values.
#> 11                                                                            All col_name values are unique.
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
#>                              check  result
#> 1       check_filename_data_spaces    PASS
#> 2   check_filename_metadata_spaces    PASS
#> 3      check_filename_data_special    PASS
#> 4  check_filename_metadata_special    PASS
#> 5            check_filenames_match    PASS
#> 6                     col_req_meta    PASS
#> 7                 col_invalid_meta    PASS
#> 8                     col_req_data    PASS
#> 9                      col_to_rows    PASS
#> 10                 col_name_spaces    PASS
#> 11              col_name_duplicate    PASS
#> 12                   meta_col_type    PASS
#> 13                    meta_ob_unit    PASS
#> 14                   meta_col_name    PASS
#> 15                 meta_ind_dp_set WARNING
#> 16            meta_duplicate_label    PASS
#> 17                   meta_col_name    PASS
#> 18          filter_group_is_filter    PASS
#> 19             filter_groups_match    PASS
#> 20                check_meta_label    PASS
#> 21                meta_filter_hint    PASS
#> 22                    indicator_dp    PASS
#> 23              indicator_grouping    PASS
#> 24                   time_id_valid    FAIL
#>                                                                                                                                   message
#> 1                                                                                        'data.csv' does not have spaces in the filename.
#> 2                                                                                   'data.meta.csv' does not have spaces in the filename.
#> 3                                                                                     'data.csv' does not contain any special characters.
#> 4                                                                                'data.meta.csv' does not contain any special characters.
#> 5                                                                        The names of the files follow the recommended naming convention.
#> 6                                                                           All of the required columns are present in the metadata file.
#> 7                                                                                      There are no invalid columns in the metadata file.
#> 8                                                                               All of the required columns are present in the data file.
#> 9                              There are an equal number of rows in the metadata file (3) and non-mandatory columns in the data file (3).
#> 10                                                                                            There are no spaces in the col_name values.
#> 11                                                                                                        All col_name values are unique.
#> 12                                                                                            col_type is always 'Filter' or 'Indicator'.
#> 13                                                                        No observational units have been included in the metadata file.
#> 14                                                                        The col_name column is completed for every row in the metadata.
#> 15 character(0) does not have a specified number of decimal places in the metadata file, this should be explicitly stated where possible.
#> 16                                                                                                                 All labels are unique.
#> 17                                                                                     No indicators have a filter_grouping_column value.
#> 18                                                                                                    There are no filter groups present.
#> 19                                                                                                    There are no filter groups present.
#> 20                                                                           The label column is completed for every row in the metadata.
#> 21                                                                                                No indicators have a filter_hint value.
#> 22                                                                                                 No filters have an indicator_dp value.
#> 23                                                                                           No filters have an indicator_grouping value.
#> 24                                                                             The following invalid time_identifier was found: 'parsec'.
#>                                                                                                            guidance_url
#> 1                                                                                                                  <NA>
#> 2                                                                                                                  <NA>
#> 3                                                                                                                  <NA>
#> 4                                                                                                                  <NA>
#> 5                                                                                                                  <NA>
#> 6                                                                                                                  <NA>
#> 7                                                                                                                  <NA>
#> 8                                                                                                                  <NA>
#> 9                                                                                                                  <NA>
#> 10                                                                                                                 <NA>
#> 11                                                                                                                 <NA>
#> 12                                                                                                                 <NA>
#> 13                                                                                                                 <NA>
#> 14                                                                                                                 <NA>
#> 15                                                                                                                 <NA>
#> 16                                                                                                                 <NA>
#> 17                                                                                                                 <NA>
#> 18                                                                                                                 <NA>
#> 19                                                                                                                 <NA>
#> 20                                                                                                                 <NA>
#> 21                                                                                                                 <NA>
#> 22                                                                                                                 <NA>
#> 23                                                                                                                 <NA>
#> 24 https://dfe-analytical-services.github.io/analysts-guide/statistics-production/ud.html#list-of-allowable-time-values
#>               stage
#> 1          filename
#> 2          filename
#> 3          filename
#> 4          filename
#> 5          filename
#> 6  Precheck columns
#> 7  Precheck columns
#> 8  Precheck columns
#> 9  Precheck columns
#> 10 Precheck columns
#> 11 Precheck columns
#> 12    Precheck meta
#> 13    Precheck meta
#> 14    Precheck meta
#> 15       Check meta
#> 16       Check meta
#> 17       Check meta
#> 18       Check meta
#> 19       Check meta
#> 20       Check meta
#> 21       Check meta
#> 22       Check meta
#> 23       Check meta
#> 24    Precheck time
#> 
#> $overall_stage
#> [1] "Precheck time checks"
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
#>                              check  result
#> 1       check_filename_data_spaces    PASS
#> 2   check_filename_metadata_spaces    PASS
#> 3      check_filename_data_special    PASS
#> 4  check_filename_metadata_special    PASS
#> 5            check_filenames_match    PASS
#> 6                     col_req_meta    PASS
#> 7                 col_invalid_meta    PASS
#> 8                     col_req_data    PASS
#> 9                      col_to_rows    PASS
#> 10                 col_name_spaces    PASS
#> 11              col_name_duplicate    PASS
#> 12                   meta_col_type    PASS
#> 13                    meta_ob_unit    PASS
#> 14                   meta_col_name    PASS
#> 15                 meta_ind_dp_set WARNING
#> 16            meta_duplicate_label    PASS
#> 17                   meta_col_name    PASS
#> 18          filter_group_is_filter    PASS
#> 19             filter_groups_match    PASS
#> 20                check_meta_label    PASS
#> 21                meta_filter_hint    PASS
#> 22                    indicator_dp    FAIL
#> 23              indicator_grouping    PASS
#>                                                                                                                                   message
#> 1                                                                                        'data.csv' does not have spaces in the filename.
#> 2                                                                                   'data.meta.csv' does not have spaces in the filename.
#> 3                                                                                     'data.csv' does not contain any special characters.
#> 4                                                                                'data.meta.csv' does not contain any special characters.
#> 5                                                                        The names of the files follow the recommended naming convention.
#> 6                                                                           All of the required columns are present in the metadata file.
#> 7                                                                                      There are no invalid columns in the metadata file.
#> 8                                                                               All of the required columns are present in the data file.
#> 9                              There are an equal number of rows in the metadata file (3) and non-mandatory columns in the data file (3).
#> 10                                                                                            There are no spaces in the col_name values.
#> 11                                                                                                        All col_name values are unique.
#> 12                                                                                            col_type is always 'Filter' or 'Indicator'.
#> 13                                                                        No observational units have been included in the metadata file.
#> 14                                                                        The col_name column is completed for every row in the metadata.
#> 15 character(0) does not have a specified number of decimal places in the metadata file, this should be explicitly stated where possible.
#> 16                                                                                                                 All labels are unique.
#> 17                                                                                     No indicators have a filter_grouping_column value.
#> 18                                                                                                    There are no filter groups present.
#> 19                                                                                                    There are no filter groups present.
#> 20                                                                           The label column is completed for every row in the metadata.
#> 21                                                                                                No indicators have a filter_hint value.
#> 22                                                                    Filters should not have an indicator_dp value in the metadata file.
#> 23                                                                                           No filters have an indicator_grouping value.
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
#> 23           NA       Check meta
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
#>                              check  result
#> 1       check_filename_data_spaces    PASS
#> 2   check_filename_metadata_spaces    PASS
#> 3      check_filename_data_special    PASS
#> 4  check_filename_metadata_special    PASS
#> 5            check_filenames_match    PASS
#> 6                     col_req_meta    PASS
#> 7                 col_invalid_meta    PASS
#> 8                     col_req_data    PASS
#> 9                      col_to_rows    PASS
#> 10                 col_name_spaces    PASS
#> 11              col_name_duplicate    PASS
#> 12                   meta_col_type    PASS
#> 13                    meta_ob_unit    PASS
#> 14                   meta_col_name    PASS
#> 15                 meta_ind_dp_set WARNING
#> 16            meta_duplicate_label    PASS
#> 17                   meta_col_name    PASS
#> 18          filter_group_is_filter    PASS
#> 19             filter_groups_match    PASS
#> 20                check_meta_label    PASS
#> 21                meta_filter_hint    PASS
#> 22                    indicator_dp    FAIL
#> 23              indicator_grouping    PASS
#>                                                                                                                                   message
#> 1                                                                                        'data.csv' does not have spaces in the filename.
#> 2                                                                                   'data.meta.csv' does not have spaces in the filename.
#> 3                                                                                     'data.csv' does not contain any special characters.
#> 4                                                                                'data.meta.csv' does not contain any special characters.
#> 5                                                                        The names of the files follow the recommended naming convention.
#> 6                                                                           All of the required columns are present in the metadata file.
#> 7                                                                                      There are no invalid columns in the metadata file.
#> 8                                                                               All of the required columns are present in the data file.
#> 9                              There are an equal number of rows in the metadata file (3) and non-mandatory columns in the data file (3).
#> 10                                                                                            There are no spaces in the col_name values.
#> 11                                                                                                        All col_name values are unique.
#> 12                                                                                            col_type is always 'Filter' or 'Indicator'.
#> 13                                                                        No observational units have been included in the metadata file.
#> 14                                                                        The col_name column is completed for every row in the metadata.
#> 15 character(0) does not have a specified number of decimal places in the metadata file, this should be explicitly stated where possible.
#> 16                                                                                                                 All labels are unique.
#> 17                                                                                     No indicators have a filter_grouping_column value.
#> 18                                                                                                    There are no filter groups present.
#> 19                                                                                                    There are no filter groups present.
#> 20                                                                           The label column is completed for every row in the metadata.
#> 21                                                                                                No indicators have a filter_hint value.
#> 22                                                                    Filters should not have an indicator_dp value in the metadata file.
#> 23                                                                                           No filters have an indicator_grouping value.
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
#> 23           NA       Check meta
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
#>                              check  result
#> 1       check_filename_data_spaces    PASS
#> 2   check_filename_metadata_spaces    PASS
#> 3      check_filename_data_special    PASS
#> 4  check_filename_metadata_special    PASS
#> 5            check_filenames_match    PASS
#> 6                     col_req_meta    PASS
#> 7                 col_invalid_meta    PASS
#> 8                     col_req_data    PASS
#> 9                      col_to_rows    PASS
#> 10                 col_name_spaces    PASS
#> 11              col_name_duplicate    PASS
#> 12                   meta_col_type    PASS
#> 13                    meta_ob_unit    PASS
#> 14                   meta_col_name    PASS
#> 15                 meta_ind_dp_set WARNING
#> 16            meta_duplicate_label    PASS
#> 17                   meta_col_name    PASS
#> 18          filter_group_is_filter    PASS
#> 19             filter_groups_match    PASS
#> 20                check_meta_label    PASS
#> 21                meta_filter_hint    PASS
#> 22                    indicator_dp    PASS
#> 23              indicator_grouping    PASS
#> 24                   time_id_valid    PASS
#> 25      check_api_char_column-name WARNING
#> 26     check_api_char_column-label WARNING
#> 27    check_api_char_location-code    PASS
#>                                                                                                                                                                                                                                                                                                                                      message
#> 1                                                                                                                                                                                                                                                                                           'data.csv' does not have spaces in the filename.
#> 2                                                                                                                                                                                                                                                                                      'data.meta.csv' does not have spaces in the filename.
#> 3                                                                                                                                                                                                                                                                                        'data.csv' does not contain any special characters.
#> 4                                                                                                                                                                                                                                                                                   'data.meta.csv' does not contain any special characters.
#> 5                                                                                                                                                                                                                                                                           The names of the files follow the recommended naming convention.
#> 6                                                                                                                                                                                                                                                                              All of the required columns are present in the metadata file.
#> 7                                                                                                                                                                                                                                                                                         There are no invalid columns in the metadata file.
#> 8                                                                                                                                                                                                                                                                                  All of the required columns are present in the data file.
#> 9                                                                                                                                                                                                                                 There are an equal number of rows in the metadata file (4) and non-mandatory columns in the data file (4).
#> 10                                                                                                                                                                                                                                                                                               There are no spaces in the col_name values.
#> 11                                                                                                                                                                                                                                                                                                           All col_name values are unique.
#> 12                                                                                                                                                                                                                                                                                               col_type is always 'Filter' or 'Indicator'.
#> 13                                                                                                                                                                                                                                                                           No observational units have been included in the metadata file.
#> 14                                                                                                                                                                                                                                                                           The col_name column is completed for every row in the metadata.
#> 15                                                                                                                                                                                                    character(0) does not have a specified number of decimal places in the metadata file, this should be explicitly stated where possible.
#> 16                                                                                                                                                                                                                                                                                                                    All labels are unique.
#> 17                                                                                                                                                                                                                                                                                        No indicators have a filter_grouping_column value.
#> 18                                                                                                                                                                                                                                                                                                       There are no filter groups present.
#> 19                                                                                                                                                                                                                                                                                                       There are no filter groups present.
#> 20                                                                                                                                                                                                                                                                              The label column is completed for every row in the metadata.
#> 21                                                                                                                                                                                                                                                                                                   No indicators have a filter_hint value.
#> 22                                                                                                                                                                                                                                                                                                    No filters have an indicator_dp value.
#> 23                                                                                                                                                                                                                                                                                              No filters have an indicator_grouping value.
#> 24                                                                                                                                                                                                                                                                                                 The time_identifier values are all valid.
#> 25                                                                                                                                                                            The following filter / indicator names exceed the character limit of 50 for type 'column-name': "mahoooooooooooooooooooooooooooooooooooooooooooooooooooosive".
#> 26 The following filter / indicator labels exceed the character limit of 80 for type 'column-label': "A very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very very long column name".
#> 27                                                                                                                                                                                                                                                                   All location codes are less than or equal to the character limit of 30.
#>                                                                                                                                              guidance_url
#> 1                                                                                                                                                    <NA>
#> 2                                                                                                                                                    <NA>
#> 3                                                                                                                                                    <NA>
#> 4                                                                                                                                                    <NA>
#> 5                                                                                                                                                    <NA>
#> 6                                                                                                                                                    <NA>
#> 7                                                                                                                                                    <NA>
#> 8                                                                                                                                                    <NA>
#> 9                                                                                                                                                    <NA>
#> 10                                                                                                                                                   <NA>
#> 11                                                                                                                                                   <NA>
#> 12                                                                                                                                                   <NA>
#> 13                                                                                                                                                   <NA>
#> 14                                                                                                                                                   <NA>
#> 15                                                                                                                                                   <NA>
#> 16                                                                                                                                                   <NA>
#> 17                                                                                                                                                   <NA>
#> 18                                                                                                                                                   <NA>
#> 19                                                                                                                                                   <NA>
#> 20                                                                                                                                                   <NA>
#> 21                                                                                                                                                   <NA>
#> 22                                                                                                                                                   <NA>
#> 23                                                                                                                                                   <NA>
#> 24                                                                                                                                                   <NA>
#> 25 https://dfe-analytical-services.github.io/analysts-guide/statistics-production/api-data-standards.html#character-limits-for-col_names-and-filter-items
#> 26 https://dfe-analytical-services.github.io/analysts-guide/statistics-production/api-data-standards.html#character-limits-for-col_names-and-filter-items
#> 27                                                                                                                                                   <NA>
#>               stage
#> 1          filename
#> 2          filename
#> 3          filename
#> 4          filename
#> 5          filename
#> 6  Precheck columns
#> 7  Precheck columns
#> 8  Precheck columns
#> 9  Precheck columns
#> 10 Precheck columns
#> 11 Precheck columns
#> 12    Precheck meta
#> 13    Precheck meta
#> 14    Precheck meta
#> 15       Check meta
#> 16       Check meta
#> 17       Check meta
#> 18       Check meta
#> 19       Check meta
#> 20       Check meta
#> 21       Check meta
#> 22       Check meta
#> 23       Check meta
#> 24    Precheck time
#> 25        Check API
#> 26        Check API
#> 27        Check API
#> 
#> $overall_stage
#> [1] "Passed"
#> 
#> $passed
#> [1] TRUE
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
