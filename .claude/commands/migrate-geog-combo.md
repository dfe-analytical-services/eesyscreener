Using the approach taken for check_geog_region_combos and acceptable_regions, migrate the `$ARGUMENTS` function from the `dfe-published-data-qa` repo (at `c:/code_projects/dfe-published-data-qa/`) into this `eesyscreener` package.

1. Get the desired new name for the new function from migration-progress.csv
2. Find the function in the R/mainTests.R script of the dfe-published-data-qa repo (also in c:/code_projects).
3. Review the R/knownVariables.R script to find the source data filepath.
4. Plan the implementation of this migration, adding a data object for the source data into `data-raw/acceptable_geog_combos.R`, code into `check_geog_combos.R`, wire into `screen_dfs.R` and add associated documentation and tests.
5. Ask clarifying questions if needed.
6. Implement this and commit.
    a. Add the R code into check_geog_combos.R
    b. Add the tests into test-check_geog_*_combos.R
    c. Add code to the data-raw/acceptable_geog_combos.R to create the data object
    d. Source that script to generate it - `source("data-raw/acceptable_geog_combos.R")
    e. Document the data object in reference_values.R
    f. Add a script with unit tests for the data.
    g. air format ., then `devtools::load_all(); lintr::lint_package()` to format the code
    h. `source("data-raw/example_output.R")` to regenerate the example output
