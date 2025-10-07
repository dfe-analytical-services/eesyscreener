test_that("passes for valid filenames", {
  res <- screen_filenames(
    "datafile.csv",
    "datafile.meta.csv"
  )
  expect_true(all(res$result == "PASS"))
  expect_no_error(
    screen_filenames(
      "datafile.csv",
      "datafile.meta.csv",
      verbose = TRUE,
      stop_on_error = TRUE
    )
  )
})

test_that("fails for bad filenames", {
  expect_error(
    screen_filenames(
      "datafile.csv",
      "wrong.meta.csv",
      stop_on_error = TRUE
    )
  )
  expect_error(
    screen_filenames(
      "data+file.csv",
      "datafile.meta.csv",
      stop_on_error = TRUE
    )
  )
  expect_error(
    screen_filenames(
      "data file.csv",
      "datafile.meta.csv",
      stop_on_error = TRUE
    )
  )
})
