test_that("files are data frames", {
  expect_true(is.data.frame(example_data))
  expect_true(is.data.frame(example_meta))
})

test_that("rows and cols match description", {
  # This test is more of a reminder when updating the data set, if these change
  # then we need to update the description in R/example_data.R
  expect_equal(nrow(example_data), 9)
  expect_equal(ncol(example_data), 8)
  expect_equal(nrow(example_meta), 3)
  expect_equal(ncol(example_meta), 9)
})

test_that("There are no duplicate rows", {
  expect_true(!anyDuplicated(example_data))
  expect_true(!anyDuplicated(example_meta))
})

test_that("There are no duplicate rows in example comma data", {
  expect_true(!anyDuplicated(example_comma_data))
  expect_true(!anyDuplicated(example_comma_meta))
})

test_that("Comma test data is long enough to test sniffer", {
  expect_gt(
    example_comma_data |>
      dplyr::filter(!grepl(",", la_name)) |>
      nrow(),
    20480
  )
})
