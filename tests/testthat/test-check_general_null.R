test_that("passes with clean example data", {
  result <- check_general_null(example_data, example_meta)
  expect_equal(result$result, "PASS")
})

test_that("fails with one null symbol in data", {
  bad_data <- example_data |>
    dplyr::mutate(sex = dplyr::if_else(.data$sex == "Male", "NULL", .data$sex))
  result <- check_general_null(bad_data, example_meta)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("null or NA symbols", result$message))
  expect_true(grepl("symbols checked for are", result$message))
  expect_true(grepl("data file", result$message))
  expect_false(is.na(result$guidance_url))
})

test_that("fails with multiple null symbols in data", {
  bad_data <- example_data |>
    dplyr::mutate(
      sex = dplyr::if_else(.data$sex == "Male", "NULL", .data$sex),
      education_phase = dplyr::if_else(
        .data$education_phase == "Primary",
        "NA",
        .data$education_phase
      )
    )
  result <- check_general_null(bad_data, example_meta)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("symbols were", result$message))
  expect_true(grepl("data file", result$message))
})

test_that("fails with null symbol in meta only", {
  bad_meta <- example_meta |>
    dplyr::mutate(
      label = dplyr::if_else(.data$label == "Sex of pupil", "null", .data$label)
    )
  result <- check_general_null(example_data, bad_meta)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("'null'", result$message))
  expect_true(grepl("metadata file", result$message))
  expect_false(grepl("in the data file", result$message))
})

test_that("fails with null symbols in both data and meta", {
  bad_data <- example_data |>
    dplyr::mutate(sex = dplyr::if_else(.data$sex == "Male", "NA", .data$sex))
  bad_meta <- example_meta |>
    dplyr::mutate(
      label = dplyr::if_else(.data$label == "Sex of pupil", "null", .data$label)
    )
  result <- check_general_null(bad_data, bad_meta)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("data file", result$message))
  expect_true(grepl("metadata file", result$message))
})

test_that("warns with one legacy no-data symbol in data", {
  bad_data <- example_data |>
    dplyr::mutate(sex = dplyr::if_else(.data$sex == "Male", "N/A", .data$sex))
  result <- check_general_null(bad_data, example_meta)
  expect_equal(result$result, "WARNING")
  expect_true(grepl("Legacy no-data symbols", result$message))
  expect_true(grepl("symbols checked for are", result$message))
  expect_true(grepl("data file", result$message))
  expect_false(is.na(result$guidance_url))
})

test_that("warns with multiple legacy symbols in data", {
  bad_data <- example_data |>
    dplyr::mutate(
      sex = dplyr::if_else(.data$sex == "Male", "N/A", .data$sex),
      education_phase = dplyr::if_else(
        .data$education_phase == "Primary",
        ".",
        .data$education_phase
      )
    )
  result <- check_general_null(bad_data, example_meta)
  expect_equal(result$result, "WARNING")
  expect_true(grepl("symbols were", result$message))
})

test_that("null symbol in data takes priority over legacy symbol", {
  bad_data <- example_data |>
    dplyr::mutate(
      sex = dplyr::if_else(.data$sex == "Male", "NULL", .data$sex),
      education_phase = dplyr::if_else(
        .data$education_phase == "Primary",
        "N/A",
        .data$education_phase
      )
    )
  result <- check_general_null(bad_data, example_meta)
  expect_equal(result$result, "FAIL")
})

test_that("passes with numeric column containing no null string literals", {
  # Numeric columns are coerced to character before comparison; values like
  # 1000 must not match "NA" or any other null_symbol string literal
  result <- check_general_null(example_data, example_meta)
  expect_equal(result$result, "PASS")
  expect_true(is.numeric(example_data$enrolment_count))
})

test_that("legacy symbols in meta do not trigger a warning", {
  # Legacy no-data symbols are only checked in data, not meta
  bad_meta <- example_meta |>
    dplyr::mutate(
      label = dplyr::if_else(.data$label == "Sex of pupil", "N/A", .data$label)
    )
  result <- check_general_null(example_data, bad_meta)
  expect_equal(result$result, "PASS")
})
