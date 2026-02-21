test_that("get_geo_code_cols returns expected structure and values", {
  result <- get_geo_code_cols()
  expect_type(result, "character")
  expect_true("country_code" %in% result)
  expect_true("new_la_code" %in% result)
  expect_true("old_la_code" %in% result)
  expect_false(anyNA(result))
  expect_true(length(unique(result)) == length(result))
})
