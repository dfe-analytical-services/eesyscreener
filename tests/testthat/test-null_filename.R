test_that("returns correct string for NULL input", {
  expect_equal(null_filename(NULL), "the tested data frame")
})

test_that("returns quoted string for other inputs", {
  expect_equal(null_filename("myfile.csv"), "'myfile.csv'")
  expect_equal(null_filename("test"), "'test'")
  expect_equal(null_filename(""), "''")
  expect_equal(null_filename(123), "'123'")
  expect_equal(null_filename(TRUE), "'TRUE'")
  expect_equal(null_filename(NA), "'NA'")
})
