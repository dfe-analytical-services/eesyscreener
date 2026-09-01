test_that("passes when dataset_names.csv is present", {
  entries <- c("a.csv", "a.meta.csv", "dataset_names.csv")
  result <- check_zip_names_file_presence(entries)
  expect_equal(result$result, "PASS")
  expect_true(grepl("names file is present", result$message))
})

test_that("passes for single pair without names file", {
  entries <- c("a.csv", "a.meta.csv")
  result <- check_zip_names_file_presence(entries)
  expect_equal(result$result, "PASS")
  expect_true(grepl("single data / meta pair", result$message))
})

test_that("fails for two pairs without names file", {
  entries <- c("a.csv", "a.meta.csv", "b.csv", "b.meta.csv")
  result <- check_zip_names_file_presence(entries)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("names file is missing", result$message))
})

test_that("fails for multiple pairs without names file", {
  entries <- c(
    "a.csv",
    "a.meta.csv",
    "b.csv",
    "b.meta.csv",
    "c.csv",
    "c.meta.csv"
  )
  result <- check_zip_names_file_presence(entries)
  expect_equal(result$result, "FAIL")
})

test_that("check name is zip_names_file_presence", {
  result <- check_zip_names_file_presence(c("a.csv", "a.meta.csv"))
  expect_equal(result$check, "zip_names_file_presence")
})

test_that("returns single-row data frame", {
  result <- check_zip_names_file_presence(c("a.csv", "a.meta.csv"))
  expect_true(is.data.frame(result))
  expect_equal(nrow(result), 1)
})

test_that("stop_on_error throws on FAIL", {
  entries <- c("a.csv", "a.meta.csv", "b.csv", "b.meta.csv")
  expect_error(check_zip_names_file_presence(entries, stop_on_error = TRUE))
})
