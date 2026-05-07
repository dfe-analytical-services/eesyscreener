test_that("passes for valid names file", {
  names_file <- data.frame(file_name = c("a", "b"), dataset_name = c("A", "B"))
  result <- check_zip_names_file_format(names_file)
  expect_equal(result$result, "PASS")
  expect_equal(result$check, "zip_names_file_format")
})

test_that("fails when columns are wrong", {
  names_file <- data.frame(file = "a", name = "A")
  result <- check_zip_names_file_format(names_file)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("columns", result$message))
})

test_that("passes when columns are in reverse order", {
  names_file <- data.frame(dataset_name = "A", file_name = "a")
  result <- check_zip_names_file_format(names_file)
  expect_equal(result$result, "PASS")
})

test_that("fails when names file has an extra column", {
  names_file <- data.frame(
    file_name = "a",
    dataset_name = "A",
    description = "extra"
  )
  result <- check_zip_names_file_format(names_file)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("description", result$message))
})

test_that("fails when only one required column is present", {
  names_file <- data.frame(file_name = "a")
  result <- check_zip_names_file_format(names_file)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("columns", result$message))
})

test_that("fails for empty names file", {
  names_file <- data.frame(
    file_name = character(0),
    dataset_name = character(0)
  )
  result <- check_zip_names_file_format(names_file)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("empty", result$message))
})

test_that("fails when file_name has NAs", {
  names_file <- data.frame(file_name = c("a", NA), dataset_name = c("A", "B"))
  result <- check_zip_names_file_format(names_file)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("NA", result$message))
})

test_that("fails when dataset_name has NAs", {
  names_file <- data.frame(file_name = c("a", "b"), dataset_name = c("A", NA))
  result <- check_zip_names_file_format(names_file)
  expect_equal(result$result, "FAIL")
})

test_that("fails for duplicate file_name values", {
  names_file <- data.frame(file_name = c("a", "a"), dataset_name = c("A", "B"))
  result <- check_zip_names_file_format(names_file)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("duplicate", result$message))
  expect_true(grepl("a", result$message))
})

test_that("returns single-row data frame", {
  names_file <- data.frame(file_name = "a", dataset_name = "A")
  result <- check_zip_names_file_format(names_file)
  expect_true(is.data.frame(result))
  expect_equal(nrow(result), 1)
})

test_that("stop_on_error throws on FAIL", {
  names_file <- data.frame(wrong = "a")
  expect_error(check_zip_names_file_format(names_file, stop_on_error = TRUE))
})
