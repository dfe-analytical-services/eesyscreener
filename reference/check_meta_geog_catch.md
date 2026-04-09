# Check for geography columns mislabelled as filters

Catch if any geography columns are being included as filters in the
metadata file. This checks both filter `col_name` values and
`filter_grouping_column` values against a regex pattern that matches
common geography-related column names (e.g., names containing "la",
"region", "urn", "ukprn", etc.).

## Usage

``` r
check_meta_geog_catch(meta, verbose = FALSE, stop_on_error = FALSE)
```

## Arguments

- meta:

  A data frame of the metadata file

- verbose:

  logical, if TRUE prints feedback messages to console for every test,
  if FALSE run silently

- stop_on_error:

  logical, if TRUE will stop with an error if the result is "FAIL", and
  will throw genuine warning if result is "WARNING"

## Value

a single row data frame

## Details

If the only filter is `school_name` or `provider_name`, those are
excluded from the check as they are acceptable as filters in that
context.

## See also

Other check_meta:
[`check_meta_col_name_duplicate()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_col_name_duplicate.md),
[`check_meta_duplicate_label()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_duplicate_label.md),
[`check_meta_filter_group()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_filter_group.md),
[`check_meta_filter_group_duplicate()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_filter_group_duplicate.md),
[`check_meta_filter_group_is_filter()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_filter_group_is_filter.md),
[`check_meta_filter_group_match()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_filter_group_match.md),
[`check_meta_filter_group_stripped()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_filter_group_stripped.md),
[`check_meta_filter_hint()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_filter_hint.md),
[`check_meta_ind_dp_set()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_ind_dp_set.md),
[`check_meta_ind_dp_values()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_ind_dp_values.md),
[`check_meta_ind_unit()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_ind_unit.md),
[`check_meta_ind_unit_validation()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_ind_unit_validation.md),
[`check_meta_indicator_dp()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_indicator_dp.md),
[`check_meta_indicator_grouping()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_indicator_grouping.md),
[`check_meta_label()`](https://dfe-analytical-services.github.io/eesyscreener/reference/check_meta_label.md)

## Examples

``` r
check_meta_geog_catch(example_meta)
#>             check result                                                message
#> 1 meta_geog_catch   PASS No filters appear to be mislabelled geography columns.
#>   guidance_url
#> 1           NA
check_meta_geog_catch(example_meta, verbose = TRUE)
#> ✔ No filters appear to be mislabelled geography columns.
#>             check result                                                message
#> 1 meta_geog_catch   PASS No filters appear to be mislabelled geography columns.
#>   guidance_url
#> 1           NA
```
