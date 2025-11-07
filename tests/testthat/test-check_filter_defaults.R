test_that("check_filter_defaults gives advisory correctly", {
  expect_equal(
    check_filter_defaults(
      example_data,
      example_meta
    )$result,
    "ADVISORY"
  )
})
