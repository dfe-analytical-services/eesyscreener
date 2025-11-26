# eesyscreener [![]()](https://dfe-analytical-services.github.io/eesyscreener/)

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

- A core
  [`screen_csv()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_csv.md)
  function, built from
  [`screen_dfs()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_dfs.md),
  and
  [`screen_filenames()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_filenames.md)
  and the constituent individual checks, as well as a related wrapper
  function `screen_zip()`
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
#> 10                    meta_col_type   PASS
#> 11                     meta_ob_unit   PASS
#> 12                    meta_col_name   PASS
#> 13                    meta_col_name   PASS
#> 14                    time_id_valid   PASS
#> 15 check_api_char_limit_column-name   PASS
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
#> 10                                                                col_type is always 'Filter' or 'Indicator'.
#> 11                                            No observational units have been included in the metadata file.
#> 12                                            The col_name column is completed for every row in the metadata.
#> 13                                                   The indicator_dp column is completed for all indicators.
#> 14                                                                  The time_identifier values are all valid.
#> 15                          All filter / indicator names are less than or equal to the character limit of 50.
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
#> 10           NA    Precheck meta
#> 11           NA    Precheck meta
#> 12           NA    Precheck meta
#> 13           NA       Check meta
#> 14           NA    Precheck time
#> 15           NA        Check API
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
#> $results_table
#>                             check result
#> 1      check_filename_data_spaces   PASS
#> 2  check_filename_metadata_spaces   PASS
#> 3     check_filename_data_special   PASS
#> 4 check_filename_metadata_special   PASS
#> 5           check_filenames_match   PASS
#> 6                    col_req_meta   FAIL
#> 7                col_invalid_meta   PASS
#> 8                    col_req_data   PASS
#> 9                     col_to_rows   PASS
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
#>                              check result
#> 1       check_filename_data_spaces   PASS
#> 2   check_filename_metadata_spaces   PASS
#> 3      check_filename_data_special   PASS
#> 4  check_filename_metadata_special   PASS
#> 5            check_filenames_match   PASS
#> 6                     col_req_meta   PASS
#> 7                 col_invalid_meta   PASS
#> 8                     col_req_data   PASS
#> 9                      col_to_rows   PASS
#> 10                   meta_col_type   PASS
#> 11                    meta_ob_unit   PASS
#> 12                   meta_col_name   PASS
#> 13                   meta_col_name   PASS
#> 14                   time_id_valid   FAIL
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
#> 10                                                                col_type is always 'Filter' or 'Indicator'.
#> 11                                            No observational units have been included in the metadata file.
#> 12                                            The col_name column is completed for every row in the metadata.
#> 13                                                   The indicator_dp column is completed for all indicators.
#> 14                                                 The following invalid time_identifier was found: 'parsec'.
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
#> 14 https://dfe-analytical-services.github.io/analysts-guide/statistics-production/ud.html#list-of-allowable-time-values
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
#> 10    Precheck meta
#> 11    Precheck meta
#> 12    Precheck meta
#> 13       Check meta
#> 14    Precheck time
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
#>                               check  result
#> 1        check_filename_data_spaces    PASS
#> 2    check_filename_metadata_spaces    PASS
#> 3       check_filename_data_special    PASS
#> 4   check_filename_metadata_special    PASS
#> 5             check_filenames_match    PASS
#> 6                      col_req_meta    PASS
#> 7                  col_invalid_meta    PASS
#> 8                      col_req_data    PASS
#> 9                       col_to_rows    PASS
#> 10                    meta_col_type    PASS
#> 11                     meta_ob_unit    PASS
#> 12                    meta_col_name    PASS
#> 13                    meta_col_name WARNING
#> 14                    time_id_valid    PASS
#> 15 check_api_char_limit_column-name    PASS
#>                                                                                                                                      message
#> 1                                                                                           'data.csv' does not have spaces in the filename.
#> 2                                                                                      'data.meta.csv' does not have spaces in the filename.
#> 3                                                                                        'data.csv' does not contain any special characters.
#> 4                                                                                   'data.meta.csv' does not contain any special characters.
#> 5                                                                           The names of the files follow the recommended naming convention.
#> 6                                                                              All of the required columns are present in the metadata file.
#> 7                                                                                         There are no invalid columns in the metadata file.
#> 8                                                                                  All of the required columns are present in the data file.
#> 9                                 There are an equal number of rows in the metadata file (3) and non-mandatory columns in the data file (3).
#> 10                                                                                               col_type is always 'Filter' or 'Indicator'.
#> 11                                                                           No observational units have been included in the metadata file.
#> 12                                                                           The col_name column is completed for every row in the metadata.
#> 13 enrolment_count does not have a specified number of decimal places in the metadata file, this should be explicitly stated where possible.
#> 14                                                                                                 The time_identifier values are all valid.
#> 15                                                         All filter / indicator names are less than or equal to the character limit of 50.
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
#> 10           NA    Precheck meta
#> 11           NA    Precheck meta
#> 12           NA    Precheck meta
#> 13           NA       Check meta
#> 14           NA    Precheck time
#> 15           NA        Check API
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
#> 10                   meta_col_type    PASS
#> 11                    meta_ob_unit    PASS
#> 12                   meta_col_name    PASS
#> 13                   meta_col_name WARNING
#> 14                   time_id_valid    FAIL
#>                                                                                                                                      message
#> 1                                                                                           'data.csv' does not have spaces in the filename.
#> 2                                                                                      'data.meta.csv' does not have spaces in the filename.
#> 3                                                                                        'data.csv' does not contain any special characters.
#> 4                                                                                   'data.meta.csv' does not contain any special characters.
#> 5                                                                           The names of the files follow the recommended naming convention.
#> 6                                                                              All of the required columns are present in the metadata file.
#> 7                                                                                         There are no invalid columns in the metadata file.
#> 8                                                                                  All of the required columns are present in the data file.
#> 9                                 There are an equal number of rows in the metadata file (3) and non-mandatory columns in the data file (3).
#> 10                                                                                               col_type is always 'Filter' or 'Indicator'.
#> 11                                                                           No observational units have been included in the metadata file.
#> 12                                                                           The col_name column is completed for every row in the metadata.
#> 13 enrolment_count does not have a specified number of decimal places in the metadata file, this should be explicitly stated where possible.
#> 14                                                                                The following invalid time_identifier was found: 'parsec'.
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
#> 14 https://dfe-analytical-services.github.io/analysts-guide/statistics-production/ud.html#list-of-allowable-time-values
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
#> 10    Precheck meta
#> 11    Precheck meta
#> 12    Precheck meta
#> 13       Check meta
#> 14    Precheck time
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
#>                               check  result
#> 1        check_filename_data_spaces    PASS
#> 2    check_filename_metadata_spaces    PASS
#> 3       check_filename_data_special    PASS
#> 4   check_filename_metadata_special    PASS
#> 5             check_filenames_match    PASS
#> 6                      col_req_meta    PASS
#> 7                  col_invalid_meta    PASS
#> 8                      col_req_data    PASS
#> 9                       col_to_rows    PASS
#> 10                    meta_col_type    PASS
#> 11                     meta_ob_unit    PASS
#> 12                    meta_col_name    PASS
#> 13                    meta_col_name    PASS
#> 14                    time_id_valid    PASS
#> 15 check_api_char_limit_column-name WARNING
#>                                                                                                                                                           message
#> 1                                                                                                                'data.csv' does not have spaces in the filename.
#> 2                                                                                                           'data.meta.csv' does not have spaces in the filename.
#> 3                                                                                                             'data.csv' does not contain any special characters.
#> 4                                                                                                        'data.meta.csv' does not contain any special characters.
#> 5                                                                                                The names of the files follow the recommended naming convention.
#> 6                                                                                                   All of the required columns are present in the metadata file.
#> 7                                                                                                              There are no invalid columns in the metadata file.
#> 8                                                                                                       All of the required columns are present in the data file.
#> 9                                                      There are an equal number of rows in the metadata file (4) and non-mandatory columns in the data file (4).
#> 10                                                                                                                    col_type is always 'Filter' or 'Indicator'.
#> 11                                                                                                No observational units have been included in the metadata file.
#> 12                                                                                                The col_name column is completed for every row in the metadata.
#> 13                                                                                                       The indicator_dp column is completed for all indicators.
#> 14                                                                                                                      The time_identifier values are all valid.
#> 15 The following filter / indicator names exceed the character limit of 50 for type 'column-name': "mahoooooooooooooooooooooooooooooooooooooooooooooooooooosive".
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
#> 15 https://dfe-analytical-services.github.io/analysts-guide/statistics-production/api-data-standards.html#character-limits-for-col_names-and-filter-items
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
#> 10    Precheck meta
#> 11    Precheck meta
#> 12    Precheck meta
#> 13       Check meta
#> 14    Precheck time
#> 15        Check API
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
