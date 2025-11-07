test_that("passes when no indicators have filter_grouping_column values", {
  meta <- data.frame(
    col_name = c("A", "B", "C"),
    col_type = c("Indicator", "Indicator", "Filter"),
    filter_grouping_column = c("", NA, NA),
    stringsAsFactors = FALSE
  )
  result <- check_meta_filter_group(meta)
  expect_equal(result$result, "PASS")
  expect_no_error(check_meta_filter_group(meta, stop_on_error = TRUE))
})

test_that("fails when one indicator has a filter_grouping_column value", {
  meta <- data.frame(
    col_name = c("A", "B", "C"),
    col_type = c("Indicator", "Indicator", "Filter"),
    filter_grouping_column = c("group1", NA, NA),
    stringsAsFactors = FALSE
  )
  result <- check_meta_filter_group(meta)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("A", result$message))
  expect_error(check_meta_filter_group(meta, stop_on_error = TRUE))
})

test_that("fails when multiple indicators have filter_grouping_column values", {
  meta <- data.frame(
    col_name = c("A", "B", "C"),
    col_type = c("Indicator", "Indicator", "Indicator"),
    filter_grouping_column = c("group1", "group2", ""),
    stringsAsFactors = FALSE
  )
  result <- check_meta_filter_group(meta)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("A', 'B", result$message))
  expect_error(check_meta_filter_group(meta, stop_on_error = TRUE))
})

test_that("trims whitespace and detects non-blank filter_grouping_column values", {
  meta <- data.frame(
    col_name = c("A", "B", "C"),
    col_type = c("Indicator", "Indicator", "Indicator"),
    filter_grouping_column = c("  group1  ", "", NA),
    stringsAsFactors = FALSE
  )
  result <- check_meta_filter_group(meta)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("A", result$message))
})

test_that("passes when no indicator rows are present", {
  meta <- data.frame(
    col_name = c("A", "B", "C"),
    col_type = c("Filter", "Filter", "Filter"),
    filter_grouping_column = c("group1", "", NA),
    stringsAsFactors = FALSE
  )
  result <- check_meta_filter_group(meta)
  expect_equal(result$result, "PASS")
})
