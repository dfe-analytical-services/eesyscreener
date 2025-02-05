# check_filename_spaces -------------------------------------------------------
test_that("check_filename_spaces passes correctly", {
  expect_equal(
    check_filename_spaces("passes.csv")$result, "PASS"
  )
  expect_equal(
    check_filename_spaces("passes.meta.csv")$result, "PASS"
  )
})

test_that("check_filename_spaces fails as expected", {
  expect_equal(check_filename_spaces("mid dle.csv")$result, "FAIL")
  expect_equal(check_filename_spaces(" leading.csv")$result, "FAIL")
  expect_equal(check_filename_spaces("trailing .csv")$result, "FAIL")
  expect_equal(check_filename_spaces("fails .meta.csv")$result, "FAIL")
})

test_that("check_filename_spaces returns the right format", {
  expect_type(check_filename_spaces("passes.csv"), "list")
  expect_length(check_filename_spaces("passes.csv"), 3)
  expect_equal(
    names(check_filename_spaces("passes.csv")),
    c("check", "result", "message")
  )
})
