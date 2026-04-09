test_that("passes when time_period values are 4 digits for 4-digit id", {
  data <- data.frame(
    time_identifier = rep(four_digit_identifiers[1], 3),
    time_period = c("2020", "2021", "2022")
  )
  expect_equal(check_time_period(data)$result, "PASS")
  expect_no_error(check_time_period(data, stop_on_error = TRUE))
})

test_that("fails when time_period value is not 4 digits for 4-digit id", {
  data <- data.frame(
    time_identifier = rep(four_digit_identifiers[1], 2),
    time_period = c("2020", "202112")
  )
  expect_equal(check_time_period(data)$result, "FAIL")
  expect_error(
    check_time_period(data, stop_on_error = TRUE),
    "must always be a four digit number"
  )
})

test_that("passes when time_period values are 6 digits for 6-digit id", {
  data <- data.frame(
    time_identifier = rep(six_digit_identifiers[1], 2),
    time_period = c("202122", "202324")
  )
  expect_equal(check_time_period(data)$result, "PASS")
  expect_no_error(check_time_period(data, stop_on_error = TRUE))
})

test_that("fails when time_period value is not 6 digits for 6-digit id", {
  data <- data.frame(
    time_identifier = rep(six_digit_identifiers[1], 2),
    time_period = c("202122", "2021")
  )
  expect_equal(check_time_period(data)$result, "FAIL")
  expect_error(
    check_time_period(data, stop_on_error = TRUE),
    "must always be a six digit number"
  )
})

test_that("fails with NA time_period value", {
  data <- data.frame(
    time_identifier = rep(four_digit_identifiers[1], 2),
    time_period = c("2020", NA)
  )
  expect_equal(check_time_period(data)$result, "FAIL")
  expect_error(
    check_time_period(data, stop_on_error = TRUE),
    "must always be a four digit number"
  )
})

test_that("passes with a single valid time_period value", {
  data <- data.frame(
    time_identifier = four_digit_identifiers[1],
    time_period = "2020"
  )
  expect_equal(check_time_period(data)$result, "PASS")
})
