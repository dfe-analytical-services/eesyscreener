test_that("passes when all data variables are ob units or in metadata", {
  expect_equal(
    precheck_cross_data_to_meta(example_data, example_meta)$result,
    "PASS"
  )
  expect_no_error(
    precheck_cross_data_to_meta(
      example_data,
      example_meta,
      stop_on_error = TRUE
    )
  )
})

test_that("passes when filter_grouping_column values cover data columns", {
  expect_equal(
    precheck_cross_data_to_meta(
      example_filter_group_wrow,
      example_filter_group_wrow_meta
    )$result,
    "PASS"
  )
  expect_no_error(
    precheck_cross_data_to_meta(
      example_filter_group_wrow,
      example_filter_group_wrow_meta,
      stop_on_error = TRUE
    )
  )
})

test_that("warns with one variable not in metadata (singular message)", {
  bad_data <- example_data |>
    dplyr::mutate(extra_col = rep(c("A", "B"), length.out = dplyr::n()))
  result <- precheck_cross_data_to_meta(bad_data, example_meta)
  expect_equal(result$result, "WARNING")
  expect_true(grepl("extra_col", result$message))
  expect_true(grepl("variable in", result$message))
  expect_warning(
    precheck_cross_data_to_meta(bad_data, example_meta, stop_on_error = TRUE)
  )
})

test_that("warns with multiple variables not in metadata (plural message)", {
  bad_data <- example_data |>
    dplyr::mutate(
      extra_col_1 = rep(c("A", "B"), length.out = dplyr::n()),
      extra_col_2 = rep(c("X", "Y"), length.out = dplyr::n())
    )
  result <- precheck_cross_data_to_meta(bad_data, example_meta)
  expect_equal(result$result, "WARNING")
  expect_true(grepl("extra_col_1", result$message))
  expect_true(grepl("extra_col_2", result$message))
  expect_true(grepl("variables in", result$message))
  expect_warning(
    precheck_cross_data_to_meta(bad_data, example_meta, stop_on_error = TRUE)
  )
})

test_that("passes when unlisted column has only a single unique value", {
  single_level_data <- example_data |>
    dplyr::mutate(single_level_col = "constant_value")
  expect_equal(
    precheck_cross_data_to_meta(single_level_data, example_meta)$result,
    "PASS"
  )
})

test_that("passes with verbose = TRUE without error", {
  expect_no_error(
    precheck_cross_data_to_meta(example_data, example_meta, verbose = TRUE)
  )
})
