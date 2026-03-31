testthat::test_that("check_ind_invalid_entry: passes when there are invalid entries in indicators", {
  # Should not error when there are invalid entries in the indicators
  expect_no_error(
    check_ind_invalid_entry(example_data, example_meta)
  )
})

testthat::test_that("check_ind_invalid_entry: fails when there are blanks in indicators", {
  # Create a copy of the example data with a blank value in the indicator column
  example_data_with_blank <- example_data
  example_data_with_blank$enrolment_count[1] <- ""

  # Should error when there are blanks in the indicators
  expect_equal(
    check_ind_invalid_entry(example_data_with_blank, example_meta)$result,
    "FAIL"
  )
})

testthat::test_that("check_ind_invalid_entry: fails when there are blanks in indicators not in the first row", {
  # Create a copy of the example data with a blank value in the indicator column
  example_data_with_blank <- example_data
  example_data_with_blank$enrolment_count[7] <- ""
  example_data_with_blank$enrolment_count[8] <- ""

  # Should error when there are blanks in the indicators
  expect_equal(
    check_ind_invalid_entry(example_data_with_blank, example_meta)$result,
    "FAIL"
  )
})

testthat::test_that("check_ind_invalid_entry: passes when there are no obsolete symbols in indicators and indicators contain acceptable symbols", {
  # Create a copy of the example data with a symbol that is not obsolete in the indicator column
  example_data_with_acceptable_symbol <- example_data
  example_data_with_acceptable_symbol$enrolment_count[1] <- "x"

  # Should not error when there are no obsolete symbols in the indicators, even if there are other symbols present
  expect_no_error(
    check_ind_invalid_entry(
      example_data_with_acceptable_symbol,
      example_meta
    )
  )
})

testthat::test_that("check_ind_invalid_entry: advisory when there is an ~ obsolete symbol in indicators", {
  # Create a copy of the example data with an obsolete symbol in the indicator column
  example_data_with_obsolete_symbol <- example_data
  example_data_with_obsolete_symbol$enrolment_count[1] <- "~"

  # Should return advisory when there are obsolete symbols in the indicators
  expect_equal(
    check_ind_invalid_entry(
      example_data_with_obsolete_symbol,
      example_meta
    )$result,
    "FAIL"
  )
})

testthat::test_that("check_ind_invalid_entry: advisory when there is an : obsolete symbol in indicators", {
  # Create a copy of the example data with an obsolete symbol in the indicator column
  example_data_with_obsolete_symbol <- example_data
  example_data_with_obsolete_symbol$enrolment_count[8] <- ":"

  # Should return advisory when there are obsolete symbols in the indicators
  expect_equal(
    check_ind_invalid_entry(
      example_data_with_obsolete_symbol,
      example_meta
    )$result,
    "FAIL"
  )
})
