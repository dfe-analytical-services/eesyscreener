# Contributing to eesyscreener

Ideas for eesyscreener should first be raised as a [GitHub issue](https://github.com/dfe-analytical-services/eesyscreener/issues) after which anyone is free to write the code and create a pull request for review. 

## Introduction

[Explore education statistics (EES)](https://explore-education-statistics.service.gov.uk/) is our bespoke statistics publishing platform, for it to work we rely on standardising the structure of our data files.

This package contains the checks used to enforce our [open data standards](https://dfe-analytical-services.github.io/analysts-guide/statistics-production/ud.html).

We expect the package to serve the following purposes:
- Provide..
  - file validation on EES, and the documentation for that validation
  - the checks used in the [R Shiny screener app](https://github.com/dfe-analytical-services/dfe-published-data-qa) used by analysts to check files
- Allow analysts...
  - to check their files in R using `screen_files()`
  - to reuse some of the individual `check_*` functions in their QA pipelines

## Package structure

- `screen_files()` pulls it all together and currently is the main export
- All individual checks copied from the screener should be named `check_*`
- All `check_*` functions must return a consistent list structure
- File structure - one script per `check_*` function (except R/utils.R)
- `R/utils.R` contains all internal functions
- `R/data-raw.R` contains the source code for example data and hardcoded variables
- Use RDS as the main format to shrink test data (beware it automatically does some cleaning!), use CSV or make the data.frame() in code if needed
- Think about dependencies between functions - can we pass the results of any pre-requisites into other functions?
- Big priority on efficiency, we need to keep it light and fast
  - avoid heavy dependencies
  - performance profile and use the fastest available functions
  
TODO: At the end of moving checks over we should set up tests for `screen_tests()` that run over all the example test data

## Process for moving in functions from app

Example of adding a new check available in [PR XX]()

1. Tackle one screening check at a time (unless you can create one function that covers multiple repeated checks)

2. Set up a new script and test script for the check, copy over the relevant code from https://github.com/dfe-analytical-services/dfe-published-data-qa

3. Add test data that should fail the function
  a. Make use of the `tests/utils/generate_check_data.R` script to copy over CSVs from the screener repo and save as RDS files in the tests folder
  b. There should be a collection of unit tests and at least one example data file with an expected failure for every function

4. Adapt the function so that the input arguments and outputs match existing `check_*` functions

5. Integrate the new `check_*` into the `screen_files()` function

6. Document the code inheriting documentation from existing functions where possible

There will be a lot of functions in this package, so we want to minimise the amount of duplicated code.

Use @inheritParams function_name to copy in param definitions from another

Functions to check for standard param definitions:
- `check_empty_cols`
- `check_filename_spaces`

Use `#' @inherit check_empty_cols return`  to copy the return documentation for functions

7. Once setup, review and improve the code 

Make sure the tests are passing and you've commited before this point to ensure you don't inadvertently break anything!

a. Create and use helper functions (if you haven't already), place any helper functions in `R/utils.R`, mark as @keywords internal
b. Avoid bringing in too many new dependencies, try rewriting in base R where possible
c. Use `microbenchmark` to experiment to find the most efficient approach (speed is king here) e.g.
``` r
data <- eesyscreener::example_data

microbenchmark::microbenchmark(
  nrow(data) - nrow(janitor::remove_empty(data, which = "rows", quiet = TRUE)),
  sum(apply(data, 1, function(row) all(is.na(row) | row == ""))),
  sum(rowSums(is.na(data) | data == "") == ncol(data)),
  times = 100000
)

## NOTE: This particular check was removed as other checks will cover it
## - check_time_periods
## - check_meta_col_type
```

In this example, the first line requires the janitor package. It is slightly faster with a mean of 115ms, the second line mean was 184ms, and the third line mean was 121ms, as there's a minimal amount between 1 and 3, usually we'd go for option 3 to avoid needing to call in the janitor package as a dependency, keeping this package more lightweight.

However, when testing with a bigger file (~6million rows), the 2nd and 3rd options were so slow to run that microbenchmark was taking too long to produce a result. Clearly using janitor in option 1 has a massive impact when there's more rows, so the decision was made to import the janitor package as the speed benefit was worth the extra dependency.

You can use the `tests/utils/benchmarking.R` script as a starting point, it includes code to generate big tables and run benchmarking. Sometimes the fastest on small files will not be the fastest on bigger ones. Prioritise the bigger files as that's where the biggest impact will be felt.

If it's a particularly big function running over a whole data file, also consider using `future.apply` or other parallel processing approaches if they swap in easily.

## List of notes for the main screener

TODO: Move the images out of screenFiles and into the server part of the app
TODO: Move the character forcing of columns to within the screen files function
TODO: Update the test data and testing approach
