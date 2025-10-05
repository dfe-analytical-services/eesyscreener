
<!-- README.md is generated from README.Rmd. Please edit that file -->

# eesyscreener \[IN DEVELOPMENT\] <a href="https://dfe-analytical-services.github.io/eesyscreener/"><img src="" align="right" height="138" /></a>

<!-- badges: start -->

[![R-CMD-check](https://github.com/dfe-analytical-services/eesyscreener/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/dfe-analytical-services/eesyscreener/actions/workflows/R-CMD-check.yaml)
[![lintr](https://github.com/dfe-analytical-services/eesyscreener/actions/workflows/lint.yaml/badge.svg?branch=main)](https://github.com/dfe-analytical-services/eesyscreener/actions/workflows/lint.yaml)
[![pkgdown](https://github.com/dfe-analytical-services/eesyscreener/actions/workflows/pkgdown.yaml/badge.svg)](https://github.com/dfe-analytical-services/eesyscreener/actions/workflows/pkgdown.yaml)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![Codecov test
coverage](https://codecov.io/gh/dfe-analytical-services/eesyscreener/graph/badge.svg)](https://app.codecov.io/gh/dfe-analytical-services/eesyscreener)
<!-- badges: end -->

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
library(eesyscreener)

# Create example temporary CSV files
data_file <- tempfile(fileext = ".csv")
meta_file <- tempfile(fileext = ".meta.csv")

data.table::fwrite(example_data, data_file)
data.table::fwrite(example_meta, meta_file)

result <- screen_csv(
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
#> 6                   meta_col_type   PASS
#>                                                            message guidance_url
#> 1                 'data.csv' does not have spaces in the filename.           NA
#> 2            'data.meta.csv' does not have spaces in the filename.           NA
#> 3              'data.csv' does not contain any special characters.           NA
#> 4         'data.meta.csv' does not contain any special characters.           NA
#> 5 The names of the files follow the recommended naming convention.           NA
#> 6                      col_type is always 'Filter' or 'Indicator'.           NA
#>           stage
#> 1      filename
#> 2      filename
#> 3      filename
#> 4      filename
#> 5      filename
#> 6 Precheck meta

result$overall_stage
#> [1] "Passed"

result$overall_message
#> [1] "Passed all checks"

# Clean up temporary CSV files
file.remove(data_file)
#> [1] TRUE
file.remove(meta_file)
#> [1] TRUE
```

## Example CSVs

Quick examples of how to make use of the data within the package to
generate CSVs for testing:

``` r
library(eesyscreener)

write.csv(example_data, "example_data.csv", row.names = FALSE)
write.csv(example_meta, "example_data.meta.csv", row.names = FALSE)

# Generate a file pairing that will fail the tests by dropping a key column
write.csv(example_data, "example_data.csv", row.names = FALSE)
write.csv(example_meta[ , -1], "example_data.meta.csv", row.names = FALSE)
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

If you want to go really big, combine with the [dfeR
package](https://dfe-analytical-services.github.io/dfeR/), to pass in
vectors of Parliamentary Constituencies, and then
[data.table](https://rdatatable.gitlab.io/data.table/) for much faster
CSV creation.

The following example creates an example data and metadata pair with a
data set of just over 6 million rows. Formula to calculate rows is:

- length(years) \* length(pcon_codes) \* (5 ^ num_filters)

``` r
# Load this eesyscreener package
devtools::load_all()

# Additional dependencies
library("dfeR")
library("data.table")

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

# Then to create CSVs, use data.table as it's much faster
data.table::fwrite(beefy$data, "beefy_data.csv")
data.table::fwrite(beefy$meta, "beefy_data.meta.csv")
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
