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

- `screen_files()` pulls it all together and currently is the main export, this has 3 intended uses:
  - for use in the plumber API (EES integration)
  - for use in the R Shiny app
  - for use by analysts in their own R scripts

- All individual checks copied from the screener should be named in accordance with the naming conventions in the `_pkgdown.yml` file
- All `check_*` functions must return a consistent list structure
- File structure - one script per `check_*` or `precheck_*` function (except if internal and in R/utils.R)
- `R/utils.R` contains all internal functions
- `R/data-raw.R` contains the source code for example data and hardcoded variables
- Use RDS as the main format to shrink test data (beware it automatically does some cleaning!), use CSV or make the data.frame() in code if needed
- Think about dependencies between functions - can we pass the results of any pre-requisites into other functions?
- Big priority on efficiency, we need to keep it light and fast
  - avoid heavy dependencies
  - performance profile and use the fastest available functions
  
TODO: At the end of moving checks over we should set up tests for `screen_tests()` that run over all the example test data

## Process for moving in functions from app

[Tracking spreadsheet set up in sharepoint](https://educationgovuk.sharepoint.com/:x:/r/sites/lveesfa00074/Data%20Insights%20and%20Statistics%20Division/Statistics%20Services%20Unit/Explore%20education%20statistics%20platforms/Screening%20tests%20migration%20tracking.xlsx?d=wdc9cf9ce356b47c6a1d1f11aba8bb96d&csf=1&web=1&e=PSIk6I), this contains a table of all checks, thoughts on new groupings and notes about the migration (including the progress).

Example of adding a new check available in [PR XX]()

1. Tackle one screening check at a time (unless you can create one function that covers multiple repeated checks)

2. Set up a new script and test script for the check, copy over the relevant code from https://github.com/dfe-analytical-services/dfe-published-data-qa

3. Add test data that should fail the function
  a. Make use of the `tests/utils/copy_check_data.R` script to copy over CSVs from the screener repo and save as RDS files in the tests folder
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

## Notes / questions

Gone for verbose by default (i.e. console warnings), and then we turn that off in the API / Shiny app

Radical - would we want to ditch warnings? Just have TRUE / FALSE for pass / fail?

Guidance URL? / being able to feedback to users? Not 100% on, wondering if a first version could be to ditch, simply the feedback to the user and instead and go for an accompanying vignette guide to specific checks - e.g. with instructions for running checks in isolation to investigate issues (thinking of duplicate rows?)

Long feedback messages - how do we handle more neatly / give ourselves ability to still edit those later

Feels a little odd to make all the code available as individual functions
- Issues with assumptions in the code
  - When do we check it's actually a CSV file?
  - pre-check are required for many of the main checks, feels like too much to build in to each function? Thinking we create a vignette explaining this a bit more just so it's clear to users

## Structure

- Screening function that runs everything in order (can be wrapped with batching functions later)
  - Takes in file names (data and meta) and the data.frames of the files
    
    [DO WE WANT TO STANDARDISE THE FUNCTIONS FOR READING THE FILES?]
    - Plumber: reads in CSVs prior to passing to the function
    - Shiny: reads in CSVs prior to passing to the function
    
    - Analysts: reads in CSVs within the function [DO WE NEED AN ARGUMENT FOR THEM TO HAVE THIS?]

- Where do we catch that a file is a CSV or not?

- Runs all of the checks in order
 - Stages are changed from the existing app.
   - Now checks will be grouped by area / topic instead
 - Pre-checks are run first as the main checks for each area depend on them passing
 - Do in a way that can be parrallelised if a users machine can do so

- Each check returns a consistent data frame structure
  - If a key stage is failed, the checks stop early?

For each check:
- Two options - print to console verbosely, or return a data.frame of results

- test_output function controls this
  - Fails cause errors in console
  - Can add additional verbose console messages before the main failure output if needed

Standard pattern:
```r
test_output(
  test_name, # name of check
  "PASS", # result of check, one of 'PASS', 'FAIL', 'WARNING'
  paste0("'", filename, "' does not contain any special characters."), # feedback message for user
  "https://dfe-analytical-services.github.io/analysts-guide/", # optional URL for guidance, can just not include as will default to NA
  console = verbose # control for whether to print to console or silently return data frame (TRUE/FALSE)
)
```

## Other things to add to the package

TODO: Add test coverage workflow
TODO: Add trello card workflow

## List of notes for the main screener

TODO: Move the images out of screenFiles and into the server part of the app
TODO: Move the character forcing of columns to within the screen files function
TODO: Update the test data and testing approach
