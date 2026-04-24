test_that("passes for valid manifest", {
  manifest <- data.frame(file_name = c("a", "b"), dataset_name = c("A", "B"))
  result <- check_zip_manifest_format(manifest)
  expect_equal(result$result, "PASS")
  expect_equal(result$check, "zip_manifest_format")
})

test_that("fails when columns are wrong", {
  manifest <- data.frame(file = "a", name = "A")
  result <- check_zip_manifest_format(manifest)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("columns", result$message))
})

test_that("fails when columns are in wrong order", {
  manifest <- data.frame(dataset_name = "A", file_name = "a")
  result <- check_zip_manifest_format(manifest)
  expect_equal(result$result, "FAIL")
})

test_that("fails for empty manifest", {
  manifest <- data.frame(file_name = character(0), dataset_name = character(0))
  result <- check_zip_manifest_format(manifest)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("empty", result$message))
})

test_that("fails when file_name has NAs", {
  manifest <- data.frame(file_name = c("a", NA), dataset_name = c("A", "B"))
  result <- check_zip_manifest_format(manifest)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("NA", result$message))
})

test_that("fails when dataset_name has NAs", {
  manifest <- data.frame(file_name = c("a", "b"), dataset_name = c("A", NA))
  result <- check_zip_manifest_format(manifest)
  expect_equal(result$result, "FAIL")
})

test_that("fails for duplicate file_name values", {
  manifest <- data.frame(file_name = c("a", "a"), dataset_name = c("A", "B"))
  result <- check_zip_manifest_format(manifest)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("duplicate", result$message))
  expect_true(grepl("a", result$message))
})

test_that("returns single-row data frame", {
  manifest <- data.frame(file_name = "a", dataset_name = "A")
  result <- check_zip_manifest_format(manifest)
  expect_true(is.data.frame(result))
  expect_equal(nrow(result), 1)
})

test_that("stop_on_error throws on FAIL", {
  manifest <- data.frame(wrong = "a")
  expect_error(check_zip_manifest_format(manifest, stop_on_error = TRUE))
})
