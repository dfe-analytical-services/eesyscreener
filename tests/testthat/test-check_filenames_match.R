test_that("check_filenames_match passes correctly", {
  expect_no_error(check_filenames_match("datafile.csv", "datafile.meta.csv"))

  expect_equal(
    check_filenames_match(
      "datafile.csv",
      "datafile.meta.csv",
      verbose = FALSE
    )$result,
    "PASS"
  )
})

test_that("check_filenames_match fails as expected", {
  expect_equal(
    check_filenames_match(
      "datafile.txt",
      "datafile.meta.csv",
      verbose = FALSE
    )$result,
    "FAIL"
  )
  expect_equal(
    check_filenames_match(
      "datafile.csv",
      "datafile.meta.txt",
      verbose = FALSE
    )$result,
    "FAIL"
  )
  expect_equal(
    check_filenames_match(
      "datafile.txt",
      "datafile.meta.txt",
      verbose = FALSE
    )$result,
    "FAIL"
  )
  expect_equal(
    check_filenames_match(
      "datafile.csv",
      "metafile.csv",
      verbose = FALSE
    )$result,
    "FAIL"
  )
  expect_equal(
    check_filenames_match(
      "datafile.csv",
      "datafile.csv",
      verbose = FALSE
    )$result,
    "FAIL"
  )
})
