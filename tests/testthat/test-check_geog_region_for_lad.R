lad_data <- data.frame(
  time_period = "201718",
  time_identifier = "Academic year",
  geographic_level = "Local authority district",
  country_code = "E92000001",
  country_name = "England",
  region_code = "E12000001",
  region_name = "North East",
  lad_code = "E06000001",
  lad_name = "Hartlepool",
  sex = "All pupils",
  education_phase = "All schools",
  enrolment_count = 100,
  stringsAsFactors = FALSE
)

test_that("passes with clean example data (no LAD level)", {
  result <- check_geog_region_for_lad(example_data)
  expect_equal(result$result, "PASS")
  expect_no_error(
    check_geog_region_for_lad(example_data, stop_on_error = TRUE)
  )
})

test_that("passes when LAD data has both region columns fully completed", {
  result <- check_geog_region_for_lad(lad_data)
  expect_equal(result$result, "PASS")
  expect_match(
    result$message,
    "Both region_code and region_name are completed"
  )
})

test_that("passes with message when no LAD level data present", {
  result <- check_geog_region_for_lad(example_data)
  expect_equal(result$result, "PASS")
  expect_match(result$message, "no Local authority district level data")
})

test_that("warns when region_code column is missing", {
  bad_data <- lad_data[, !names(lad_data) %in% "region_code"]
  result <- check_geog_region_for_lad(bad_data)
  expect_equal(result$result, "WARNING")
  expect_match(result$message, "region_code")
})

test_that("warns when region_name column is missing", {
  bad_data <- lad_data[, !names(lad_data) %in% "region_name"]
  result <- check_geog_region_for_lad(bad_data)
  expect_equal(result$result, "WARNING")
  expect_match(result$message, "region_name")
})

test_that("warns when both region columns are missing", {
  bad_data <- lad_data[, !names(lad_data) %in% c("region_code", "region_name")]
  result <- check_geog_region_for_lad(bad_data)
  expect_equal(result$result, "WARNING")
  expect_match(result$message, "region_code")
  expect_match(result$message, "region_name")
  expect_match(result$message, "columns are missing")
})

# These tests rely on reading values in as varchar so there are no NAs
test_that("warns when region_code has missing values for LAD rows", {
  bad_data <- lad_data
  bad_data$region_code <- ""
  result <- check_geog_region_for_lad(bad_data)
  expect_equal(result$result, "WARNING")
  expect_match(result$message, "missing values")
})

test_that("warns when region_name has missing values for LAD rows", {
  bad_data <- lad_data
  bad_data$region_name <- ""
  result <- check_geog_region_for_lad(bad_data)
  expect_equal(result$result, "WARNING")
  expect_match(result$message, "missing values")
})

test_that("warns when at least one value is correctly present", {
  bad_data <- rbind(lad_data, lad_data, lad_data)
  bad_data$region_code[3] <- NA
  result <- check_geog_region_for_lad(bad_data)
  expect_equal(result$result, "WARNING")
  expect_match(result$message, "missing values")
})

test_that("missing columns message uses singular when one column missing", {
  bad_data <- lad_data[, !names(lad_data) %in% "region_code"]
  result <- check_geog_region_for_lad(bad_data)
  expect_match(result$message, "column is missing")
})

test_that("missing columns message uses plural when both columns missing", {
  bad_data <- lad_data[, !names(lad_data) %in% c("region_code", "region_name")]
  result <- check_geog_region_for_lad(bad_data)
  expect_match(result$message, "columns are missing")
})
