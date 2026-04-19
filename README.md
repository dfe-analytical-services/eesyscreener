
<!-- README.md is generated from README.Rmd. Please edit that file -->

# eesyscreener <a href="https://dfe-analytical-services.github.io/eesyscreener/"><img src="man/figures/logo.png" align="right" height="136" alt="eesyscreener website" /></a>

<!-- badges: start -->

[![R-CMD-check](https://github.com/dfe-analytical-services/eesyscreener/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/dfe-analytical-services/eesyscreener/actions/workflows/R-CMD-check.yaml)
[![pkgdown](https://github.com/dfe-analytical-services/eesyscreener/actions/workflows/pkgdown.yaml/badge.svg)](https://github.com/dfe-analytical-services/eesyscreener/actions/workflows/pkgdown.yaml)
[![Codecov test
coverage](https://codecov.io/gh/dfe-analytical-services/eesyscreener/graph/badge.svg)](https://app.codecov.io/gh/dfe-analytical-services/eesyscreener)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![Project Status: WIP – Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
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

- A core `screen_csv()` function that will screen a pair of data and
  meta CSV files. This is built from `screen_dfs()`, and
  `screen_filenames()` and the constituent individual `precheck_*()` and
  `check_*()` functions.
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

## Generating files that trigger different outcomes

The minimal example above shows the output structure for a file that
runs the whole pipeline. Below are code excerpts for creating three
other common scenarios — a file that fails a check, a file that cannot
be read at all, and a file that passes screening but is not suitable for
publishing through the API.

### File that fails a check

Drop a required metadata column to trigger a `FAIL` in the
`Precheck columns` stage. `passed` will be `FALSE` and `overall_stage`
will be the failing stage.

``` r
data_file <- tempfile(fileext = ".csv")
meta_file <- tempfile(fileext = ".meta.csv")
write.csv(eesyscreener::example_data, data_file, row.names = FALSE)
write.csv(eesyscreener::example_meta[, -1], meta_file, row.names = FALSE)

eesyscreener::screen_csv(data_file, meta_file, "data.csv", "data.meta.csv")
```

### File that cannot be read

If either path does not exist (or the file is not a readable CSV),
screening stops in the `File read` stage without throwing an error.
`passed` will be `FALSE` and `overall_stage` will be `"File read"`.

``` r
eesyscreener::screen_csv(
  "does_not_exist.csv",
  "does_not_exist.meta.csv"
)
```

### File that passes but is not API suitable

The API checks only ever emit warnings — they do not stop screening —
but any warning in the API stage prevents the data from being published
through the API. The returned `api_suitable` boolean flags this.

``` r
data_file <- tempfile(fileext = ".csv")
meta_file <- tempfile(fileext = ".meta.csv")
write.csv(eesyscreener::example_api_long, data_file, row.names = FALSE)
write.csv(eesyscreener::example_api_long_meta, meta_file, row.names = FALSE)

eesyscreener::screen_csv(data_file, meta_file, "data.csv", "data.meta.csv")
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
