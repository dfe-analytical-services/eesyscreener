Using MIGRATION_CONTEXT_PACK.md and .github/CONTRIBUTING.md as your primary guide, migrate the `$ARGUMENTS` function from the `dfe-published-data-qa` repo (at `c:/code_projects/dfe-published-data-qa`) into this `eesyscreener` package.

The legacy function will be somewhere in `R/mainTests.r`, `R/preCheck1.r`, `R/preCheck2.r`, or `R/knownVariables.r` in that repo — search for it there.

Use the migration-progress.csv file to understand what the new name of the function should be and what family it should belong to. If the family doesn't yet exist, follow existing patterns to create it. If unsure, ask clarification questions to make sure.

Follow all steps in MIGRATION_CONTEXT_PACK.md. At a high level:

1. Read and understand the original function and its context in the legacy repo
2. Read `R/utils.R` in full to understand available helpers before writing any logic
3. Determine the correct new name following the `check_<area>_<what>()` or `precheck_<area>_<what>()` naming convention
4. Create `R/<new_name>.R` with the migrated function and full roxygen2 documentation
5. Create `tests/testthat/test-<new_name>.R` with passing and failing test cases, using package example datasets as the base
6. Add the function call to the appropriate stage in `R/screen_dfs.R`
7. Update `_pkgdown.yml` to include the new function under the correct grouping
8. Run `devtools::document()`, then `devtools::test()` — fix any issues before proceeding
9. Simplify and improve the function following the guidelines and patterns in this project
10. Run `air format .` directly in the terminal (not an R command) to format the code
11. Rerun `devtools::document()`, `devtools::load_all(); lintr::lint_package()` then `devtools::test()` — fix any issues before proceeding
12. Once everything passes, run `air format .` again in the terminal, then create a branch, commit the changes, and open a PR for review
13. If any GitHub Action fails on the PR, review the logs then fix, commit and push

Do not skip validation. The PR should only be opened once all tests and checks pass cleanly.
