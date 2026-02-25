testthat::test_that("check_meta_ind_dp_values: passes when indicator_dp is blank or accepted numeric value", {
  # Should not error when there are only NA/blank values and positive integers or zero in the indicator_dp column
  expect_no_error(
    check_meta_ind_dp_values(example_meta)
  )
})

testthat::test_that("check_meta_ind_dp_values: passes when indicator_dp is blank", {
  # Should not error when there are only NA/blank values in the indicator_dp column
  example_meta_pass <- example_meta
  example_meta_pass$indicator_dp <- c(NA, NA, NA)

  expect_no_error(
    check_meta_ind_dp_values(example_meta)
  )
})

testthat::test_that("check_meta_ind_dp_values: fails when indicator_dp contains negative integers", {
  # Should error when there are negative integers in the indicator_dp column
  example_meta_fail <- example_meta
  example_meta_fail$indicator_dp <- c(NA, NA, -1)

  expect_equal(
    check_meta_ind_dp_values(example_meta_fail)$result,
    "FAIL"
  )
})

testthat::test_that("check_meta_ind_dp_values: fails when indicator_dp contains non-integer numeric values", {
  # Should error when there are non-integer numeric values in the indicator_dp column
  example_meta_fail <- example_meta
  example_meta_fail$indicator_dp <- c(NA, NA, 1.5)

  expect_equal(
    check_meta_ind_dp_values(example_meta_fail)$result,
    "FAIL"
  )
})

testthat::test_that("check_meta_ind_dp_values: fails when indicator_dp contains non-numeric values", {
  # Should error when there are non-numeric values in the indicator_dp column
  example_meta_fail <- example_meta
  example_meta_fail$indicator_dp <- c(NA, NA, "non-numeric")

  expect_equal(
    check_meta_ind_dp_values(example_meta_fail)$result,
    "FAIL"
  )
})
