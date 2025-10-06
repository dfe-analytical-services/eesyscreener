test_that("output format is as expected", {
  expect_type(acceptable_time_ids, "character")
  expect_gt(length(acceptable_time_ids), 1)
})
