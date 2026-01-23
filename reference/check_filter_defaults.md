# Check filenames line up between data and metadata files

Making sure the data and metadata file follow the pattern of:

- datafile.csv (data file)

- datafile.meta.csv (metadata file)

## Usage

``` r
check_filter_defaults(data, meta, verbose = FALSE, stop_on_error = FALSE)
```

## Arguments

- data:

  A character string of the data filename to check

- meta:

  A character string of the metadata filename to check

- verbose:

  logical, if TRUE prints feedback messages to console for every test,
  if FALSE run silently

- stop_on_error:

  logical, if TRUE will stop with an error if the result is "FAIL", and
  will throw genuine warning if result is "WARNING"

## Value

a single row data frame

## Examples

``` r
check_filter_defaults(example_data, example_meta)
#>                   check  result
#> 1 check_filter_defaults WARNING
#>                                                                                                                                                   message
#> 1 A 'Total' entry or default filter item should be specified for the following filters and / or filter_groups where applicable: 'sex', 'education_phase'.
#>                                                                                                            guidance_url
#> 1 https://dfe-analytical-services.github.io/analysts-guide/statistics-production/ud.html#aggregates-and-default-filters
```
