testthat::test_that("check_meta_whitespace_filters: passes when no whitespace", {
  # Should not error when there are no leading/trailing spaces
  expect_no_error(
    check_meta_whitespace_filters(example_data, example_meta)
  )
})

testthat::test_that("check_meta_whitespace_filters: fails with exactly one offending label", {
  # One label with trailing whitespace
  data <- data.frame(
    FilterA = c("Alpha ", "Beta"),
    Region  = c("North", "South"),
    stringsAsFactors = FALSE
  )

  meta <- data.frame(
    col_name = "FilterA",
    col_type = "Filter",
    stringsAsFactors = FALSE
  )

  # Test should fail
  expect_equal(
    check_meta_whitespace_filters(data, meta)$result,
    "FAIL"
  )
})

testthat::test_that("check_meta_whitespace_filters: fails with multiple offending labels", {
  # Multiple labels: leading and trailing spaces in different rows/cols
  data <- data.frame(
    FilterA = c(" Alpha", "Beta"),
    LA      = c(" Sheffield", "Leeds "),
    stringsAsFactors = FALSE
  )

  meta <- data.frame(
    col_name = c("FilterA"),
    col_type = c("Filter"),
    stringsAsFactors = FALSE
  )

  # Test should fail
  expect_equal(
    check_meta_whitespace_filters(data, meta)$result,
    "FAIL"
  )
})
