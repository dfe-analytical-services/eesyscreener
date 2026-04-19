test_that("passes with example data", {
  expect_equal(
    check_filter_item_limit(example_data, example_meta)$result,
    "PASS"
  )
})

test_that("passes when there are no filter columns", {
  result <- check_filter_item_limit(
    example_data |> dplyr::select(-c("sex", "education_phase")),
    example_meta |> dplyr::filter(col_type != "Filter")
  )
  expect_equal(result$result, "PASS")
  expect_match(result$message, "no filters")
})

test_that("passes when filter unique entries are at the limit", {
  data <- data.frame(sex = c("Male", "Female"), count = c(1, 2))
  meta <- data.frame(
    col_name = c("sex", "count"),
    col_type = c("Filter", "Indicator"),
    filter_grouping_column = c("", ""),
    stringsAsFactors = FALSE
  )
  result <- check_filter_item_limit(data, meta, filter_item_limit = 2)
  expect_equal(result$result, "PASS")
})

test_that("fails when a single filter exceeds the item limit", {
  data <- data.frame(
    sex = c("Male", "Female", "All pupils"),
    count = c(1, 2, 3)
  )
  meta <- data.frame(
    col_name = c("sex", "count"),
    col_type = c("Filter", "Indicator"),
    filter_grouping_column = c("", ""),
    stringsAsFactors = FALSE
  )
  result <- check_filter_item_limit(data, meta, filter_item_limit = 2)
  expect_equal(result$result, "FAIL")
  expect_match(result$message, "sex")
})

test_that("names all offending filters when multiple exceed the limit", {
  data <- data.frame(
    sex = c("Male", "Female", "All pupils"),
    phase = c("Primary", "Secondary", "All phases"),
    count = c(1, 2, 3)
  )
  meta <- data.frame(
    col_name = c("sex", "phase", "count"),
    col_type = c("Filter", "Filter", "Indicator"),
    filter_grouping_column = c("", "", ""),
    stringsAsFactors = FALSE
  )
  result <- check_filter_item_limit(data, meta, filter_item_limit = 2)
  expect_equal(result$result, "FAIL")
  expect_match(result$message, "sex")
  expect_match(result$message, "phase")
})
