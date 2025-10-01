test_that("check_filename_spaces passes correctly", {
  expect_no_error(check_filename_spaces("passes.csv"))

  expect_equal(
    check_filename_spaces("passes.csv", output = "table")$result,
    "PASS"
  )
  expect_equal(
    check_filename_spaces("passes.meta.csv", output = "table")$result,
    "PASS"
  )
})

test_that("check_filename_spaces fails as expected", {
  expect_error(check_filename_spaces("fails .meta.csv"))

  expect_equal(
    check_filename_spaces("mid dle.csv", output = "table")$result,
    "FAIL"
  )
  expect_equal(
    check_filename_spaces(" leading.csv", output = "table")$result,
    "FAIL"
  )
  expect_equal(
    check_filename_spaces("trailing .csv", output = "table")$result,
    "FAIL"
  )
  expect_equal(
    check_filename_spaces("fails .meta.csv", output = "table")$result,
    "FAIL"
  )
})
