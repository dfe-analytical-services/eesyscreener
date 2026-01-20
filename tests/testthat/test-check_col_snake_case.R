# test the function check_col_snake_case passes when all column names are in snake_case
test_that("check_col_snake_case passes with valid snake_case column names", {
  result <- check_col_snake_case(
    example_data,
    verbose = FALSE,
    stop_on_error = FALSE
  )

  expect_equal(result$result, "PASS")
  expect_equal(
    result$message,
    "The variable names in the data file follow the snake_case convention."
  )
})

#test the function check_col_snake_case gives an advisory when there are capital letters in column names
test_that("check_col_snake_case gives advisory with capital letters in column names", {
  data_with_caps <- example_data
  names(data_with_caps)[1] <- "SampleID"

  result <- check_col_snake_case(
    data_with_caps,
    verbose = FALSE,
    stop_on_error = FALSE
  )

  expect_equal(result$result, "ADVISORY")
  expect_true(grepl(
    "The following invalid characters were found in the variable names of the data file: 'S'",
    result$message
  ))
})

#test the function check_col_snake_case gives an advisory when there are special characters in column names
test_that("check_col_snake_case gives advisory with special characters in column names", {
  data_with_specials <- example_data
  names(data_with_specials)[2] <- "gene-name"

  result <- check_col_snake_case(
    data_with_specials,
    verbose = FALSE,
    stop_on_error = FALSE
  )

  expect_equal(result$result, "ADVISORY")
  expect_true(grepl(
    "The following invalid characters were found in the variable names of the data file: '-'",
    result$message
  ))
})

#test the function check_col_snake_case gives an advisory when there are both capital letters and special characters in column names
test_that("check_col_snake_case gives advisory with both capital letters and special characters in column names", {
  data_with_issues <- example_data
  names(data_with_issues)[1] <- "SampleID"
  names(data_with_issues)[2] <- "gene$name"

  result <- check_col_snake_case(
    data_with_issues,
    verbose = FALSE,
    stop_on_error = FALSE
  )

  expect_equal(result$result, "ADVISORY")
  expect_true(grepl(
    "The following invalid characters were found in the variable names of the data file: 'S', ''I', ''D', ''$'. <br> - Variable names should follow the snake_case convention and only contain lowercase letters, underscores or numbers.",
    result$message
  ))
})
