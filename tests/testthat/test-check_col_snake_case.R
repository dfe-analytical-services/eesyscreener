test_that("passes with valid snake_case column names", {
  result <- check_col_snake_case(example_data)

  expect_equal(result$result, "PASS")
  expect_equal(
    result$message,
    "The variable names in the data file follow the snake_case convention."
  )
  expect_no_error(check_col_snake_case(example_data, stop_on_error = TRUE))
})

test_that("warns with one capital letter in column names", {
  data_with_caps <- example_data
  names(data_with_caps)[1] <- "Time_period"

  result <- check_col_snake_case(data_with_caps)

  expect_equal(result$result, "WARNING")
  expect_true(grepl(
    "The following invalid character was found in the variable names of the data file: 'T'",
    result$message
  ))
  expect_warning(
    check_col_snake_case(data_with_caps, stop_on_error = TRUE)
  )
})

test_that("warns with special characters in column names", {
  data_with_specials <- example_data
  names(data_with_specials)[2] <- "gene-name"

  result <- check_col_snake_case(data_with_specials)

  expect_equal(result$result, "WARNING")
  expect_true(grepl(
    "The following invalid character was found in the variable names of the data file: '-'",
    result$message
  ))
})

test_that("warns with multiple invalid characters in column names", {
  data_with_issues <- example_data
  names(data_with_issues)[1] <- "SampleID"
  names(data_with_issues)[2] <- "gene$name"

  result <- check_col_snake_case(data_with_issues)

  expect_equal(result$result, "WARNING")
  expect_true(grepl(
    "The following invalid characters were found in the variable names of the data file:",
    result$message
  ))
  expect_warning(
    check_col_snake_case(data_with_issues, stop_on_error = TRUE)
  )
})
