test_that("files are data frames", {
  expect_true(is.data.frame(eesyscreener::example_data))
  expect_true(is.data.frame(eesyscreener::example_data.meta))
})

test_that("rows and cols match description", {
  # This test is more of a reminder when updating the data set, if these change
  # then we need to update the description in R/example_data.R
  expect_equal(nrow(eesyscreener::example_data), 9)
  expect_equal(ncol(eesyscreener::example_data), 8)
  expect_equal(nrow(eesyscreener::example_data.meta), 3)
  expect_equal(ncol(eesyscreener::example_data.meta), 8)
})

test_that("There are no duplicate rows", {
  expect_true(!anyDuplicated(eesyscreener::example_data))
  expect_true(!anyDuplicated(eesyscreener::example_data.meta))
})
