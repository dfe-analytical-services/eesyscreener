# Check for invalid values in indicators

Check all values in indicator columns for blanks or obsolete no data
symbols.

## Usage

``` r
check_ind_invalid_entry(data, meta, verbose = FALSE, stop_on_error = FALSE)
```

## Arguments

- data:

  A data frame of the data file

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

## Examples

``` r
check_ind_invalid_entry(example_data, example_meta)
#>               check result
#> 1 ind_invalid_entry   PASS
#>                                                              message
#> 1 There are no blank values or GSS legacy symbols in any indicators.
#>   guidance_url
#> 1           NA
check_ind_invalid_entry(example_data, example_meta, verbose = TRUE)
#> ✔ There are no blank values or GSS legacy symbols in any indicators.
#>               check result
#> 1 ind_invalid_entry   PASS
#>                                                              message
#> 1 There are no blank values or GSS legacy symbols in any indicators.
#>   guidance_url
#> 1           NA
```
