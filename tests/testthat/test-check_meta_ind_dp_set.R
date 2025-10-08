test_that("passes when all indicator_dp values are present for indicators", {
  expect_equal(check_meta_ind_dp_set(example_meta)$result, "PASS")
  expect_no_error(check_meta_ind_dp_set(example_meta, stop_on_error = TRUE))
})

test_that("warns with one missing indicator_dp for indicator", {
  meta <- data.frame(
    col_name = c("A", "B", "C"),
    col_type = c("Indicator", "Indicator", "Filter"),
    indicator_dp = c("2", NA, NA),
    stringsAsFactors = FALSE
  )
  result <- check_meta_ind_dp_set(meta)
  expect_equal(result$result, "WARNING")
  expect_true(grepl(
    "B does not have a specified number of decimal places",
    result$message
  ))
  expect_warning(check_meta_ind_dp_set(meta, stop_on_error = TRUE))
})

test_that("warns with multiple missing indicator_dp for indicators", {
  meta <- data.frame(
    col_name = c("A", "B", "C"),
    col_type = c("Indicator", "Indicator", "Indicator"),
    indicator_dp = c(NA, "", NA),
    stringsAsFactors = FALSE
  )
  result <- check_meta_ind_dp_set(meta)
  expect_equal(result$result, "WARNING")
  expect_true(grepl(
    "The following indicators do not have a specified number of decimal",
    result$message
  ))
  expect_true(grepl("A', 'B', 'C", result$message))
  expect_warning(check_meta_ind_dp_set(meta, stop_on_error = TRUE))
})

test_that("trims whitespace and detects blanks in indicator_dp", {
  meta <- data.frame(
    col_name = c("A", "B", "C"),
    col_type = c("Indicator", "Indicator", "Indicator"),
    indicator_dp = c("2", "   ", "0"),
    stringsAsFactors = FALSE
  )
  result <- check_meta_ind_dp_set(meta)
  expect_equal(result$result, "WARNING")
  expect_true(grepl(
    "B does not have a specified number of decimal places",
    result$message
  ))
})

test_that("passes when no indicator rows present", {
  meta <- data.frame(
    col_name = c("A", "B", "C"),
    col_type = c("Filter", "Filter", "Filter"),
    indicator_dp = c(NA, NA, NA),
    stringsAsFactors = FALSE
  )
  expect_equal(check_meta_ind_dp_set(meta)$result, "PASS")
})
