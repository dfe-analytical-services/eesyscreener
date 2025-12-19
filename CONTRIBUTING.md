# Contributing to eesyscreener

Ideas for eesyscreener should first be raised as a [GitHub
issue](https://github.com/dfe-analytical-services/eesyscreener/issues)
after which anyone is free to write the code and create a pull request
for review.

## Introduction

[Explore education statistics
(EES)](https://explore-education-statistics.service.gov.uk/) is our
bespoke statistics publishing platform, for it to work we rely on
standardising the structure of our data files.

This package contains the checks used to enforce our [open data
standards](https://dfe-analytical-services.github.io/analysts-guide/statistics-production/ud.html).

Before contributing to the package, you should read this, and the
vignettes describing the package, to understand all of the logic and
decisions made. Particularly the `assumptions_in_checks.Rmd` vignette as
that provides crucial information about interdependencies between
functions within the package.

## Package structure

The `screen_*()` functions are the key user facing exports of the
package.

[`screen_csv()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_csv.md)
is expected to be the primary function used, it takes a pair of CSV
files and screens them.

- One script per exported function (except for data objects or if
  internal and in `R/utils.R`)
- All individual checks should be named in accordance with the naming
  conventions in the `_pkgdown.yml` file
- Due to the extensive use of check / test in this package, internal
  functions handling argument validation should follow the
  `validate_arg_*()` convention
- All `check_*()` functions must return a consistent list structure
- `R/utils.R` contains all internal functions
- `data-raw/` contains the source code for example data and hardcoded
  variables
- Use RDS as the main format for permanent test data (beware it
  automatically does some cleaning!), make temp CSV files or create a
  data.frame in code if needed
- Think about dependencies between functions - explain any in the
  `assumptions_in_checks.Rmd` vignette

## Stylistic preferences

This package has a big priority on efficiency, we need to keep it fast
so the Shiny app and API endpoint are responsive even with larger files

- performance profile and use the fastest available functions
- test on large files (5 million rows and above), and prioritise large
  file performance over small file performance
- avoid duplication between functions
- don’t validate arguments in individual `precheck_*()` or `check_*()`
  functions

duckplyr seems to be the fastest approach, take the following example
code, just aimed at checking if the time_identifier values are valid

``` r
# Base R
setdiff(
  unique(as.character(data$time_identifier)),
  eesyscreener::acceptable_time_ids
)

# dplyr / duckplr (methods_overwrite / methods_restore)
data |>
  dplyr::distinct(.data$time_identifier) |>
  dplyr::anti_join(
    data.frame("time_identifier" = eesyscreener::acceptable_time_ids),
    by = "time_identifier"
  ) |>
  dplyr::pull(time_identifier)
```

Initially the base R looks simpler, less code, so likely faster…

Ran through microbenchmark the results on a ~6 million row data.frame in
milliseconds were:

- base R ~ 3,231 ms
- dplyr ~ 61.6 ms
- duckplyr ~ 5.7 ms

For the eesyscreener::example_data, a tiny file, results were different,
though as mentioned above, we should prioritise the larger files as that
is where the greatest impact is felt:

- base R ~ 62.6 microseconds
- dplyr ~ 1,865 microseconds
- duckplr ~ 4,774 microseconds

If Frederick hadn’t already told us enough times, duck is king. We can
write nice readable dplyr code, but utilise the power of the duck. Best
of both worlds.

If you have issues with linting and dplyr variables showing no visible
binding, follow the [guide to using dplyr in
packages](https://cran.r-project.org/web/packages/dplyr/vignettes/in-packages.html).

### duckplyr messages

duckplyr is particularly verbose, and will tell you when it’s falling
back to dplyr, often you may get messages like the following:

> The duckplyr package is configured to fall back to dplyr when it
> encounters an incompatibility. Fallback events can be collected and
> uploaded for analysis to guide future development. By default, data
> will be collected but no data will be uploaded. i Automatic fallback
> uploading is not controlled and therefore disabled, see
> `?duckplyr::fallback()`. v Number of reports ready for upload: 1.

These are safe to ignore, though detail out the places where duckplyr
has tried and failed to run, often if you investigate through
[`duckplyr::fallback_review()`](https://duckplyr.tidyverse.org/reference/fallback.html)
you can pinpoint where in the code you tried to get duckplyr to do
something it didn’t want.

Uploading the reports using
[`duckplyr::fallback_upload()`](https://duckplyr.tidyverse.org/reference/fallback.html)
will clear them from your machine and submit to the maintainers.

If you don’t care for looking at them more, you can set them to auto
upload (and stop shouting at you) with
`duckplyr::fallback_config(autoupload = TRUE)`.

## Process for moving in functions from app

[Tracking spreadsheet set up in
sharepoint](https://educationgovuk.sharepoint.com/:x:/r/sites/lveesfa00074/Data%20Insights%20and%20Statistics%20Division/Statistics%20Services%20Unit/Explore%20education%20statistics%20platforms/Screening%20tests%20migration%20tracking.xlsx?d=wdc9cf9ce356b47c6a1d1f11aba8bb96d&csf=1&web=1&e=PSIk6I),
this contains a table of all checks, thoughts on new groupings and notes
about the migration (including the progress).

Example of adding a new check available in [PR
XX](https://dfe-analytical-services.github.io/eesyscreener/)

Other commits showing checks being added:

- [`precheck_col_req_data()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_col_req_data.md),
  also showing adding the req_data_cols data object -
  <https://github.com/dfe-analytical-services/eesyscreener/commit/98a84e3e7733e99c0fefc90ddb7d876f793ae780>
- [`precheck_meta_col_name()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_meta_col_name.md),
  simple one that simplifies the original function -
  <https://github.com/dfe-analytical-services/eesyscreener/commit/7e1908f76d5a14d29363fbba45452da8dba60775>

1.  Tackle one screening check at a time (unless you can create utility
    functions that cover multiple repeated checks)

2.  Set up a new script and test script for the check, copy over the
    relevant code from
    <https://github.com/dfe-analytical-services/dfe-published-data-qa>

3.  Add unit tests for the the function

4.  Adapt the function so that the input arguments and outputs match
    existing `check_*` functions

5.  Integrate the new `check_*` into the appropriate
    [`screen_dfs()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_dfs.md)

6.  Document the code inheriting documentation from existing functions
    where possible

There will be a lot of functions in this package, so we want to minimise
the amount of duplicated code.

Use @inheritParams function_name to copy in param definitions from
another

Use `#' @inherit check_filename_spaces return` to copy the return
documentation for functions

7.  Once setup, review and improve the code

Make sure the tests are passing and you’ve commited before this point to
ensure you don’t inadvertently break anything!

1.  Have a look through examples of simplifying the code to see if
    anything could apply to the function you’re working on, e.g. 

Simplifying a check for missing values, where previously it used a
pre_check object and sapply -
<https://github.com/dfe-analytical-services/eesyscreener/commit/290679711d82529a7d0c54b63cac61ae92a350d8>

2.  Create and use helper functions (if you haven’t already), place any
    helper functions in `R/utils.R`, mark as @keywords internal

3.  Avoid bringing in too many new dependencies, try rewriting in base R
    where possible

4.  Use `microbenchmark` to experiment to find the most efficient
    approach (speed is king here) e.g.

``` r
data <- eesyscreener::example_data

microbenchmark::microbenchmark(
  nrow(data) - nrow(janitor::remove_empty(data, which = "rows", quiet = TRUE)),
  sum(apply(data, 1, function(row) all(is.na(row) | row == ""))),
  sum(rowSums(is.na(data) | data == "") == ncol(data)),
  times = 100000
)
```

In this example, the first line requires the janitor package. It is
slightly faster with a mean of 115ms, the second line mean was 184ms,
and the third line mean was 121ms, as there’s a minimal amount between 1
and 3, usually we’d go for option 3 to avoid needing to call in the
janitor package as a dependency, keeping this package more lightweight.

However, when testing with a bigger file (~6million rows), the 2nd and
3rd options were so slow to run that microbenchmark was taking too long
to produce a result. Clearly using janitor in option 1 has a massive
impact when there’s more rows, so the decision was made to import the
janitor package as the speed benefit was worth the extra dependency.

You can use the `tests/utils/benchmarking.R` script as a starting point,
it includes code to generate big tables and run benchmarking. Sometimes
the fastest on small files will not be the fastest on bigger ones.
Prioritise the bigger files as that’s where the biggest impact will be
felt.

In particular look at using `dplyr` verbs that can use `duckplyr` for
speedier alternatives as we enable duckplyr within the
[`screen_dfs()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_dfs.md).
`data.table` probably isn’t necessary and would cause us to need to
switch between a data.frame and a data.table costing time.

TODO: At the end of the migration, we should then plan how to migrate
the test data over, so that all of the existing edge cases tested in the
R Shiny app can be covered here.

1.  Make use of the `tests/utils/copy_check_data.R` script to copy over
    CSVs from the screener repo and save as RDS files in the tests
    folder

2.  There should be a collection of unit tests and at least one example
    data file with an expected failure for every function

## Identifying resource heavy processes

We aim to do everything optimally with lazy loading of the data, however
some functions may inadvertantly actualise the whole data frame. To
identify these kind of instances, it can be useful to use the
`prudence = "stingy"` flag when loading the data. This will cause the
code to come to a halt if any significant resources are required by a
process handling the lazy table.

To use `"stingy"` in this way, follow these steps:

- Run `screen_dfs(<data>, <meta>, prudence = "stingy")`
- If the lazy table is materialised, an error will be thrown, if it is
  then identify the guilty line by running:
  - [`rlang::last_trace()`](https://rlang.r-lib.org/reference/last_error.html)
    \## Other things to add to the package

TODO: Add trello card workflow

## List of notes for the main screener when migrating over

TODO: Move the images out of screenFiles and into the server part of the
app

TODO: Move the character forcing of columns to within the screen files
function

TODO: Update the test data and testing approach
