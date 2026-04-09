# Migration examples

This note includes details of functions migrated from
<https://github.com/dfe-analytical-services/dfe-published-data-qa/> to
this eesyscreener package.

Four examples are included to give an indication of how the code is
moved across and what is required from a PR. Original locations refer to
the code on the main branch of the dfe-published-data-qa project.

Any addition data variables in dfe-published-data-qa were stored in the
R/knownVariables.r file.

## Example 1

Original location: R/mainTests.r Original function name: duplicate_label
PR creating function in package with new name:
<https://github.com/dfe-analytical-services/eesyscreener/pull/7>

## Example 2

Original location: R/mainTests.r Original function name:
col_name_duplicate() PR creating function in package with new name:
<https://github.com/dfe-analytical-services/eesyscreener/pull/6>

## Example 3

Original location: R/mainTests.r Original function name:
filter_group_match() PR creating function in package with new name:
<https://github.com/dfe-analytical-services/eesyscreener/pull/12>

## Example 4

Original location: R/preCheck1.r Original function name:
geographic_level() PR creating function in package with new name:
<https://github.com/dfe-analytical-services/eesyscreener/pull/42>
