# Harmonised column names lookup

A data frame mapping search strings (regex fragments) to the
corresponding standard harmonised column names. Used to detect column
names that appear to relate to a harmonised variable but do not use the
standard name.

## Usage

``` r
harmonised_col_names
```

## Format

A data.frame with columns:

- col_name_search_string:

  Regex fragment to match against column names

- col_name_harmonised:

  The correct harmonised column name

## Source

dfe-published-data-qa screener app repo, data/harmonised_col_names.csv
