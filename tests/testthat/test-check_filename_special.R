test_that("check_filename_special passes correctly", {
  expect_no_error(check_filename_special("passes.csv"))

  expect_equal(
    check_filename_special("passes.csv", verbose = FALSE)$result,
    "PASS"
  )
  expect_equal(
    check_filename_special("passes.meta.csv", verbose = FALSE)$result,
    "PASS"
  )
})

test_that("check_filename_special fails as expected", {
  expect_equal(
    check_filename_special("mid=dle.csv", verbose = FALSE)$result,
    "FAIL"
  )
  expect_equal(
    check_filename_special("+leading.csv", verbose = FALSE)$result,
    "FAIL"
  )
  expect_equal(
    check_filename_special("trailing%.csv", verbose = FALSE)$result,
    "FAIL"
  )
  expect_equal(
    check_filename_special("fails$.meta.csv", verbose = FALSE)$result,
    "FAIL"
  )
})
