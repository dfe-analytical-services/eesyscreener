# Contributing to eesyscreener

Ideas for eesyscreener should first be raised as a [GitHub issue](https://github.com/dfe-analytical-services/eesyscreener/issues) after which anyone is free to write the code and create a pull request for review. 

## Notes to tidy later

Info on EES

Scope for package

Structure of package
- stages contain functions for checking files
- screen_files pulls it all together
- required output from functions
- utils for internal functions
- priority of efficiency, we need to keep it light and fast
  - avoid heavy dependencies
  - performance profile and use the fastest available functions

- structure of tests
  - can we do something that automatically scans a list of all functions starting check_ that checks for a consistent output

- example of adding a new check
  - 
  
## Conversion notes

- Review whether functions can be used more frugally - e.g. one function with an argument for meta and data
- Review if any dependencies can be dropped (e.g. lose stringr and use grepl or other base R alternatives instead)
- Something about the test data

## Questions

1. File structure...

Break up scripts like
- stage_1
- stage_2
- stage_3
- stage_4-geography
- stage_4-time
- stage_4-filters
- stage_4-indicators
- stage_4-meta
- stage_api

Or just one script and test per function...

2. I think we can drop the stage wrapper functions?

3. Tests?
- Any thoughts on the most efficient way to do the test data without bloating the package?
