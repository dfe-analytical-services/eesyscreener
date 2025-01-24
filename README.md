
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

``` r
library(eesyscreener)

screen_files(
  "data.csv",
  "data.meta.csv",
  example_data, # replace with your data file
  example_data.meta # replace with your meta file
)
#> $results_table
#>                            check result
#> 1     check_data_filename_spaces   PASS
#> 2 check_metadata_filename_spaces   PASS
#> 3          check_data_empty_rows   PASS
#> 4      check_metadata_empty_rows   PASS
#>                                           message stage
#> 1         The data filename does not have spaces.     1
#> 2     The metadata filename does not have spaces.     1
#> 3     The data file does not have any blank rows.     1
#> 4 The metadata file does not have any blank rows.     1
#> 
#> $overall_stage
#> [1] "Passed"
#> 
#> $overall_message
#> [1] "Passed all checks"
```
