test_that("passes for a valid readable ZIP", {
  skip_integration_tests()
  tmp <- tempfile(fileext = ".zip")
  on.exit(unlink(tmp))
  zip::zip(tmp, character(0))
  result <- check_zip_readable(tmp)
  expect_equal(result$result, "PASS")
  expect_true(grepl("readable", result$message, ignore.case = TRUE))
})

test_that("fails for a non-existent path", {
  result <- check_zip_readable("does_not_exist.zip")
  expect_equal(result$result, "FAIL")
  expect_true(grepl("No file found", result$message))
})

test_that("fails for a file without .zip extension", {
  tmp <- tempfile(fileext = ".txt")
  on.exit(unlink(tmp))
  writeLines("not a zip", tmp)
  result <- check_zip_readable(tmp)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("\\.zip extension", result$message))
})

test_that("fails for a corrupt ZIP file", {
  skip_integration_tests()
  tmp <- tempfile(fileext = ".zip")
  on.exit(unlink(tmp))
  writeBin(as.raw(c(0x50, 0x4B, 0x00, 0x00)), tmp)
  result <- check_zip_readable(tmp)
  expect_equal(result$result, "FAIL")
})

test_that("returns single-row data frame", {
  skip_integration_tests()
  tmp <- tempfile(fileext = ".zip")
  on.exit(unlink(tmp))
  zip::zip(tmp, character(0))
  result <- check_zip_readable(tmp)
  expect_true(is.data.frame(result))
  expect_equal(nrow(result), 1)
  expect_true(all(
    c("check", "result", "message", "guidance_url") %in% names(result)
  ))
})

test_that("check name is zip_readable", {
  skip_integration_tests()
  tmp <- tempfile(fileext = ".zip")
  on.exit(unlink(tmp))
  zip::zip(tmp, character(0))
  result <- check_zip_readable(tmp)
  expect_equal(result$check, "zip_readable")
})

test_that("stop_on_error throws on FAIL", {
  expect_error(check_zip_readable("does_not_exist.zip", stop_on_error = TRUE))
})

test_that("no error with stop_on_error on PASS", {
  skip_integration_tests()
  tmp <- tempfile(fileext = ".zip")
  on.exit(unlink(tmp))
  zip::zip(tmp, character(0))
  expect_no_error(check_zip_readable(tmp, stop_on_error = TRUE))
})
