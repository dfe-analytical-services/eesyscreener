#create a df to test the function
df <- data.frame(
  var1 = 1:5,
  var2 = letters[1:5],
  var3 = rnorm(5)
)

test_that("the function passes with no spaces", {
  result <- check_col_names_spaces(df)
  expect_equal(check_col_names_spaces(df)$result, "PASS")
  expect_equal(
    result$message,
    "There are no spaces in the variable names in the datafile."
  )
})

#test that the function fails with spaces in column names
test_that("the function fails with spaces in column names", {
  df_fail <- df |>
    dplyr::rename("var 1" = var1, "var 3" = var3)

  result <- check_col_names_spaces(df_fail)
  expect_equal(result$result, "FAIL")
  expect_equal(
    result$message,
    "The following variable names each have at least one space that needs removing: 'var 1', 'var 3'."
  )
})
#test that the function fails with a single space in a column name
test_that("the function fails with a single space in a column name", {
  df_fail_2 <- df |>
    dplyr::rename("var 1" = var1)
  result <- check_col_names_spaces(df_fail_2)
  expect_equal(result$result, "FAIL")
  expect_equal(
    result$message,
    "The following variable name has at least one space that needs removing: 'var 1'."
  )
})
