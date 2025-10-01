test_that("check_filenames_match passes correctly", {
  expect_no_error(check_filenames_match("datafile.csv", "datafile.meta.csv"))

  expect_equal(
    check_filenames_match(
      "datafile.csv",
      "datafile.meta.csv",
      output = "table"
    )$result,
    "PASS"
  )
})

test_that("check_filenames_match fails as expected", {
  expect_equal(
    check_filenames_match(
      "datafile.txt",
      "datafile.meta.csv",
      output = "table"
    )$result,
    "FAIL"
  )
  expect_equal(
    check_filenames_match(
      "datafile.csv",
      "datafile.meta.txt",
      output = "table"
    )$result,
    "FAIL"
  )
  expect_equal(
    check_filenames_match(
      "datafile.txt",
      "datafile.meta.txt",
      output = "table"
    )$result,
    "FAIL"
  )
  expect_equal(
    check_filenames_match(
      "datafile.csv",
      "metafile.csv",
      output = "table"
    )$result,
    "FAIL"
  )
  expect_equal(
    check_filenames_match(
      "datafile.csv",
      "datafile.csv",
      output = "table"
    )$result,
    "FAIL"
  )
  expect_error(
    check_filenames_match(
      "datafile.csv",
      "datafile.csv"
    )
  )
  expect_error(
    check_filenames_match(
      "datafile.csv",
      "datafile.csv",
      output = "error-only"
    )
  )
})
