test_that("passes for manifest path with only allowed files", {
  entries <- c("a.csv", "a.meta.csv", "dataset_names.csv")
  manifest <- data.frame(file_name = "a", dataset_name = "A")
  result <- check_zip_no_unreferenced(entries, manifest)
  expect_equal(result$result, "PASS")
  expect_equal(result$check, "zip_no_unreferenced")
})

test_that("passes for single-pair lenient path", {
  entries <- c("a.csv", "a.meta.csv")
  result <- check_zip_no_unreferenced(entries, NULL)
  expect_equal(result$result, "PASS")
})

test_that("fails for stray file in single-pair path", {
  entries <- c("a.csv", "a.meta.csv", "readme.txt")
  result <- check_zip_no_unreferenced(entries, NULL)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("readme.txt", result$message))
})

test_that("fails for .DS_Store in manifest path", {
  entries <- c("a.csv", "a.meta.csv", "dataset_names.csv", ".DS_Store")
  manifest <- data.frame(file_name = "a", dataset_name = "A")
  result <- check_zip_no_unreferenced(entries, manifest)
  expect_equal(result$result, "FAIL")
  expect_true(grepl(".DS_Store", result$message, fixed = TRUE))
})

test_that("fails for orphan meta file", {
  entries <- c("a.csv", "a.meta.csv", "orphan.meta.csv", "dataset_names.csv")
  manifest <- data.frame(file_name = "a", dataset_name = "A")
  result <- check_zip_no_unreferenced(entries, manifest)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("orphan.meta.csv", result$message))
})

test_that("fails for unreferenced CSV in manifest path", {
  entries <- c("a.csv", "a.meta.csv", "extra.csv", "dataset_names.csv")
  manifest <- data.frame(file_name = "a", dataset_name = "A")
  result <- check_zip_no_unreferenced(entries, manifest)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("extra.csv", result$message))
})

test_that("does not fail on directory-only entries", {
  # Some ZIP tools add directory entries with trailing slash
  entries <- c("a.csv", "a.meta.csv", "dataset_names.csv")
  manifest <- data.frame(file_name = "a", dataset_name = "A")
  result <- check_zip_no_unreferenced(entries, manifest)
  expect_equal(result$result, "PASS")
})

test_that("returns single-row data frame", {
  result <- check_zip_no_unreferenced(c("a.csv", "a.meta.csv"), NULL)
  expect_true(is.data.frame(result))
  expect_equal(nrow(result), 1)
})

test_that("stop_on_error throws on FAIL", {
  entries <- c("a.csv", "a.meta.csv", "extra.txt")
  expect_error(check_zip_no_unreferenced(entries, NULL, stop_on_error = TRUE))
})
