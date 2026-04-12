# Parliamentary constituencies lookup

A data frame of valid parliamentary constituency code and name
combinations as used in EES data files. Combines both pre-2024 and 2024
boundary constituencies.

## Usage

``` r
acceptable_pcons
```

## Format

A data.frame with columns:

- pcon_code:

  GSS parliamentary constituency code

- pcon_name:

  Parliamentary constituency name matching the code

## Source

dfe-published-data-qa screener app repo, data/pcons.csv and
data/pcon_2024_v2.csv
