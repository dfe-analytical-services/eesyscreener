test_that("passes when data has more non-mandatory columns than meta rows", {
  data <- data.frame(matrix(1, nrow = 2, ncol = 10))
  meta <- data.frame(col_name = letters[1:3])
  expect_equal(
    precheck_col_to_rows(data, meta, output = "table")$result,
    "PASS"
  )
  expect_no_error(precheck_col_to_rows(data, meta, output = "error-only"))
  expect_no_error(precheck_col_to_rows(example_data, example_meta))
})

test_that("passes when data has equal non-mandatory columns and meta rows", {
  data <- data.frame(matrix(1, nrow = 2, ncol = 8))
  meta <- data.frame(col_name = letters[1:3])
  expect_equal(
    precheck_col_to_rows(data, meta, output = "table")$result,
    "PASS"
  )
})

test_that("fails when meta has more rows than data has non-mandatory columns", {
  data <- data.frame(matrix(1, nrow = 2, ncol = 7))
  meta <- data.frame(col_name = letters[1:3])
  expect_equal(
    precheck_col_to_rows(data, meta, output = "table")$result,
    "FAIL"
  )
  expect_error(precheck_col_to_rows(data, meta))
})
