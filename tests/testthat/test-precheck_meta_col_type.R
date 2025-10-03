test_that("passes when all valid", {
  expect_no_error(precheck_meta_col_type(example_meta, output = "error-only"))

  meta <- data.frame(
    col_type = c("Filter", "Indicator", "Filter"),
    stringsAsFactors = FALSE
  )
  expect_equal(precheck_meta_col_type(meta, output = "table")$result, "PASS")
})

test_that("fails with one invalid value", {
  meta <- data.frame(
    col_type = c("Filter", "Indicator", "BadType"),
    stringsAsFactors = FALSE
  )
  expect_equal(precheck_meta_col_type(meta, output = "table")$result, "FAIL")
  expect_error(precheck_meta_col_type(meta))
})

test_that("fails with multiple invalid values", {
  meta <- data.frame(
    col_type = c("Filter", "Wrong", "Indicator", "Other"),
    stringsAsFactors = FALSE
  )
  expect_equal(precheck_meta_col_type(meta, output = "table")$result, "FAIL")
})

test_that("fails with blank col_type", {
  meta <- data.frame(
    col_type = c("Filter", "", "Indicator"),
    stringsAsFactors = FALSE
  )
  expect_equal(precheck_meta_col_type(meta, output = "table")$result, "FAIL")
})
