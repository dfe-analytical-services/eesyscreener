test_that("passes when all required columns are present", {
  expect_no_error(precheck_col_req_meta(example_meta, stop_on_error = TRUE))
})

test_that("errors when required columns are missing", {
  expect_error(precheck_col_req_meta(example_meta[, -1], stop_on_error = TRUE))
  expect_error(precheck_col_req_meta(
    example_meta[, -c(1, 2)],
    stop_on_error = TRUE
  ))
})
