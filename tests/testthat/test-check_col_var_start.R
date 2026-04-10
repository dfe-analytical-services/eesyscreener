test_that("passes when all variable names start with a lowercase letter", {
  data <- data.frame(abc = 1, def_ghi = 2, x1 = 3)
  expect_equal(check_col_var_start(data)$result, "PASS")
  expect_no_error(check_col_var_start(data, stop_on_error = TRUE))
  expect_no_error(check_col_var_start(example_data, stop_on_error = TRUE))
})

test_that("warns with one variable name not starting with a lowercase letter", {
  data <- data.frame(ABC = 1, def = 2)
  result <- check_col_var_start(data)
  expect_equal(result$result, "WARNING")
  expect_true(grepl("ABC", result$message))
  expect_warning(check_col_var_start(data, stop_on_error = TRUE))
})

test_that("warns with multiple variable names not starting with lowercase", {
  data <- data.frame(ABC = 1, `_bad` = 2, good = 3, check.names = FALSE)
  result <- check_col_var_start(data)
  expect_equal(result$result, "WARNING")
  expect_true(grepl("ABC", result$message))
  expect_warning(check_col_var_start(data, stop_on_error = TRUE))
})

test_that("warns when variable starts with a number", {
  data <- data.frame(good = 1, check.names = FALSE)
  names(data)[1] <- "1bad"
  result <- check_col_var_start(data)
  expect_equal(result$result, "WARNING")
  expect_true(grepl("1bad", result$message))
})

test_that("warns when variable starts with an underscore", {
  data <- data.frame(good = 1)
  names(data)[1] <- "_bad"
  result <- check_col_var_start(data)
  expect_equal(result$result, "WARNING")
})
