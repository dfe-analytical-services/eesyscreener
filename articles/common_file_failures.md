# Common file failures

A guide to common issues with files that trip up analysts, providing
further information and supporting code to aid in debugging problems
within data files.

If your issue is not covered here, please contact
<explore.statistics@education.gov.uk> for assistance.

## Duplicate rows

If you have duplicate rows in your file,
[`check_general_dupes()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_general_dupes.md)
will have picked them up. If you still think you have no duplicates,
read on.

The accuracy of this check has been questioned by many, many analysts
over the years. Without fail, it has prevailed, exposing case after case
of duplication. So, leave your indignation at the door, and accept this
help to find your duplicate rows.

The check looks for duplicates across the combination of **observational
unit** columns (time, geography) and **filter** columns, as defined in
your metadata file. That means two rows can look different in the
indicator columns (e.g. different `school_count` values) and still be
flagged — the screener has no way to know which indicator value is the
“real” one for that combination of categories.

An example table that has no fully identical rows but still fails the
check:

    #>   time_period time_identifier geographic_level country_code country_name
    #> 1        2020   Calendar year         National    E92000001      England
    #> 2        2020   Calendar year         National    E92000001      England
    #>   school_count
    #> 1           10
    #> 2           20

### Step 1 — check your metadata file is set up correctly

If filters and indicators aren’t assigned properly in the metadata, the
screener can treat columns it expected to be filters as indicators (or
vice versa), and you end up with apparent duplicates across a
narrower-than-intended set of columns. Check the `col_type` values in
your metadata first.

### Step 2 — pull out the duplicated rows

[`check_general_dupes()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_general_dupes.md)
has a `return_dupes` argument. Setting it to `TRUE` returns a data frame
of just the rows that are part of duplicated combinations, so you can
eyeball them and spot the issue.

``` r
library(eesyscreener)

# Replace with your own data / meta — loading from CSV with read.csv() is fine
dupes <- check_general_dupes(
  data = my_data,
  meta = my_meta,
  return_dupes = TRUE
)

# Inspect the rows that are part of duplicated combinations
head(dupes)
```

The returned data frame includes all columns from your original data
file, sorted by the observational unit and filter columns so that
duplicated combinations sit next to each other. Common causes that
become obvious once you look at the rows:

- A filter column in the data file that isn’t listed in the metadata (so
  it doesn’t contribute to the uniqueness check)
- Trailing whitespace or case differences you’d missed
  (e.g. `"North East"` vs `"North East "`)
- A single indicator accidentally split across two rows when reshaping
  from wide to long

Note that School, Provider, Institution, and Planning area rows are
excluded from the check by default, because the data standard does not
require them to be unique across the observational unit and filter
columns alone. The exception is files that contain only School or
Provider rows — in that case only Institution and Planning area rows are
excluded. See
[`?check_general_dupes`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_general_dupes.md)
for the full rules.
