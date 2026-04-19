
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

eesyscreener is the single source of truth for the checks that enforce
data standards on the [explore education statistics (EES)
platform](https://explore-education-statistics.service.gov.uk/). The
same logic powers the [data screener Shiny
app](https://github.com/dfe-analytical-services/dfe-published-data-qa),
the [plumber screening
API](https://github.com/dfe-analytical-services/ees-screener-api), and
any analyst pipeline that wants to QA files before upload.

The package contains:

- A core `screen_csv()` function that screens a pair of data and meta
  CSV files, built from `screen_dfs()`, `screen_filenames()`, and the
  constituent `precheck_*()` / `check_*()` functions
- Data objects containing required, optional, and acceptable values for
  EES
- Functions to generate test data and example datasets

These checks have steadily evolved over the years, from initial R code
replacing manual checking of CSV files in Excel, to a [screening report
generator using
rmarkdown](https://github.com/dfe-analytical-services/ees-data-screener),
to the [R Shiny
app](https://github.com/dfe-analytical-services/dfe-published-data-qa),
right through to this R package, separating out and documenting the
logic.

This logic is invaluable in protecting the EES platform against
malformatted data that could cause unexpected behaviour, bugs, or even
outages. By having it in R, we allow the analysts supporting the
platform to contribute and maintain the checks allowing us to use it as
a harmonising tool, to enforce consistent standards across our open
data.

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

## Documentation

- [Function
  reference](https://dfe-analytical-services.github.io/eesyscreener/reference/index.html)
  — every exported check, grouped by stage
- [Getting started
  vignette](https://dfe-analytical-services.github.io/eesyscreener/articles/eesyscreener.html)
  — `screen_csv()` internals and how to generate large test files with
  `generate_test_dfs()`
- [Common file
  failures](https://dfe-analytical-services.github.io/eesyscreener/articles/common_file_failures.html)
  — recipes for files that fail, cannot be read, or pass screening but
  are not API-suitable
- [Contributing
  guidelines](https://dfe-analytical-services.github.io/eesyscreener/CONTRIBUTING.html)
  — dev setup and how to add a new check

## Contributing

Ideas for eesyscreener should first be raised as a [GitHub
issue](https://github.com/dfe-analytical-services/eesyscreener/issues/new/choose)
after which anyone is free to write the code and create a pull request
for review.

For more details on contributing to eesyscreener, see our [contributing
guidelines](https://dfe-analytical-services.github.io/eesyscreener/CONTRIBUTING.html).

Any questions regarding the package or wider service should be directed
to <explore.statistics@education.gov.uk>.
