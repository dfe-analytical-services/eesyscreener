test_that("passes when six-digit time_period values are consecutive years", {
  data <- data.frame(
    time_period = c("202122", "202324")
  )
  expect_equal(check_time_period_six(data)$result, "PASS")
  expect_no_error(check_time_period_six(data, stop_on_error = TRUE))
})

test_that("fails when a six-digit time_period value is not consecutive years", {
  data <- data.frame(
    time_period = c("202120", "202122")
  )
  expect_equal(check_time_period_six(data)$result, "FAIL")
  expect_error(
    check_time_period_six(data, stop_on_error = TRUE),
    "must be consecutive"
  )
})

test_that("passes for 199900 (century edge case)", {
  data <- data.frame(
    time_period = c("199900")
  )
  expect_equal(check_time_period_six(data)$result, "PASS")
})

test_that("PASSes when there are no six-digit time_period values", {
  data <- data.frame(
    time_period = c("2020", "2021")
  )
  expect_equal(check_time_period_six(data)$result, "PASS")
})

test_that("fails with NA six-digit time_period value", {
  data <- data.frame(
    time_period = c("202122", NA)
  )
  expect_equal(check_time_period_six(data)$result, "FAIL")
  expect_error(
    check_time_period_six(data, stop_on_error = TRUE),
    "NA values found"
  )
})

test_that("passes with a single valid six-digit time_period value", {
  data <- data.frame(
    time_period = "202122"
  )
  expect_equal(check_time_period_six(data)$result, "PASS")
})
