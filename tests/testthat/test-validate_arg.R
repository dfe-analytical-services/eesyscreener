test_that("filenames passes for valid input", {
  expect_no_error(validate_arg_filenames("data.csv", "meta.csv"))
})

test_that("filenames errors for non-strings", {
  expect_error(
    validate_arg_filenames(123, "meta.csv"),
    "datafilename.*single string"
  )
  expect_error(
    validate_arg_filenames(c("a", "b"), "meta.csv"),
    "datafilename.*single string"
  )
  expect_error(
    validate_arg_filenames(list("a"), "meta.csv"),
    "datafilename.*single string"
  )
  expect_error(
    validate_arg_filenames("data.csv", 456),
    "metafilename.*single string"
  )
  expect_error(
    validate_arg_filenames("data.csv", c("a", "b")),
    "metafilename.*single string"
  )
  expect_error(
    validate_arg_filenames("data.csv", list("a")),
    "metafilename.*single string"
  )
})
