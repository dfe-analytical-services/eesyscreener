test_that("passes with clean example data", {
  expect_equal(
    check_filter_ob_total(example_data, example_meta)$result,
    "PASS"
  )
  expect_no_error(
    check_filter_ob_total(example_data, example_meta, stop_on_error = TRUE)
  )
})

test_that("passes with verbose output", {
  expect_no_error(
    check_filter_ob_total(example_data, example_meta, verbose = TRUE)
  )
})

test_that("fails when a single ob unit column contains 'Total'", {
  bad_data <- example_data |>
    dplyr::mutate(country_name = "Total")

  result <- check_filter_ob_total(bad_data, example_meta)
  expect_equal(result$result, "FAIL")
  expect_match(result$message, "column:")
  expect_match(result$message, "country_name")
})

test_that("fails when a single ob unit column contains 'All'", {
  bad_data <- example_data |>
    dplyr::mutate(country_name = "All")

  result <- check_filter_ob_total(bad_data, example_meta)
  expect_equal(result$result, "FAIL")
  expect_match(result$message, "country_name")
})

test_that("fails when a single ob unit column contains lowercase 'total'", {
  bad_data <- example_data |>
    dplyr::mutate(country_name = "total")

  result <- check_filter_ob_total(bad_data, example_meta)
  expect_equal(result$result, "FAIL")
  expect_match(result$message, "country_name")
})

test_that("fails when a single ob unit column contains lowercase 'all'", {
  bad_data <- example_data |>
    dplyr::mutate(country_name = "all")

  result <- check_filter_ob_total(bad_data, example_meta)
  expect_equal(result$result, "FAIL")
  expect_match(result$message, "country_name")
})

test_that("uses singular message for one failing column", {
  bad_data <- example_data |>
    dplyr::mutate(country_name = "Total")

  result <- check_filter_ob_total(bad_data, example_meta)
  expect_match(result$message, "column:")
  expect_no_match(result$message, "columns:")
})

test_that("uses plural message for multiple failing columns", {
  bad_data <- example_data |>
    dplyr::mutate(country_name = "Total", country_code = "Total")

  result <- check_filter_ob_total(bad_data, example_meta)
  expect_equal(result$result, "FAIL")
  expect_match(result$message, "columns:")
  expect_match(result$message, "country_name")
  expect_match(result$message, "country_code")
})

test_that("stop_on_error aborts on failure", {
  bad_data <- example_data |>
    dplyr::mutate(country_name = "Total")

  expect_error(
    check_filter_ob_total(bad_data, example_meta, stop_on_error = TRUE)
  )
})

test_that("check name is correct", {
  result <- check_filter_ob_total(example_data, example_meta)
  expect_equal(result$check, "filter_ob_total")
})

test_that("fails for geography-like columns matching regex with Total values", {
  # region_code and region_name are ob unit columns - add them to the data
  bad_data <- example_data |>
    dplyr::mutate(region_code = "Total", region_name = "Total")

  result <- check_filter_ob_total(bad_data, example_meta)
  expect_equal(result$result, "FAIL")
  expect_match(result$message, "region_code")
})
