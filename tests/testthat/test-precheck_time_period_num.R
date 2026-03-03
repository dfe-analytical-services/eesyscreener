test_that("passes when all time_period values are numeric", {
  data <- data.frame(time_period = c("2020", "2021", "2022"))
  expect_equal(precheck_time_period_num(data)$result, "PASS")
  expect_no_error(precheck_time_period_num(data, stop_on_error = TRUE))
})

test_that("fails with one non-numeric time_period value", {
  data <- data.frame(time_period = c("2020", "abcd"))
  expect_equal(precheck_time_period_num(data)$result, "FAIL")
  expect_error(
    precheck_time_period_num(data, stop_on_error = TRUE),
    "The following invalid time_period value"
  )
})

test_that("fails with multiple non-numeric time_period values", {
  data <- data.frame(time_period = c("2020", "abcd", "xyz"))
  expect_equal(precheck_time_period_num(data)$result, "FAIL")
  expect_error(
    precheck_time_period_num(data, stop_on_error = TRUE),
    "The following invalid time_period values"
  )
})

test_that("fails with blank time_period value", {
  data <- data.frame(time_period = c("2020", ""))
  expect_equal(precheck_time_period_num(data)$result, "FAIL")
  expect_error(
    precheck_time_period_num(data, stop_on_error = TRUE),
    "The following invalid time_period value"
  )
})

test_that("handles NA time_period values", {
  data <- data.frame(time_period = c(NA, "2020"))
  expect_equal(precheck_time_period_num(data)$result, "FAIL")
  expect_error(
    precheck_time_period_num(data, stop_on_error = TRUE),
    "The following invalid time_period value"
  )
})
