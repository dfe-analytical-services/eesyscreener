test_that("passes when all values are within the limit", {
  result <- check_api_char_limit(names(example_data), "column-name")
  expect_equal(result$result, "PASS")

  expect_no_error(
    check_api_char_limit(
      example_data$education_phase,
      "column-item",
      stop_on_error = TRUE
    )
  )
})

test_that("warns when some values exceed the limit", {
  result <- check_api_char_limit(names(example_api_long), "column-name")
  expect_equal(result$result, "WARNING")

  expect_warning(
    check_api_char_limit(
      names(example_api_long),
      "column-name",
      stop_on_error = TRUE
    ),
    "exceed the character limit"
  )

  values <- c("A", paste(rep("x", 65), paste(rep("y", 65)), collapse = ""))
  type <- "column-name"
  result <- check_api_char_limit(values, type)
  expect_warning(
    check_api_char_limit(values, type, stop_on_error = TRUE),
    "exceed the character limit"
  )
})

test_that("errors for invalid type", {
  values <- c("A", "B")
  type <- "not-a-type"
  expect_error(check_api_char_limit(values, type))
})

test_that("errors for non-character input", {
  values <- c(1, 2, 3)
  type <- "column-name"
  expect_error(check_api_char_limit(values, type))
})
