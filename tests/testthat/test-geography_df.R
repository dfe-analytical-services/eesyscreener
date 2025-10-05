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
