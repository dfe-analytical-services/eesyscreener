test_that("passes when all col_name values are present", {
  meta <- data.frame(col_name = c("A", "B", "C"))
  expect_equal(precheck_meta_col_name(meta)$result, "PASS")
  expect_no_error(precheck_meta_col_name(meta, stop_on_error = TRUE))
  expect_no_error(precheck_meta_col_name(example_meta, stop_on_error = TRUE))
})

test_that("fails with one missing col_name", {
  meta <- data.frame(col_name = c("A", NA, "C"))
  expect_equal(precheck_meta_col_name(meta)$result, "FAIL")
  expect_error(precheck_meta_col_name(meta, stop_on_error = TRUE))

  meta2 <- data.frame(col_name = c("A", "", "C"))
  expect_equal(precheck_meta_col_name(meta2)$result, "FAIL")
})

test_that("fails with multiple missing col_name values", {
  meta <- data.frame(col_name = c(NA, "", NA))
  expect_equal(precheck_meta_col_name(meta)$result, "FAIL")
})

test_that("trims whitespace and detects blanks", {
  meta <- data.frame(col_name = c("A", "   ", "C"))
  expect_equal(precheck_meta_col_name(meta)$result, "FAIL")
})

test_that("handles numeric values in col_name", {
  meta <- data.frame(col_name = c("A", 123, "C"))
  expect_equal(precheck_meta_col_name(meta)$result, "PASS")

  meta2 <- data.frame(col_name = c("A", NA, 456))
  expect_equal(precheck_meta_col_name(meta2)$result, "FAIL")

  meta3 <- data.frame(col_name = 1:5)
  expect_equal(precheck_meta_col_name(meta3)$result, "PASS")
})
