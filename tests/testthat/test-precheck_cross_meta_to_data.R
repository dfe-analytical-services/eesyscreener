test_that("passes when all metadata variables are found in the data", {
  expect_equal(
    precheck_cross_meta_to_data(example_data, example_meta)$result,
    "PASS"
  )
  expect_no_error(
    precheck_cross_meta_to_data(
      example_data,
      example_meta,
      stop_on_error = TRUE
    )
  )
})

test_that("passes when filter_grouping_column values are also found in data", {
  expect_equal(
    precheck_cross_meta_to_data(
      example_filter_group_wrow,
      example_filter_group_wrow_meta
    )$result,
    "PASS"
  )
  expect_no_error(
    precheck_cross_meta_to_data(
      example_filter_group_wrow,
      example_filter_group_wrow_meta,
      stop_on_error = TRUE
    )
  )
})

test_that("fails with one missing variable (singular message)", {
  bad_meta <- example_meta |>
    rbind(data.frame(
      col_name = "missing_col",
      col_type = "Filter",
      label = "Missing column",
      indicator_grouping = "",
      indicator_unit = "",
      indicator_dp = NA,
      filter_hint = "",
      filter_grouping_column = "",
      filter_default = ""
    ))
  result <- precheck_cross_meta_to_data(example_data, bad_meta)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("missing_col", result$message))
  expect_true(grepl("variable was", result$message))
  expect_error(
    precheck_cross_meta_to_data(example_data, bad_meta, stop_on_error = TRUE)
  )
})

test_that("fails with multiple missing variables (plural message)", {
  bad_meta <- example_meta |>
    rbind(data.frame(
      col_name = c("missing_col_1", "missing_col_2"),
      col_type = "Filter",
      label = c("Missing column 1", "Missing column 2"),
      indicator_grouping = "",
      indicator_unit = "",
      indicator_dp = NA,
      filter_hint = "",
      filter_grouping_column = "",
      filter_default = ""
    ))
  result <- precheck_cross_meta_to_data(example_data, bad_meta)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("missing_col_1", result$message))
  expect_true(grepl("missing_col_2", result$message))
  expect_true(grepl("variables were", result$message))
  expect_error(
    precheck_cross_meta_to_data(example_data, bad_meta, stop_on_error = TRUE)
  )
})

test_that("fails when a filter_grouping_column is missing from data", {
  bad_meta <- example_filter_group_wrow_meta |>
    rbind(data.frame(
      col_name = "education_phase",
      col_type = "Filter",
      label = "Education phase",
      indicator_grouping = "",
      indicator_unit = "",
      indicator_dp = NA,
      filter_hint = "",
      filter_grouping_column = "missing_group",
      filter_default = ""
    ))
  result <- precheck_cross_meta_to_data(example_filter_group_wrow, bad_meta)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("missing_group", result$message))
  expect_error(
    precheck_cross_meta_to_data(
      example_filter_group_wrow,
      bad_meta,
      stop_on_error = TRUE
    )
  )
})

test_that("ignores NA and empty filter_grouping_column values", {
  # If NAs were not ignored, the check would look for a column named NA in
  # the data and fail
  meta_with_na_groups <- example_meta |>
    dplyr::mutate(filter_grouping_column = NA_character_)
  expect_equal(
    precheck_cross_meta_to_data(example_data, meta_with_na_groups)$result,
    "PASS"
  )
  expect_no_error(
    precheck_cross_meta_to_data(
      example_data,
      meta_with_na_groups,
      stop_on_error = TRUE
    )
  )
})
