test_that("Removes NAs and blank strings from a character vector", {
  x <- c("a", NA, "", "b", " ")
  expect_equal(remove_na_string(x), c("a", "b", " "))
})

test_that("Removes NAs and blank strings from a numeric vector", {
  x <- c(1, NA, 2, "", 3)
  expect_equal(remove_na_string(x), c("1", "2", "3"))
})

test_that("Errors on unsupported input types", {
  expect_error(
    remove_na_string(as.data.frame(c(1, 2, NA), c("A", "B", "C"))),
    "Input must be a vector."
  )
})

test_that("Works with all NA or blank input", {
  x <- c(NA, "", NA)
  expect_equal(remove_na_string(x), character(0))
})
