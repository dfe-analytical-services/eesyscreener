test_data <- data.frame(one = c(1, 2), two = c(NA, NA))

data_check <- check_empty_cols(test_data, "file.csv")

test_that("fails as expected", {
  expect_equal(data_check$result, "FAIL")
})

test_that("returns the right format", {
  expect_type(data_check, "list")
  expect_length(data_check, 3)
  expect_equal(
    names(data_check),
    c("check", "result", "message")
  )
})

test_that("copes with no filename", {
  expect_equal(
    check_empty_cols(test_data)$result,
    "FAIL"
  )
})
