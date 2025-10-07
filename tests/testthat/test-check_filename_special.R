test_that("check_filename_special passes correctly", {
  expect_no_error(check_filename_special("passes.csv", stop_on_error = TRUE))

  expect_equal(
    check_filename_special("passes.csv")$result,
    "PASS"
  )
  expect_equal(
    check_filename_special("passes.meta.csv")$result,
    "PASS"
  )
})

test_that("check_filename_special fails as expected", {
  expect_equal(
    check_filename_special("mid=dle.csv")$result,
    "FAIL"
  )
  expect_equal(
    check_filename_special("+leading.csv")$result,
    "FAIL"
  )
  expect_equal(
    check_filename_special("trailing%.csv")$result,
    "FAIL"
  )
  expect_equal(
    check_filename_special("fails$.meta.csv")$result,
    "FAIL"
  )
})
