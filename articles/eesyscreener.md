# eesyscreener

## An overview

[Explore education statistics
(EES)](https://explore-education-statistics.service.gov.uk/) is our
bespoke statistics publishing platform, for it to work we rely on
standardising the structure of our data files.

This package contains the checks used to enforce our [open data
standards](https://dfe-analytical-services.github.io/analysts-guide/statistics-production/ud.html).

The package contains:

- A core
  [`screen_csv()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_csv.md)
  function, built from
  [`screen_dfs()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_dfs.md),
  and
  [`screen_filenames()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_filenames.md)
  and the constituent individual checks, as well as a related wrapper
  function `screen_zip()`
- Functions to generate test data
- Example datasets to aid testing and demonstration
- Additional functions to aid in screening / preparing data for EES

If you’ve come here because your data is failing the screening and you
want help in figuring out why, start off with our `Common file failures`
article.

### `screen_csv()`

[`screen_csv()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_csv.md)
core function that reads the CSV files, and then runs all checks from
[`screen_filenames()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_filenames.md)
and
[`screen_dfs()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_dfs.md),
providing full screening for a given pair of CSV files.

This function is the key function that will be used in both the plumber
API and the R Shiny app.

- Returns one of the following outputs:
  - Structured list, including data.frame of results / feedback
  - Console messages
  - Errors only - intended to be used within pipelines as a QA function.
    If all passes nothing is returned (maybe an invisible TRUE?)

### `screen_zip()`

Future expansion to screen ZIP files, batching multiple file pairs as a
wrapper around
[`screen_csv()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_csv.md).

Probably not required in the plumber API, but will be helpful for the R
Shiny app and users more generally for batching of files.

`check_zip()` does the validation that the ZIP folder structure is
appropriate prior to batching the file pairs through
[`screen_csv()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_csv.md).

### `screen_filenames()`

Runs all of the filename screening checks in one go. Exported so it can
be used in it’s own right to check file name pairings. Used within
[`screen_csv()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_csv.md).

### `screen_dfs()`

Runs all of the checks against the data and metadata data.frames, once
read in from the CSV files. Used within
[`screen_csv()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_csv.md).

The ordering is important as later tests carry assumptions that earlier
tests have passed. This is to prevent duplication / unnecessary
processing of data, as well as simplifying the logic in the later tests.
This does introduce some overall complexity, particularly for package
maintainers and any users wanting to use individual tests, and therefore
there is a vignette that walks through this ordering in greater detail -
….

There are a number of stages, which are mirrored in the documentation
for the individual functions, the `_pkgdown.yml` file shows this, in the
order the tests are ran, including the naming conventions.

- Stages are grouped by area of the data they relate to
- Pre-checks are run first as the main checks for each area depend on
  them passing
- TODO: We should do in a way that can be parallelised, so users can
  speed up the screening for larger files if their machine allows
  (particularly helpful for the API and Shiny app)

Each individual precheck / check: - Returns a single row data.frame of
results, with optional console output and error triggers

Standard pattern:

``` r
test_output(
  "test_name", # name of check
  "PASS", # result of check, one of 'PASS', 'FAIL', 'WARNING'
  paste0("'", filename, "' does not contain any special characters."), # feedback message for user, avoid HTML, keep to a simple string
  "https://dfe-analytical-services.github.io/analysts-guide/", # optional URL for guidance, can just not include as will default to NA
  verbose = FALSE # whether to print messages to console
  stop_on_error = FALSE # whether to stop execution and throw error if FAIL, and throw warning if WARNING
)
```
