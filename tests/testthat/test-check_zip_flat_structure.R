test_that("passes for flat file list", {
  result <- check_zip_flat_structure(c("data.csv", "data.meta.csv"))
  expect_equal(result$result, "PASS")
  expect_equal(result$check, "zip_flat_structure")
})

test_that("fails for nested file", {
  result <- check_zip_flat_structure(c("data.csv", "subdir/data.meta.csv"))
  expect_equal(result$result, "FAIL")
  expect_true(grepl("subdir/data.meta.csv", result$message, fixed = TRUE))
})

test_that("fails for OS junk nested file", {
  result <- check_zip_flat_structure(c("data.csv", "data.meta.csv", "__MACOSX/._data.csv"))
  expect_equal(result$result, "FAIL")
  expect_true(grepl("__MACOSX", result$message))
})

test_that("does not fail for directory entries at root level", {
  result <- check_zip_flat_structure(c("data.csv", "data.meta.csv"))
  expect_equal(result$result, "PASS")
})

test_that("fails for multiple nested files and lists them all", {
  result <- check_zip_flat_structure(c("a/b.csv", "c/d.meta.csv"))
  expect_equal(result$result, "FAIL")
  expect_true(grepl("a/b.csv", result$message, fixed = TRUE))
  expect_true(grepl("c/d.meta.csv", result$message, fixed = TRUE))
})

test_that("returns single-row data frame", {
  result <- check_zip_flat_structure(c("a.csv", "a.meta.csv"))
  expect_true(is.data.frame(result))
  expect_equal(nrow(result), 1)
})

test_that("stop_on_error throws on FAIL", {
  expect_error(
    check_zip_flat_structure(c("sub/a.csv"), stop_on_error = TRUE)
  )
})
