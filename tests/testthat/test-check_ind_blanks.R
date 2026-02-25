testthat::test_that("check_ind_blanks: passes when there are no blanks in indicators", {
  # Should not error when there are no blanks in the indicators
  expect_no_error(
    check_ind_blanks(example_data, example_meta)
  )
})

testthat::test_that("check_ind_blanks: fails when there are blanks in indicators", {
  # Create a copy of the example data with a blank value in the indicator column
  example_data_with_blank <- example_data
  example_data_with_blank$enrolment_count[1] <- ""

  # Should error when there are blanks in the indicators
  expect_equal(
    check_ind_blanks(example_data_with_blank, example_meta)$result,
    "FAIL"
  )
})

testthat::test_that("check_ind_blanks: fails when there are blanks in indicators not in the first row", {
  # Create a copy of the example data with a blank value in the indicator column
  example_data_with_blank <- example_data
  example_data_with_blank$enrolment_count[7] <- ""
  example_data_with_blank$enrolment_count[8] <- ""

  # Should error when there are blanks in the indicators
  expect_equal(
    check_ind_blanks(example_data_with_blank, example_meta)$result,
    "FAIL"
  )
})

testthat::test_that("check_ind_blanks: returns an error when there are more than one indicator columns, and one contains blanks", {
  # Create a copy of the example data with a blank value in the indicator column
  example_data_with_blank <- example_data
  example_data_with_blank$enrolment_count[1] <- ""
  example_data_with_blank$enrolment_count[7] <- ""

  # Add another indicator column to the meta and data
  example_meta_with_extra_indicator <- dplyr::bind_rows(
    example_meta,
    data.frame(
      col_name = "extra_indicator",
      col_type = "Indicator",
      label = "An extra indicator",
      indicator_grouping = "",
      indicator_unit = "",
      indicator_dp = "0",
      filter_hint = "",
      filter_grouping_column = ""
    )
  )

  example_data_with_blank$extra_indicator <- c(10, 20, 30, 40, 50, 60, 70, 80, 90)

  # Should error when there are blanks in the indicators
  expect_equal(
    check_ind_blanks(example_data_with_blank, example_meta_with_extra_indicator)$result,
    "FAIL"
  )
})
