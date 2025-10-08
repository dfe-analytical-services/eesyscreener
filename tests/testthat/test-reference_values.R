# Acceptable values ===========================================================
test_that("output format is as expected", {
  expect_type(acceptable_time_ids, "character")
  expect_gt(length(acceptable_time_ids), 1)
})

# Required values =============================================================
test_that("output format is as expected", {
  expect_type(req_meta_cols, "character")
  expect_gt(length(req_meta_cols), 1)
  expect_type(optional_meta_cols, "character")
  expect_type(req_data_cols, "character")
  expect_gt(length(req_data_cols), 1)
})

# Geography data frame ========================================================
test_that("geography_df has correct structure", {
  expect_true(exists("geography_df"))
  expect_s3_class(geography_df, "data.frame")
  expect_equal(ncol(geography_df), 5)
  expect_equal(nrow(geography_df), 17)
  expect_equal(
    colnames(geography_df),
    c(
      "row_number",
      "geographic_level",
      "code_field",
      "name_field",
      "code_field_secondary"
    )
  )
})

test_that("geography_df columns have expected types", {
  expect_type(geography_df$row_number, "integer")
  expect_type(geography_df$geographic_level, "character")
  expect_type(geography_df$code_field, "character")
  expect_type(geography_df$name_field, "character")
  expect_type(geography_df$code_field_secondary, "character")
})

test_that("geography_df has expected values in key columns", {
  expect_equal(geography_df$row_number, 1:17)
  expect_true("National" %in% geography_df$geographic_level)
  expect_true("country_code" %in% geography_df$code_field)
  expect_true("country_name" %in% geography_df$name_field)
  expect_true("old_la_code" %in% geography_df$code_field_secondary)
  expect_true("school_laestab" %in% geography_df$code_field_secondary)
})

# Char limits =================================================================
test_that("returns correct columns and types", {
  result <- char_limits(c("A", "BB", "CCC"), 2)
  expect_s3_class(result, "data.frame")
  expect_named(result, c("value", "length", "exceeds_max"))
  expect_type(result$length, "integer")
  expect_type(result$exceeds_max, "logical")
})

test_that("correctly identifies values exceeding max_length", {
  values <- c("short", "toolong", "ok")
  max_length <- 5
  result <- char_limits(values, max_length)
  expect_equal(result$exceeds_max, c(FALSE, TRUE, FALSE))
  expect_equal(result$length, nchar(values))
})

test_that("handles empty vector input", {
  result <- char_limits(character(0), 5)
  expect_equal(nrow(result), 0)
  expect_named(result, c("value", "length", "exceeds_max"))
})

test_that("handles NA and blank values", {
  values <- c("A", NA, "", "ABCDE")
  max_length <- 3
  result <- char_limits(values, max_length)
  expect_equal(result$length, nchar(values))
  expect_equal(result$exceeds_max, c(FALSE, NA, FALSE, TRUE))
})

test_that("works with numeric input coerced to character", {
  values <- c(1, 22, 333)
  max_length <- 2
  result <- char_limits(as.character(values), max_length)
  expect_equal(result$exceeds_max, c(FALSE, FALSE, TRUE))
})
