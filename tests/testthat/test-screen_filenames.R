test_that("passes for valid filenames", {
  res <- screen_filenames(
    "datafile.csv",
    "datafile.meta.csv",
    output = "table"
  )
  expect_true(all(res$result == "PASS"))
  expect_no_error(
    screen_filenames(
      "datafile.csv",
      "datafile.meta.csv"
    )
  )
})

test_that("fails for bad filenames", {
  expect_error(
    screen_filenames(
      "datafile.csv",
      "wrong.meta.csv",
      output = "error-only"
    )
  )
  expect_error(
    screen_filenames(
      "data+file.csv",
      "datafile.meta.csv",
      output = "error-only"
    )
  )
  expect_error(
    screen_filenames(
      "data file.csv",
      "datafile.meta.csv",
      output = "error-only"
    )
  )
})
