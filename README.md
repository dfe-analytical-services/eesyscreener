
<!-- README.md is generated from README.Rmd. Please edit that file -->

# eesyscreener <a href="https://dfe-analytical-services.github.io/eesyscreener/"><img src="man/figures/logo.png" align="right" height="138" /></a>

<!-- badges: start -->

[![R-CMD-check](https://github.com/dfe-analytical-services/eesyscreener/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/dfe-analytical-services/eesyscreener/actions/workflows/R-CMD-check.yaml)
[![pkgdown](https://github.com/dfe-analytical-services/eesyscreener/actions/workflows/pkgdown.yaml/badge.svg)](https://github.com/dfe-analytical-services/eesyscreener/actions/workflows/pkgdown.yaml)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

Quality assurance checks used to screen files against the standards
required for official statistics files on the explore education
statistics (EES) platform.

## Installation

eesyscreener is not currently available on CRAN. For the time being you
can install the development version from GitHub.

``` r
# install.packages("devtools")
devtools::install_github("dfe-analytical-services/eesyscreener")
```

## Minimal example

This shows a quick reproducible example you can run in the console to
test with. It also shows an example of the output structure from the
core `screen_files()` function.

``` r
library(eesyscreener)

screen_files(
  "data.csv",
  "data.meta.csv",
  example_data, # replace with your data file
  example_meta # replace with your meta file
)
#> $results_table
#>                   check result
#> 1 check_filename_spaces   PASS
#> 2 check_filename_spaces   PASS
#> 3      check_empty_cols   PASS
#>                                                 message stage
#> 1      'data.csv' does not have spaces in the filename.     1
#> 2 'data.meta.csv' does not have spaces in the filename.     1
#> 3           'data.csv' does not have any blank columns.     1
#> 
#> $overall_stage
#> [1] "Passed"
#> 
#> $overall_message
#> [1] "Passed all checks"
```

## Example CSVs

Quick examples of how to make use of the data within the package to
generate CSVs for testing:

``` r
library(eesyscreener)

write.csv(example_data, "example_data.csv", row.names = FALSE)
write.csv(example_meta, "example_data.meta.csv", row.names = FALSE)

# Generate a file pairing that will fail the tests (spaces in filename)
write.csv(example_data, "example data.csv", row.names = FALSE)
write.csv(example_meta, "example data.meta.csv", row.names = FALSE)
```

Other available example files can be found on the documentation site
under examples. Use `write.csv()` as in the examples above to generate
CSVs from them.

## Developers only - generate big test files

If as a package developer you want to generate larger files for testing
with, you can use the `generate_test_files()` functions from
`tests/utils/generate_test_files.R` to create files as beefy as you’d
like! For example:

``` r
source("tests/utils/generate_utils.R")
files <- generate_test_files(2010:2015, "Sheffield Central", "E14000919", 2, 3)

# Data and metadata are returned in a list, to extract:
df <- files$data
df_meta <- files$meta
```

If you want to go really big, combine with the [dfeR
package](https://dfe-analytical-services.github.io/dfeR/), to pass in
vectors of Parliamentary Constituencies, the follow example creates an
example data and metadata pair with a dataset of just under 6 million
rows.

``` r
pcons <- dfeR::fetch_pcons(countries = "England")

beefy <- generate_test_files(
  years = c(1980:2025),
  pcon_codes = pcons$pcon_code,
  pcon_names = pcons$pcon_name,
  num_filters = 15,
  num_indicators = 45
)
```
