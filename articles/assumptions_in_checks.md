# Assumptions in checks

This vignette is mostly aimed at package developers, though will be
useful for anyone who wants to use any of the individual `precheck_*()`
or `check_*()` functions in isolation.

If you are the latter, using any checks individually outside of a
`screen_*()` wrapper function, proceed with caution and read this
article first.

## What assumptions?

1.  Only the `screen_*()` functions have argument validation

At the time the package was first developed there were already 90+
checks in the screener. It would be inefficient to revalidate the
arguments in every check, for example checking that the datafile is a
data.frame 90+ times.

Therefore we only provide argument validation for the top level
`screen_*()` functions.

2.  Within all of the the `screen_*()` functions, individual checks are
    placed in a specific order, and broken up by stages.

This means the tests can fail early, giving quicker feedback if there’s
fundamental issues, and also means the later checks can be more
lightweight and ‘assume’ certain things about the data.frame that is
being tested.

For example,
[`precheck_meta_col_type()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_meta_col_type.md)
requires the `col_type` column to be present, as this is already checked
for in
[`precheck_col_req_meta()`](https://dfe-analytical-services.github.io/eesyscreener/reference/precheck_col_req_meta.md)
we minimise duplication that check by not rechecking that column is
present.

## Starting assumptions

1.  Filename checks can be carried out in isolation from other checks.
    The
    [`screen_filenames()`](https://dfe-analytical-services.github.io/eesyscreener/reference/screen_filenames.md)
    function can be ran in a single line on two simple strings where
    needed.

2.  Mandatory columns are checked before anything else about the files.
    Many of the other checks rely on assumptions that key columns exist.

3.  Metadata files are checked before data files, they are faster to
    test and can give immediate feedback, plus they are crucial for
    understanding and checking the data file, so we need to have a
    passing metadata file before we can test the data file.

## Precheck versus check

Most groups have a `precheck_*()` grouping, e.g. `precheck_time_*()` and
`check_time_*()`. If the `precheck_*()` functions are not ran first,
there is every chance that you could get unexpected errors in the
`check_*()` functions.

For example

…
