test_that("passes with clean example data (National level only)", {
  expect_equal(
    check_geog_ignored_rows(example_data)$result,
    "PASS"
  )
  expect_no_error(
    check_geog_ignored_rows(example_data, stop_on_error = TRUE)
  )
})

test_that("passes with verbose output", {
  expect_no_error(
    check_geog_ignored_rows(example_data, verbose = TRUE)
  )
})

test_that("check name is correct", {
  result <- check_geog_ignored_rows(example_data)
  expect_equal(result$check, "geog_ignored_rows")
})

# PASS cases ==================================================================

test_that("passes when no rows are at ignored geographic levels", {
  data <- data.frame(
    geographic_level = c("National", "Regional", "Local authority")
  )
  expect_equal(check_geog_ignored_rows(data)$result, "PASS")
  expect_match(
    check_geog_ignored_rows(data)$message,
    "No rows in the file will be ignored"
  )
})

test_that("passes when data is solely at School level", {
  data <- data.frame(geographic_level = rep("School", 5))
  result <- check_geog_ignored_rows(data)
  expect_equal(result$result, "PASS")
  expect_match(result$message, "No rows in the file will be ignored")
})

test_that("passes when data is solely at Provider level", {
  data <- data.frame(geographic_level = rep("Provider", 5))
  result <- check_geog_ignored_rows(data)
  expect_equal(result$result, "PASS")
  expect_match(result$message, "No rows in the file will be ignored")
})

# WARNING cases ===============================================================

test_that("warns when all rows are at Institution or Planning area level", {
  data <- data.frame(
    geographic_level = c("Institution", "Planning area", "Institution")
  )
  result <- check_geog_ignored_rows(data)
  expect_equal(result$result, "WARNING")
  expect_match(result$message, "ancillary")
})

test_that("warns when file contains only Institution rows", {
  data <- data.frame(geographic_level = rep("Institution", 3))
  expect_equal(check_geog_ignored_rows(data)$result, "WARNING")
})

test_that("warns when file contains only Planning area rows", {
  data <- data.frame(geographic_level = rep("Planning area", 3))
  expect_equal(check_geog_ignored_rows(data)$result, "WARNING")
})

test_that("warns when some rows will be ignored alongside other levels", {
  data <- data.frame(
    geographic_level = c("National", "Regional", "School", "Institution")
  )
  result <- check_geog_ignored_rows(data)
  expect_equal(result$result, "WARNING")
  expect_match(result$message, "will be ignored")
})

test_that("warning message uses singular for one ignored row", {
  data <- data.frame(geographic_level = c("National", "Institution"))
  result <- check_geog_ignored_rows(data)
  expect_equal(result$result, "WARNING")
  expect_match(result$message, "^1 row will")
})

test_that("warning message uses plural for multiple ignored rows", {
  data <- data.frame(
    geographic_level = c("National", "Institution", "Planning area")
  )
  result <- check_geog_ignored_rows(data)
  expect_equal(result$result, "WARNING")
  expect_match(result$message, "^2 rows will")
})

test_that("warning includes guidance URL when rows will be ignored", {
  data <- data.frame(geographic_level = c("National", "School", "Institution"))
  result <- check_geog_ignored_rows(data)
  expect_equal(result$result, "WARNING")
  expect_false(is.na(result$guidance_url))
})

test_that("stop_on_error raises warning for WARNING result", {
  data <- data.frame(geographic_level = c("National", "Institution"))
  expect_warning(
    check_geog_ignored_rows(data, stop_on_error = TRUE)
  )
})

# FAIL cases ==================================================================

test_that("fails when School and Provider levels are mixed", {
  data <- data.frame(
    geographic_level = c("National", "School", "Provider")
  )
  result <- check_geog_ignored_rows(data)
  expect_equal(result$result, "FAIL")
  expect_match(result$message, "School and Provider")
})

test_that("fails when only School and Provider rows are present", {
  data <- data.frame(geographic_level = c("School", "Provider"))
  result <- check_geog_ignored_rows(data)
  expect_equal(result$result, "FAIL")
  expect_match(result$message, "mixed")
})

test_that("stop_on_error aborts on FAIL", {
  data <- data.frame(geographic_level = c("National", "School", "Provider"))
  expect_error(
    check_geog_ignored_rows(data, stop_on_error = TRUE)
  )
})
