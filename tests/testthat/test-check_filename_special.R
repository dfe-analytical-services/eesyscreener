test_that("check_filename_special passes correctly", {
  expect_no_error(check_filename_special("passes.csv"))

  expect_equal(
    check_filename_special("passes.csv", output = "table")$result,
    "PASS"
  )
  expect_equal(
    check_filename_special("passes.meta.csv", output = "table")$result,
    "PASS"
  )
})

test_that("check_filename_special fails as expected", {
  expect_equal(
    check_filename_special("mid=dle.csv", output = "table")$result,
    "FAIL"
  )
  expect_equal(
    check_filename_special("+leading.csv", output = "table")$result,
    "FAIL"
  )
  expect_equal(
    check_filename_special("trailing%.csv", output = "table")$result,
    "FAIL"
  )
  expect_equal(
    check_filename_special("fails$.meta.csv", output = "table")$result,
    "FAIL"
  )
})
