region_data <- example_data |>
  dplyr::mutate(
    geographic_level = "Regional",
    region_code = "E12000001",
    region_name = "North East"
  )

# PASS cases ==================================================================

test_that("passes with package example data (no regional columns)", {
  result <- check_geog_region_col_present(example_data)
  expect_equal(result$result, "PASS")
  expect_match(result$message, "No regional columns")
})

test_that("passes when both region_code and region_name are present", {
  result <- check_geog_region_col_present(region_data)
  expect_equal(result$result, "PASS")
  expect_match(result$message, "other column is also present")
  expect_no_error(
    check_geog_region_col_present(region_data, stop_on_error = TRUE)
  )
})

# FAIL cases ==================================================================

test_that("fails when region_name is present but region_code is missing", {
  data <- example_data |>
    dplyr::mutate(region_name = "North East")
  result <- check_geog_region_col_present(data)
  expect_equal(result$result, "FAIL")
  expect_match(result$message, "region_name")
  expect_match(result$message, "region_code")
})

test_that("fails when region_code is present but region_name is missing", {
  data <- example_data |>
    dplyr::mutate(region_code = "E12000001")
  result <- check_geog_region_col_present(data)
  expect_equal(result$result, "FAIL")
  expect_match(result$message, "region_code")
  expect_match(result$message, "region_name")
})

test_that("fails with stop_on_error = TRUE when column is missing", {
  data <- example_data |>
    dplyr::mutate(region_code = "E12000001")
  expect_error(check_geog_region_col_present(data, stop_on_error = TRUE))
})
