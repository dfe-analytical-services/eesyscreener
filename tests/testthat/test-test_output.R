test_that("test_output returns correct data frame when console = FALSE", {
  df <- test_output(
    test_name = "test_name",
    result = "PASS",
    message = "All good!",
    guidance_url = "https://example.com",
    console = FALSE
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
    console = FALSE
  )
  expect_true(is.na(df$guidance_url))
})

test_that("test_output prints correct message for PASS, WARNING, and FAIL", {
  expect_no_error(
    test_output(
      test_name = "test_name",
      result = "PASS",
      message = "All good!",
      console = TRUE
    )
  )
  expect_error(
    test_output(
      test_name = "test_name",
      result = "FAIL",
      message = "This is a failure.",
      console = TRUE
    ),
    regexp = "This is a failure."
  )
  expect_warning(
    test_output(
      test_name = "test_name",
      result = "WARNING",
      message = "This is a warning.",
      console = TRUE
    ),
    regexp = "This is a warning."
  )
})
