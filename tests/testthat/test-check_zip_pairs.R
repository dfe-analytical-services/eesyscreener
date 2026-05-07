test_that("passes when all pairs are present and listed", {
  entries <- c(
    "a.csv",
    "a.meta.csv",
    "b.csv",
    "b.meta.csv",
    "dataset_names.csv"
  )
  names_file <- data.frame(file_name = c("a", "b"), dataset_name = c("A", "B"))
  result <- check_zip_pairs(entries, names_file)
  expect_equal(result$result, "PASS")
  expect_equal(result$check, "zip_pairs")
})

test_that("fails when names file references a missing data file", {
  entries <- c("a.csv", "a.meta.csv", "dataset_names.csv")
  names_file <- data.frame(file_name = c("a", "b"), dataset_name = c("A", "B"))
  result <- check_zip_pairs(entries, names_file)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("b.csv", result$message))
})

test_that("fails when names file references a missing meta file", {
  entries <- c("a.csv", "a.meta.csv", "b.csv", "dataset_names.csv")
  names_file <- data.frame(file_name = c("a", "b"), dataset_name = c("A", "B"))
  result <- check_zip_pairs(entries, names_file)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("b.meta.csv", result$message))
})

test_that("fails when data file is not listed in names file", {
  entries <- c(
    "a.csv",
    "a.meta.csv",
    "b.csv",
    "b.meta.csv",
    "dataset_names.csv"
  )
  names_file <- data.frame(file_name = "a", dataset_name = "A")
  result <- check_zip_pairs(entries, names_file)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("b.csv", result$message))
  expect_true(grepl("not listed", result$message))
})

test_that("orphan meta files are not detected here (handled elsewhere)", {
  # check_zip_no_unreferenced is responsible for orphan meta detection in
  # the names-file path; check_zip_pairs only verifies stems listed in the
  # names file have both halves and that data files are listed.
  entries <- c("a.csv", "a.meta.csv", "orphan.meta.csv", "dataset_names.csv")
  names_file <- data.frame(file_name = "a", dataset_name = "A")
  result <- check_zip_pairs(entries, names_file)
  expect_equal(result$result, "PASS")
})

test_that("lenient mode passes for matched single pair", {
  result <- check_zip_pairs(c("a.csv", "a.meta.csv"), NULL)
  expect_equal(result$result, "PASS")
})

test_that("lenient mode fails when data file has no matching meta", {
  result <- check_zip_pairs(c("a.csv", "b.meta.csv"), NULL)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("a.meta.csv", result$message, fixed = TRUE))
  expect_true(grepl("b.csv", result$message, fixed = TRUE))
})

test_that("lenient mode fails more than one pair", {
  result <- check_zip_pairs(
    c("a.csv", "a.meta.csv", "b.csv", "b.meta.csv"),
    NULL
  )
  expect_equal(result$result, "FAIL")
})

test_that("lenient mode fails for orphan meta with no data file", {
  result <- check_zip_pairs(
    c("a.csv", "a.meta.csv", "orphan.meta.csv"),
    NULL
  )
  expect_equal(result$result, "FAIL")
  expect_true(grepl("orphan.csv", result$message, fixed = TRUE))
})

test_that("lenient mode fails for data file with no meta", {
  result <- check_zip_pairs(c("a.csv", "a.meta.csv", "extra.csv"), NULL)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("extra.meta.csv", result$message, fixed = TRUE))
})

test_that("returns single-row data frame", {
  entries <- c("a.csv", "a.meta.csv", "dataset_names.csv")
  names_file <- data.frame(file_name = "a", dataset_name = "A")
  result <- check_zip_pairs(entries, names_file)
  expect_true(is.data.frame(result))
  expect_equal(nrow(result), 1)
})

test_that("stop_on_error throws on FAIL", {
  entries <- c("a.csv", "a.meta.csv", "dataset_names.csv")
  names_file <- data.frame(
    file_name = c("a", "missing"),
    dataset_name = c("A", "M")
  )
  expect_error(check_zip_pairs(entries, names_file, stop_on_error = TRUE))
})
