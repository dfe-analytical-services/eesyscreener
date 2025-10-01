test_that("passes as expected", {
  expect_equal(
    check_empty_cols(eesyscreener::example_data, verbose = FALSE)$result,
    "PASS"
  )

  expect_no_error(
    check_empty_cols(eesyscreener::example_data, "file.csv")
  )
})

test_that("fails as expected for NA cols", {
  expect_equal(
    check_empty_cols(
      data.frame(one = c(1, 2), two = c(NA, NA)),
      "file.csv",
      verbose = FALSE
    )$result,
    "FAIL"
  )

  expect_error(
    check_empty_cols(
      data.frame(one = c(1, 2), two = c(NA, NA)),
      "file.csv"
    )
  )
})

test_that("fails as expected for blank cols", {
  expect_equal(
    check_empty_cols(
      data.frame(one = c(1, 2), two = c("", "")),
      verbose = FALSE
    )$result,
    "FAIL"
  )

  expect_error(
    check_empty_cols(
      data.frame(one = c(1, 2), two = c("", "")),
      "file.csv"
    )
  )
})

test_that("passes for cols including a NA or blank string", {
  expect_equal(
    check_empty_cols(
      data.frame(one = c(1, 2), two = c(NA, 3)),
      verbose = FALSE
    )$result,
    "PASS"
  )

  expect_equal(
    check_empty_cols(
      data.frame(one = c(1, 2), two = c("", 3)),
      verbose = FALSE
    )$result,
    "PASS"
  )

  expect_equal(
    check_empty_cols(
      data.frame(one = c(1, 2, 3), two = c(NA, 3, "")),
      verbose = FALSE
    )$result,
    "PASS"
  )

  expect_no_error(
    check_empty_cols(data.frame(one = c(1, 2), two = c("", 3)))
  )
  expect_no_error(
    check_empty_cols(data.frame(one = c(1, 2), two = c(NA, 3)))
  )
  expect_no_error(
    check_empty_cols(data.frame(one = c(1, 2, 3), two = c(NA, 3, "")))
  )
})
