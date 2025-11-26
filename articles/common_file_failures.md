# Common file failures

A guide to common issues with files that trip up analysts, providing
further information and supporting code to aid in debugging problems
within data files.

If your issue is not covered on here, please contact
<explore.statistics@education.gov.uk> for assistance.

## Duplicate rows

If you have duplicate rows in your file, this check will have picked it
up, so check for that first. If you still think you have no duplicate
rows, then read on.

The accuracy of this check has been questioned by many, many analysts
over the years. Without fail, it has prevailed, exposing case after case
of duplication. So, leave your indignation at the door, and accept this
help to find your duplicate rows.

The `check_data_duplicate_rows()` function checks for duplicate rows
across the time, geography and filter columns. This is to make sure that
there is only one possible value for any combination of categories per
indicator.

An example table that does not have duplicate rows overall, but fails
the `check_data_duplicate_rows()` function:

    #>   time_period time_identifier geographic_level country_code country_name
    #> 1        2020   Calendar year         National    E92000001      England
    #> 2        2020   Calendar year         National    E92000001      England
    #>   school_count
    #> 1           10
    #> 2           20

This kind of file causes a big issue for users, as they don’t know which
value is the real value, leading to confusion and risk of
misrepresentation.

First thing you should check in this case is that your metadata file is
properly set up, if you’ve not assigned filters and indicators properly
this can easily lead to the site thinking you have duplicate rows.

Assuming all else looks okay, the final route is to find the duplicates
like this in your file and inspect them to spot what the issue might be,
use the … argument in the … function, like below.

``` r
```

## Pound symbols

…
