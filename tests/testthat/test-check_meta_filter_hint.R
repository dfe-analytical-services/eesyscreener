test_that("passes when no filter_hint values are present for indicators", {
  meta <- data.frame(
    col_name = c("A", "B", "C"),
    col_type = c("Indicator", "Indicator", "Filter"),
    filter_hint = c(NA, "", "hint hint"),
    stringsAsFactors = FALSE
  )
  expect_equal(check_meta_filter_hint(meta)$result, "PASS")
  expect_no_error(check_meta_filter_hint(meta, stop_on_error = TRUE))
})

test_that("fails with one indicator having a filter_hint", {
  meta <- data.frame(
    col_name = c("A", "B", "C"),
    col_type = c("Indicator", "Indicator", "Filter"),
    filter_hint = c("hint hint", NA, NA),
    stringsAsFactors = FALSE
  )
  result <- check_meta_filter_hint(meta)
  expect_equal(result$result, "FAIL")
  expect_true(grepl(
    "Indicators should not have a filter_hint value",
    result$message
  ))
  expect_true(grepl("A", result$message))
  expect_error(check_meta_filter_hint(meta, stop_on_error = TRUE))
})

test_that("fails with multiple indicators having filter_hint values", {
  meta <- data.frame(
    col_name = c("A", "B", "C"),
    col_type = c("Indicator", "Indicator", "Indicator"),
    filter_hint = c("hint1", "hint2", "hint3"),
    stringsAsFactors = FALSE
  )
  result <- check_meta_filter_hint(meta)
  expect_equal(result$result, "FAIL")
  expect_true(grepl(
    "Indicators should not have a filter_hint value",
    result$message
  ))
  expect_true(grepl("A', 'B', 'C", result$message))
  expect_error(check_meta_filter_hint(meta, stop_on_error = TRUE))
})

test_that("trims whitespace and detects non-empty filter_hint", {
  meta <- data.frame(
    col_name = c("A", "B", "C"),
    col_type = c("Indicator", "Indicator", "Indicator"),
    filter_hint = c("   hint   ", "   ", NA),
    stringsAsFactors = FALSE
  )
  result <- check_meta_filter_hint(meta)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("A", result$message))
})

test_that("passes when no indicator rows are present", {
  meta <- data.frame(
    col_name = c("A", "B", "C"),
    col_type = c("Filter", "Filter", "Filter"),
    filter_hint = c("hint1", NA, ""),
    stringsAsFactors = FALSE
  )
  expect_equal(check_meta_filter_hint(meta)$result, "PASS")
})
