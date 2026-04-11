test_that("passes when all variable names start with a lowercase letter", {
  expect_equal(check_col_var_start(example_data)$result, "PASS")
  expect_no_error(check_col_var_start(example_data, stop_on_error = TRUE))
})

test_that("warns with one variable name not starting with a lowercase letter", {
  bad_data <- example_data
  names(bad_data)[1] <- "Bad_name"
  result <- check_col_var_start(bad_data)
  expect_equal(result$result, "WARNING")
  expect_true(grepl("Bad_name", result$message))
  expect_true(grepl("variable name starts", result$message))
  expect_warning(check_col_var_start(bad_data, stop_on_error = TRUE))
})

test_that("warns with multiple variable names not starting with lowercase", {
  bad_data <- example_data
  names(bad_data)[1] <- "Bad_name"
  names(bad_data)[2] <- "Also_bad"
  result <- check_col_var_start(bad_data)
  expect_equal(result$result, "WARNING")
  expect_true(grepl("Bad_name", result$message))
  expect_true(grepl("Also_bad", result$message))
  expect_true(grepl("variable names start", result$message))
  expect_warning(check_col_var_start(bad_data, stop_on_error = TRUE))
})

test_that("warns when variable starts with a number", {
  bad_data <- example_data
  names(bad_data)[1] <- "1bad"
  result <- check_col_var_start(bad_data)
  expect_equal(result$result, "WARNING")
  expect_true(grepl("1bad", result$message))
})

test_that("warns when variable starts with an underscore", {
  bad_data <- example_data
  names(bad_data)[1] <- "_bad"
  result <- check_col_var_start(bad_data)
  expect_equal(result$result, "WARNING")
  expect_true(grepl("_bad", result$message))
})
