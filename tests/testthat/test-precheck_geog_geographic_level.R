test_that("passes when geographic levels are acceptable values", {
  data <- data.frame(
    geographic_level = c("National", "Regional", "Local authority")
  )
  expect_equal(precheck_geog_geographic_level(data)$result, "PASS")
  expect_no_error(precheck_geog_geographic_level(
    data,
    stop_on_error = TRUE
  ))
  expect_no_error(precheck_geog_geographic_level(
    example_data,
    stop_on_error = TRUE
  ))
})

test_that("fails when geographic levels are blanks or NAs", {
  data <- data.frame(
    geographic_level = c("", NA)
  )
  expect_equal(precheck_geog_geographic_level(data)$result, "FAIL")
  expect_error(precheck_geog_geographic_level(
    data,
    stop_on_error = TRUE
  ))
})

test_that("fails when only some geographic levels are blanks or NAs", {
  data <- data.frame(
    geographic_level = c("National", "School", "", NA)
  )
  expect_equal(precheck_geog_geographic_level(data)$result, "FAIL")
  expect_error(precheck_geog_geographic_level(
    data,
    stop_on_error = TRUE
  ))
})

test_that("fails when one geographic level is not an acceptable value", {
  data <- data.frame(
    geographic_level = c("Ward", "Constituency", "Parliamentary constituency")
  )
  expect_equal(precheck_geog_geographic_level(data)$result, "FAIL")
  expect_error(precheck_geog_geographic_level(
    data,
    stop_on_error = TRUE
  ))
})

test_that("fails when multiple geographic levels are not acceptable values", {
  data <- data.frame(
    geographic_level = c("Here", "There", "Anywhere")
  )
  expect_equal(precheck_geog_geographic_level(data)$result, "FAIL")
  expect_error(precheck_geog_geographic_level(
    data,
    stop_on_error = TRUE
  ))
})
