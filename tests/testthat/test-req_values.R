test_that("output format is as expected", {
  expect_type(req_meta_cols, "character")
  expect_gt(length(req_meta_cols), 1)
  expect_type(optional_meta_cols, "character")
})
