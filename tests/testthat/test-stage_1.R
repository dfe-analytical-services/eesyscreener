# check_filename_spaces -------------------------------------------------------
test_that("check_filename_spaces passes correctly", {
  expect_equal(
    check_filename_spaces("passes.csv", "data")$result, "PASS"
  )
  expect_equal(
    check_filename_spaces("passes.meta.csv", "metadata")$result, "PASS"
  )
})

test_that("check_filename_spaces fails as expected", {
  expect_equal(
    check_filename_spaces("mid dle.csv", "data")$result, "FAIL"
  )
  expect_equal(
    check_filename_spaces(" leading.csv", "data")$result, "FAIL"
  )
  expect_equal(
    check_filename_spaces("trailing .csv", "data")$result, "FAIL"
  )
  expect_equal(
    check_filename_spaces("fails .meta.csv", "metadata")$result, "FAIL"
  )
})

test_that("check_filename_spaces returns the right format", {
  expect_type(check_filename_spaces("passes.csv", "data"), "list")
  expect_length(check_filename_spaces("passes.csv", "data"), 3)
  expect_equal(
    names(check_filename_spaces("passes.csv", "data")),
    c("check", "result", "message")
  )
})
