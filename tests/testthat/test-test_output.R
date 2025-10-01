test_that("test_output returns correct data frame when outout = 'table'", {
  df <- test_output(
    test_name = "test_name",
    result = "PASS",
    message = "All good!",
    guidance_url = "https://example.com",
    output = "table"
  )
  expect_s3_class(df, "data.frame")
  expect_equal(nrow(df), 1)
  expect_equal(ncol(df), 4)
  expect_named(df, c("check", "result", "message", "guidance_url"))
  expect_equal(df$check, "test_name")
  expect_equal(df$result, "PASS")
  expect_equal(df$message, "All good!")
  expect_equal(df$guidance_url, "https://example.com")
})

test_that("test_output returns NA for guidance_url by default", {
  df <- test_output(
    test_name = "test_name",
    result = "FAIL",
    message = "Something went wrong.",
    output = "table"
  )
  expect_true(is.na(df$guidance_url))
})

test_that("test_output prints correct message for PASS, WARNING, and FAIL", {
  expect_no_error(
    test_output(
      test_name = "test_name",
      result = "PASS",
      message = "All good!",
      output = "console"
    )
  )
  expect_no_error(
    test_output(
      test_name = "test_name",
      result = "PASS",
      message = "All good!",
      output = "error-only"
    )
  )
  expect_error(
    test_output(
      test_name = "test_name",
      result = "FAIL",
      message = "This is a failure.",
      output = "console"
    ),
    regexp = "This is a failure."
  )
  expect_error(
    test_output(
      test_name = "test_name",
      result = "FAIL",
      message = "This is a failure.",
      output = "error-only"
    ),
    regexp = "This is a failure."
  )
  expect_warning(
    test_output(
      test_name = "test_name",
      result = "WARNING",
      message = "This is a warning.",
      output = "console"
    ),
    regexp = "This is a warning."
  )
  expect_warning(
    test_output(
      test_name = "test_name",
      result = "WARNING",
      message = "This is a warning.",
      output = "error-only"
    ),
    regexp = "This is a warning."
  )
})
