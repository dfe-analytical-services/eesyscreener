test_that("passes when all filters have two or more levels", {
  expect_equal(
    precheck_filter_not_singular(example_data, example_meta)$result,
    "PASS"
  )
})

test_that("passes when there are no filters in the metadata", {
  meta_no_filters <- example_meta[example_meta$col_type != "Filter", ]
  result <- precheck_filter_not_singular(example_data, meta_no_filters)
  expect_equal(result$result, "PASS")
  expect_true(grepl("no filters", result$message))
})

test_that("fails when a single filter has only one level (singular message)", {
  single_level_data <- example_data |>
    dplyr::mutate(sex = "Male")
  result <- precheck_filter_not_singular(single_level_data, example_meta)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("sex", result$message))
  expect_true(grepl("filter has", result$message))
})

test_that("fails when multiple filters have only one level (plural message)", {
  single_level_data <- example_data |>
    dplyr::mutate(sex = "Male", education_phase = "Primary")
  result <- precheck_filter_not_singular(single_level_data, example_meta)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("sex", result$message))
  expect_true(grepl("education_phase", result$message))
  expect_true(grepl("filters have", result$message))
})
