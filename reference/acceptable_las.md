# Local authorities lookup

A data frame of valid local authority code and name combinations as used
in EES data files.

## Usage

``` r
acceptable_las
```

## Format

A data.frame with columns:

- old_la_code:

  Legacy three-digit LA code

- new_la_code:

  Current GSS LA code

- la_name:

  Local authority name matching the codes

## Source

dfe-published-data-qa screener app repo, data/las.csv
