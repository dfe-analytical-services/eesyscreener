test_that("check_filename_spaces passes correctly", {
  expect_no_error(check_filename_spaces("passes.csv"))

  expect_equal(
    check_filename_spaces("passes.csv", verbose = FALSE)$result,
    "PASS"
  )
  expect_equal(
    check_filename_spaces("passes.meta.csv", verbose = FALSE)$result,
    "PASS"
  )
})

test_that("check_filename_spaces fails as expected", {
  expect_error(check_filename_spaces("fails .meta.csv"))

  expect_equal(
    check_filename_spaces("mid dle.csv", verbose = FALSE)$result,
    "FAIL"
  )
  expect_equal(
    check_filename_spaces(" leading.csv", verbose = FALSE)$result,
    "FAIL"
  )
  expect_equal(
    check_filename_spaces("trailing .csv", verbose = FALSE)$result,
    "FAIL"
  )
  expect_equal(
    check_filename_spaces("fails .meta.csv", verbose = FALSE)$result,
    "FAIL"
  )
})
