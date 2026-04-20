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
  [`screen_dfs()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_dfs.md)
  and
  [`screen_filenames()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_filenames.md)
  plus the constituent individual checks
- Functions to generate test data
- Example datasets to aid testing and demonstration
- Additional functions to aid in screening / preparing data for EES

If you’ve come here because your data is failing the screening and you
want help in figuring out why, start off with our `Common file failures`
article.

### `screen_csv()`

[`screen_csv()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_csv.md)
is the core function that reads the CSV files and then runs all checks
from
[`screen_filenames()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_filenames.md)
and
[`screen_dfs()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_dfs.md),
providing full screening for a given pair of CSV files.

This function is the key function used in both the plumber API and the R
Shiny app. It returns a structured list containing a data frame of
results, the stage the screening reached, and booleans for overall pass
and API suitability. With `verbose = TRUE` it also prints messages to
the console, and with `stop_on_error = TRUE` it throws on the first FAIL
— useful inside analyst pipelines as a hard QA gate.

### `screen_filenames()`

Runs all of the filename screening checks in one go. Exported so it can
be used in its own right to check file name pairings. Used within
[`screen_csv()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_csv.md).

### `screen_dfs()`

Runs all of the checks against the data and metadata data frames, once
read in from the CSV files. Used within
[`screen_csv()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_csv.md).

Ordering matters — later checks carry assumptions that earlier ones
passed. This prevents duplication and simplifies the logic in later
checks, at the cost of some complexity for maintainers and anyone
wanting to use individual checks in isolation. The
`assumptions_in_checks.Rmd` vignette walks through those assumptions.

Checks are grouped into stages, which are mirrored in the documentation
for the individual functions. `_pkgdown.yml` shows the stages in the
order they are run. Stages are grouped by area of the data they relate
to, and pre-checks are run first because the main checks for each area
depend on them passing.

Each individual precheck / check returns a single-row data frame of
results, with optional console output and error triggers. The standard
pattern is:

``` r
test_output(
  get_check_name(), # name of check function
  "PASS", # result of check, one of 'PASS', 'FAIL', 'WARNING'
  paste0("'", filename, "' does not contain any special characters."), # feedback message, plain text, no HTML
  "https://dfe-analytical-services.github.io/analysts-guide/", # optional URL for guidance (defaults to NA if omitted)
  verbose = FALSE, # whether to print messages to console
  stop_on_error = FALSE # whether to stop execution and throw on FAIL / warn on WARNING
)
```

## Generating test files

[`generate_test_dfs()`](https://dfe-analytical-services.github.io/eesyscreener/reference/generate_test_dfs.md)
creates matching data and metadata frames for any number of time
periods, locations, filters and indicators.

``` r
files <- eesyscreener::generate_test_dfs(
  years = 2013:2015,
  pcon_names = "Sheffield Central",
  pcon_codes = "E14000919",
  num_filters = 2,
  num_indicators = 3
)

df <- files$data
df_meta <- files$meta
```

### Going bigger

To stress-test on realistic volumes, combine
[`generate_test_dfs()`](https://dfe-analytical-services.github.io/eesyscreener/reference/generate_test_dfs.md)
with the [dfeR package](https://dfe-analytical-services.github.io/dfeR/)
to pass in vectors of Parliamentary Constituencies. Row count is
`length(years) * length(pcon_codes) * (5 ^ num_filters)`.

``` r
pcons <- dfeR::fetch_pcons(countries = "England")

beefy <- eesyscreener::generate_test_dfs(
  years = c(1980:2025),
  pcon_codes = pcons$pcon_code,
  pcon_names = pcons$pcon_name,
  num_filters = 3,
  num_indicators = 45,
  verbose = TRUE
)

# duckplyr is dramatically faster than base R for writing large CSVs
# (~20 seconds vs ~6 minutes for the frame above)
duckplyr::compute_csv(beefy$data, "beefy_data.csv")
duckplyr::compute_csv(beefy$meta, "beefy_data.meta.csv")
```

## Reading the `screen_csv()` output

The minimal example in the
[README](https://dfe-analytical-services.github.io/eesyscreener/index.html#minimal-example)
shows the output structure for a file that runs the whole pipeline. The
three scenarios below cover the shapes you are most likely to see when
something goes wrong — a file that fails a check, a file that cannot be
read at all, and a file that passes screening but is not suitable for
publishing through the API.

### File that fails a check

Drop a required metadata column to trigger a `FAIL` in the
`Precheck columns` stage. `passed` will be `FALSE` and `overall_stage`
will be the failing stage.

``` r
data_file <- tempfile(fileext = ".csv")
meta_file <- tempfile(fileext = ".meta.csv")
duckplyr::compute_csv(eesyscreener::example_data, data_file)
duckplyr::compute_csv(eesyscreener::example_meta[, -1], meta_file)

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
duckplyr::compute_csv(eesyscreener::example_api_long, data_file)
duckplyr::compute_csv(eesyscreener::example_api_long_meta, meta_file)

eesyscreener::screen_csv(data_file, meta_file, "data.csv", "data.meta.csv")
```
