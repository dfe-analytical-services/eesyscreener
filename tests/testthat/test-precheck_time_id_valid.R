test_that("passes when all time_identifier values are valid", {
  data <- data.frame(time_identifier = acceptable_time_ids)
  expect_equal(precheck_time_id_valid(data, output = "table")$result, "PASS")
  expect_no_error(precheck_time_id_valid(data, output = "error-only"))
  expect_no_error(precheck_time_id_valid(example_data))
})

test_that("fails with one invalid time_identifier", {
  data <- data.frame(time_identifier = c(acceptable_time_ids[1], "InvalidID"))
  expect_equal(precheck_time_id_valid(data, output = "table")$result, "FAIL")
  expect_error(precheck_time_id_valid(data), "'InvalidID'")
})

test_that("fails with multiple invalid time_identifier values", {
  data <- data.frame(
    time_identifier = c("Bad", acceptable_time_ids[1], "Ugly")
  )
  expect_error(precheck_time_id_valid(data), "'Bad', 'Ugly'")
})

test_that("fails with blank time_identifier", {
  data <- data.frame(time_identifier = c(acceptable_time_ids[1], ""))
  expect_error(precheck_time_id_valid(data), "values is blank")
})

test_that("fails multiple blank time_identifier values", {
  data <- data.frame(time_identifier = c("", "", ""))
  expect_error(precheck_time_id_valid(data), "values is blank")
})
