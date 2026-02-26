testthat::test_that("check_ind_obsolete_symbols: passes when there are no obsolete symbols in indicators", {
  # Should not error when there are no obsolete symbols in the indicators
  expect_no_error(
    check_ind_obsolete_symbols(example_data, example_meta)
  )
})

testthat::test_that("check_ind_obsolete_symbols: passes when there are no obsolete symbols in indicators and indicators contain acceptable symbols", {
  # Create a copy of the example data with a symbol that is not obsolete in the indicator column
  example_data_with_acceptable_symbol <- example_data
  example_data_with_acceptable_symbol$enrolment_count[1] <- "x"

  # Should not error when there are no obsolete symbols in the indicators, even if there are other symbols present
  expect_no_error(
    check_ind_obsolete_symbols(
      example_data_with_acceptable_symbol,
      example_meta
    )
  )
})

testthat::test_that("check_ind_obsolete_symbols: advisory when there is an ~ obsolete symbol in indicators", {
  # Create a copy of the example data with an obsolete symbol in the indicator column
  example_data_with_obsolete_symbol <- example_data
  example_data_with_obsolete_symbol$enrolment_count[1] <- "~"

  # Should return advisory when there are obsolete symbols in the indicators
  expect_equal(
    check_ind_obsolete_symbols(
      example_data_with_obsolete_symbol,
      example_meta
    )$result,
    "ADVISORY"
  )
})

testthat::test_that("check_ind_obsolete_symbols: advisory when there is an : obsolete symbol in indicators", {
  # Create a copy of the example data with an obsolete symbol in the indicator column
  example_data_with_obsolete_symbol <- example_data
  example_data_with_obsolete_symbol$enrolment_count[8] <- ":"

  # Should return advisory when there are obsolete symbols in the indicators
  expect_equal(
    check_ind_obsolete_symbols(
      example_data_with_obsolete_symbol,
      example_meta
    )$result,
    "ADVISORY"
  )
})
