test_that("passes when all metadata variables are found in the data", {
  data <- data.frame(col_a = 1:3, col_b = 4:6, col_c = 7:9)
  meta <- data.frame(
    col_name = c("col_a", "col_b"),
    filter_grouping_column = c("", "")
  )
  expect_equal(precheck_cross_meta_to_data(data, meta)$result, "PASS")
  expect_no_error(precheck_cross_meta_to_data(data, meta, stop_on_error = TRUE))
  expect_no_error(
    precheck_cross_meta_to_data(
      example_data,
      example_meta,
      stop_on_error = TRUE
    )
  )
})

test_that("passes when filter_grouping_column values are also found in data", {
  data <- data.frame(col_a = 1:3, col_b = 4:6, col_c = 7:9)
  meta <- data.frame(
    col_name = c("col_a"),
    filter_grouping_column = c("col_b")
  )
  expect_equal(precheck_cross_meta_to_data(data, meta)$result, "PASS")
  expect_no_error(precheck_cross_meta_to_data(data, meta, stop_on_error = TRUE))
})

test_that("fails with one missing variable", {
  data <- data.frame(col_a = 1:3, col_b = 4:6)
  meta <- data.frame(
    col_name = c("col_a", "col_missing"),
    filter_grouping_column = c("", "")
  )
  result <- precheck_cross_meta_to_data(data, meta)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("col_missing", result$message))
  expect_error(precheck_cross_meta_to_data(data, meta, stop_on_error = TRUE))
})

test_that("fails with multiple missing variables", {
  data <- data.frame(col_a = 1:3)
  meta <- data.frame(
    col_name = c("col_a", "col_missing_1", "col_missing_2"),
    filter_grouping_column = c("", "", "")
  )
  result <- precheck_cross_meta_to_data(data, meta)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("col_missing_1", result$message))
  expect_true(grepl("col_missing_2", result$message))
  expect_error(precheck_cross_meta_to_data(data, meta, stop_on_error = TRUE))
})

test_that("fails when a filter_grouping_column is missing from data", {
  data <- data.frame(col_a = 1:3)
  meta <- data.frame(
    col_name = c("col_a"),
    filter_grouping_column = c("missing_group")
  )
  result <- precheck_cross_meta_to_data(data, meta)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("missing_group", result$message))
  expect_error(precheck_cross_meta_to_data(data, meta, stop_on_error = TRUE))
})

test_that("ignores NA and empty filter_grouping_column values", {
  data <- data.frame(col_a = 1:3, col_b = 4:6)
  meta <- data.frame(
    col_name = c("col_a", "col_b"),
    filter_grouping_column = c(NA, "")
  )
  expect_equal(precheck_cross_meta_to_data(data, meta)$result, "PASS")
})
