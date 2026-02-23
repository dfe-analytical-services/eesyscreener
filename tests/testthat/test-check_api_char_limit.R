test_that("passes when all values are within the limit", {
  result <- api_char_limit(names(example_data), "column-name")
  expect_equal(result$result, "PASS")

  expect_no_error(
    api_char_limit(
      example_data$education_phase,
      "column-item",
      stop_on_error = TRUE
    )
  )
})

test_that("warns when some values exceed the limit", {
  result <- api_char_limit(names(example_api_long), "column-name")
  expect_equal(result$result, "WARNING")

  expect_warning(
    api_char_limit(
      names(example_api_long),
      "column-name",
      stop_on_error = TRUE
    ),
    "exceed the character limit"
  )

  values <- c("A", paste(rep("x", 65), paste(rep("y", 65)), collapse = ""))
  type <- "column-name"
  result <- api_char_limit(values, type)
  expect_warning(
    api_char_limit(values, type, stop_on_error = TRUE),
    "exceed the character limit"
  )
})

test_that("errors for invalid type", {
  values <- c("A", "B")
  type <- "not-a-type"
  expect_error(api_char_limit(values, type))
})

test_that("errors for non-character input", {
  values <- c(1, 2, 3)
  type <- "column-name"
  expect_error(api_char_limit(values, type))
})


test_that("passes for example data", {
  expect_equal(
    check_api_char_col_name(
      example_data
    )$result,
    "PASS"
  )
  expect_equal(
    check_api_char_col_label(
      example_meta
    )$result,
    "PASS"
  )
  expect_equal(
    check_api_char_loc_code(
      example_data
    )$result,
    "PASS"
  )
  expect_equal(
    check_api_char_filter_items(
      example_data,
      example_meta
    )$result,
    "PASS"
  )
})

test_that("fails when column names exceed the limit", {
  expect_warning(
    check_api_char_col_name(
      example_api_long,
      stop_on_error = TRUE
    ),
    "exceed the character limit"
  )
  expect_warning(
    check_api_char_col_label(
      example_api_long_meta,
      stop_on_error = TRUE
    ),
    "exceed the character limit"
  )
  expect_warning(
    check_api_char_loc_code(
      example_data |>
        dplyr::mutate(country_code = paste(rep("E88", 20), collapse = "")),
      stop_on_error = TRUE
    ),
    "exceed the character limit"
  )
  expect_warning(
    check_api_char_filter_items(
      example_data |>
        dplyr::mutate(
          education_phase = paste("Phase ", seq_len(20), collapse = "")
        ),
      example_meta,
      stop_on_error = TRUE
    ),
    "exceed the character limit"
  )
})
