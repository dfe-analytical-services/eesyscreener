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

test_that("validate_arg_dfs passes for valid data frames", {
  df1 <- data.frame(a = 1:3)
  df2 <- data.frame(b = 4:6)
  expect_no_error(validate_arg_dfs(df1, df2))
})

test_that("validate_arg_dfs errors for non data frames", {
  df <- data.frame(b = 4:6)
  expect_error(validate_arg_dfs(123, df), "datafile.*data frame")
  expect_error(validate_arg_dfs(list(a = 1:3), df), "datafile.*data frame")
  expect_error(validate_arg_dfs("not a df", df), "datafile.*data frame")
  expect_error(validate_arg_dfs(df, 456), "metafile.*data frame")
  expect_error(validate_arg_dfs(df, list(b = 4:6)), "metafile.*data frame")
  expect_error(validate_arg_dfs(df, "not a df"), "metafile.*data frame")
})

test_that("validate_arg_logical passes for valid options", {
  expect_no_error(validate_arg_logical(TRUE, "test_arg"))
  expect_no_error(validate_arg_logical(FALSE, "test_arg"))
})

test_that("validate_arg_logical errors for invalid options", {
  expect_error(
    validate_arg_logical("invalid", "test_arg"),
    "test_arg.*single logical."
  )
  expect_error(
    validate_arg_logical(123, "test_arg"),
    "test_arg.*single logical."
  )
  expect_error(
    validate_arg_logical(c(TRUE, TRUE), "test_arg"),
    "test_arg.*single logical."
  )
  expect_error(
    validate_arg_logical(NULL, "test_arg"),
    "test_arg.*single logical."
  )
})
