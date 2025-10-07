test_that("check_filename_spaces passes correctly", {
  expect_no_error(check_filename_spaces("passes.csv", stop_on_error = TRUE))

  expect_equal(
    check_filename_spaces("passes.csv")$result,
    "PASS"
  )
  expect_equal(
    check_filename_spaces("passes.meta.csv")$result,
    "PASS"
  )
})

test_that("check_filename_spaces fails as expected", {
  expect_error(check_filename_spaces("fails .meta.csv", stop_on_error = TRUE))

  expect_equal(
    check_filename_spaces("mid dle.csv")$result,
    "FAIL"
  )
  expect_equal(
    check_filename_spaces(" leading.csv")$result,
    "FAIL"
  )
  expect_equal(
    check_filename_spaces("trailing .csv")$result,
    "FAIL"
  )
  expect_equal(
    check_filename_spaces("fails .meta.csv")$result,
    "FAIL"
  )
})
