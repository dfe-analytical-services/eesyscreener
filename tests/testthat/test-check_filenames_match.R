test_that("check_filenames_match passes correctly", {
  expect_no_error(check_filenames_match(
    "datafile.csv",
    "datafile.meta.csv",
    stop_on_error = TRUE
  ))

  expect_equal(
    check_filenames_match(
      "datafile.csv",
      "datafile.meta.csv"
    )$result,
    "PASS"
  )
})

test_that("check_filenames_match fails as expected", {
  expect_equal(
    check_filenames_match(
      "datafile.txt",
      "datafile.meta.csv"
    )$result,
    "FAIL"
  )
  expect_equal(
    check_filenames_match(
      "datafile.csv",
      "datafile.meta.txt"
    )$result,
    "FAIL"
  )
  expect_equal(
    check_filenames_match(
      "datafile.txt",
      "datafile.meta.txt"
    )$result,
    "FAIL"
  )
  expect_equal(
    check_filenames_match(
      "datafile.csv",
      "metafile.csv"
    )$result,
    "FAIL"
  )
  expect_equal(
    check_filenames_match(
      "datafile.csv",
      "datafile.csv"
    )$result,
    "FAIL"
  )
  expect_error(
    check_filenames_match(
      "datafile.csv",
      "datafile.csv",
      stop_on_error = TRUE
    )
  )
  expect_error(
    check_filenames_match(
      "datafile.csv",
      "datafile.csv",
      stop_on_error = TRUE
    )
  )
})
