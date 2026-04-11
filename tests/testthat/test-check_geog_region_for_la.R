la_data <- data.frame(
  time_period = "201718",
  time_identifier = "Academic year",
  geographic_level = "Local authority",
  country_code = "E92000001",
  country_name = "England",
  region_code = "E12000001",
  region_name = "North East",
  new_la_code = "E06000001",
  la_name = "Hartlepool",
  sex = "All pupils",
  education_phase = "All phases",
  enrolment_count = 100,
  stringsAsFactors = FALSE
)

test_that("passes with clean example data (no LA level)", {
  result <- check_geog_region_for_la(example_data)
  expect_equal(result$result, "PASS")
  expect_no_error(
    check_geog_region_for_la(example_data, stop_on_error = TRUE)
  )
})

test_that("passes with verbose output on example data", {
  expect_no_error(
    check_geog_region_for_la(example_data, verbose = TRUE)
  )
})

test_that("passes when LA data has both region columns fully completed", {
  result <- check_geog_region_for_la(la_data)
  expect_equal(result$result, "PASS")
  expect_match(
    result$message,
    "Both region_code and region_name are completed"
  )
})


test_that("passes with message when no LA level data present", {
  result <- check_geog_region_for_la(example_data)
  expect_equal(result$result, "PASS")
  expect_match(result$message, "no Local authority level data")
})

test_that("warns when region_code column is missing", {
  bad_data <- la_data[, !names(la_data) %in% "region_code"]
  result <- check_geog_region_for_la(bad_data)
  expect_equal(result$result, "WARNING")
  expect_match(result$message, "region_code")
})

test_that("warns when region_name column is missing", {
  bad_data <- la_data[, !names(la_data) %in% "region_name"]
  result <- check_geog_region_for_la(bad_data)
  expect_equal(result$result, "WARNING")
  expect_match(result$message, "region_name")
})

test_that("warns when both region columns are missing", {
  bad_data <- la_data[, !names(la_data) %in% c("region_code", "region_name")]
  result <- check_geog_region_for_la(bad_data)
  expect_equal(result$result, "WARNING")
  expect_match(result$message, "region_code")
  expect_match(result$message, "region_name")
})

test_that("warns when region_code has NA values for LA rows", {
  bad_data <- la_data
  bad_data$region_code <- NA
  result <- check_geog_region_for_la(bad_data)
  expect_equal(result$result, "WARNING")
  expect_match(result$message, "missing values")
})

test_that("warns when region_name has NA values for LA rows", {
  bad_data <- la_data
  bad_data$region_name <- NA
  result <- check_geog_region_for_la(bad_data)
  expect_equal(result$result, "WARNING")
  expect_match(result$message, "missing values")
})

test_that("stop_on_error warns on WARNING result", {
  bad_data <- la_data
  bad_data$region_code <- NA
  expect_warning(
    check_geog_region_for_la(bad_data, stop_on_error = TRUE)
  )
})

test_that("check name is correct", {
  result <- check_geog_region_for_la(example_data)
  expect_equal(result$check, "geog_region_for_la")
})

test_that("missing columns message uses singular when one column missing", {
  bad_data <- la_data[, !names(la_data) %in% "region_code"]
  result <- check_geog_region_for_la(bad_data)
  expect_match(result$message, "column is missing")
})

test_that("missing columns message uses plural when both columns missing", {
  bad_data <- la_data[, !names(la_data) %in% c("region_code", "region_name")]
  result <- check_geog_region_for_la(bad_data)
  expect_match(result$message, "columns are missing")
})
