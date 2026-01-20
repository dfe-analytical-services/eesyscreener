test_that("passes when no indicators have filter_grouping_column values", {
  data(example_data)
  meta <- data.frame(
    col_name = c("region", "year", "value"),
    col_type = c("Indicator", "Indicator", "Filter"),
    filter_grouping_column = c("", NA, NA),
    stringsAsFactors = FALSE
  )
  result <- check_meta_filter_group_level(example_data, meta)
  expect_equal(result$result, "PASS")
  expect_match(result$message, "There are no filter groups present.")
})

test_that("passes when ethnicity_major and ethnicity_minor have equal levels", {
  # Example data: both columns have 3 unique values
  example_data <- data.frame(
    ethnicity_major = c("White", "Black", "Asian"),
    ethnicity_minor = c("Irish", "African", "Indian"),
    value = c(1, 2, 3)
  )
  meta <- data.frame(
    col_name = c("ethnicity_minor"),
    col_type = c("Filter"),
    filter_grouping_column = c("ethnicity_major"),
    stringsAsFactors = FALSE
  )
  result <- check_meta_filter_group_level(example_data, meta)
  expect_equal(result$result, "PASS")
  expect_match(
    result$message,
    "All filter groups have an equal or lower number of levels than their corresponding filter."
  )
})

test_that("passes when filter group has fewer levels than filter", {
  # Example data: ethnicity_major has 2 unique values, ethnicity_minor has 3
  example_data <- data.frame(
    ethnicity_major = c("White", "White", "Black"),
    ethnicity_minor = c("Irish", "British", "African"),
    value = c(1, 2, 3)
  )
  meta <- data.frame(
    col_name = c("ethnicity_minor"),
    col_type = c("Filter"),
    filter_grouping_column = c("ethnicity_major"),
    stringsAsFactors = FALSE
  )
  result <- check_meta_filter_group_level(example_data, meta)
  expect_equal(result$result, "PASS")
  expect_match(
    result$message,
    "All filter groups have an equal or lower number of levels than their corresponding filter."
  )
})

test_that("fails when filter group has more levels than filter", {
  # Example data: ethnicity_major has 3 unique values, ethnicity_minor has 2
  example_data <- data.frame(
    ethnicity_major = c("White", "Black", "Asian"),
    ethnicity_minor = c("Irish", "Irish", "African"),
    value = c(1, 2, 3)
  )
  meta <- data.frame(
    col_name = c("ethnicity_minor"),
    col_type = c("Filter"),
    filter_grouping_column = c("ethnicity_major"),
    stringsAsFactors = FALSE
  )
  result <- check_meta_filter_group_level(example_data, meta)
  expect_equal(result$result, "FAIL")
})

test_that("fails when there are multiple filter groups and some of them fail", {
  # ethnicity_major has 3, ethnicity_minor has 2 (fail)
  # region_group has 2, region has 3 (pass)
  example_data <- data.frame(
    ethnicity_major = c("White", "Black", "Asian"),
    ethnicity_minor = c("Irish", "Irish", "African"),
    region_group = c("North", "South", "North"),
    region = c("A", "B", "C"),
    value = c(1, 2, 3)
  )
  meta <- data.frame(
    col_name = c("ethnicity_minor", "region"),
    col_type = c("Filter", "Filter"),
    filter_grouping_column = c("ethnicity_major", "region_group"),
    stringsAsFactors = FALSE
  )
  result <- check_meta_filter_group_level(example_data, meta)
  expect_equal(result$result, "FAIL")
  expect_match(
    result$message,
    "^The filter group 'ethnicity_major' has more levels"
  )
})

test_that("passes when no filters are present in meta", {
  example_data <- data.frame(
    region = c("A", "B", "C"),
    year = c(2020, 2021, 2022),
    value = c(1, 2, 3)
  )
  meta <- data.frame(
    col_name = c("region", "year", "value"),
    col_type = c("Indicator", "Indicator", "Indicator"),
    filter_grouping_column = c("", NA, NA),
    stringsAsFactors = FALSE
  )
  result <- check_meta_filter_group_level(example_data, meta)
  expect_equal(result$result, "PASS")
  expect_match(result$message, "There are no filter groups present.")
})

test_that("passes when filters have no grouping column", {
  example_data <- data.frame(
    region = c("A", "B", "C"),
    year = c(2020, 2021, 2022)
  )
  meta <- data.frame(
    col_name = c("region", "year"),
    col_type = c("Filter", "Filter"),
    filter_grouping_column = c("", NA),
    stringsAsFactors = FALSE
  )

  result <- check_meta_filter_group_level(example_data, meta)
  expect_equal(result$result, "PASS")
  expect_match(result$message, "There are no filter groups present.")
})
