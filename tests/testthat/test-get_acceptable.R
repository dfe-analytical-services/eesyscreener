test_that("get_acceptable_ob_units returns expected structure and values", {
  result <- get_acceptable_ob_units()
  expect_type(result, "character")
  expect_true("time_period" %in% result)
  expect_true("geographic_level" %in% result)
  expect_true("country_code" %in% result)
  expect_false(any(is.na(result)))
  expect_true(length(unique(result)) == length(result))
})
