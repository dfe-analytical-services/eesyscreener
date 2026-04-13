test_that("returns character vector with no NAs or blanks", {
  result <- get_geog_level_cols("Local authority")
  expect_type(result, "character")
  expect_false(anyNA(result))
  expect_false(any(result == ""))
})

test_that("returns all three columns for a level with a secondary code field", {
  # Local authority: new_la_code, la_name, old_la_code
  result <- get_geog_level_cols("Local authority")
  expect_setequal(result, c("new_la_code", "la_name", "old_la_code"))
})

test_that("returns two columns for a level with no secondary code field", {
  # Regional has code_field and name_field but no code_field_secondary
  result <- get_geog_level_cols("Regional")
  expect_setequal(result, c("region_code", "region_name"))
})

test_that("returns one column for a level with only a name field", {
  # RSC region has no code_field or code_field_secondary
  result <- get_geog_level_cols("RSC region")
  expect_setequal(result, c("rsc_region_lead_name"))
})

test_that("errors for an unrecognised geographic level", {
  expect_error(get_geog_level_cols("Atlantis"), "not a valid geographic level")
})
