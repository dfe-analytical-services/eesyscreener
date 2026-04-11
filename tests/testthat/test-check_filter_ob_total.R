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

# School / provider name exemption ============================================

test_that("passes when school_name is only filter and contains Total", {
  sch_meta <- data.frame(
    col_name = c("school_name", "enrolment_count"),
    col_type = c("Filter", "Indicator"),
    filter_grouping_column = c("", ""),
    stringsAsFactors = FALSE
  )
  sch_data <- data.frame(school_name = "Total", enrolment_count = 10)

  result <- check_filter_ob_total(sch_data, sch_meta)
  expect_equal(result$result, "PASS")
})

test_that("passes when provider_name is only filter and contains Total", {
  prov_meta <- data.frame(
    col_name = c("provider_name", "enrolment_count"),
    col_type = c("Filter", "Indicator"),
    filter_grouping_column = c("", ""),
    stringsAsFactors = FALSE
  )
  prov_data <- data.frame(provider_name = "Total", enrolment_count = 10)

  result <- check_filter_ob_total(prov_data, prov_meta)
  expect_equal(result$result, "PASS")
})

test_that("fails when school_name contains Total but is not the only filter", {
  # school_name is matched by the regex; with multiple filters the exemption
  # does not apply, so school_name should be flagged
  two_filter_meta <- data.frame(
    col_name = c("school_name", "sex", "enrolment_count"),
    col_type = c("Filter", "Filter", "Indicator"),
    filter_grouping_column = c("", "", ""),
    stringsAsFactors = FALSE
  )
  bad_data <- data.frame(
    school_name = "Total",
    sex = "Male",
    enrolment_count = 10
  )

  result <- check_filter_ob_total(bad_data, two_filter_meta)
  expect_equal(result$result, "FAIL")
  expect_match(result$message, "school_name")
})

# PASS message variants =======================================================

test_that("PASS has two separate variants that trigger correctly", {
  # Cols-exist-but-clean path: example_data has ob units, none with Total/All
  result_clean <- check_filter_ob_total(example_data, example_meta)
  expect_equal(result_clean$result, "PASS")
  expect_match(
    result_clean$message,
    "There are no Total or All values in the observational unit columns."
  )

  # No-ob-cols path: data with only filter and indicator columns
  no_ob_data <- data.frame(sex = "Male", enrolment_count = 10)
  result_no_cols <- check_filter_ob_total(no_ob_data, example_meta)
  expect_equal(result_no_cols$result, "PASS")
  expect_match(
    result_no_cols$message,
    "No observational unit columns were found in this data to check."
  )

  # The two messages must differ
  expect_false(result_clean$message == result_no_cols$message)
})
