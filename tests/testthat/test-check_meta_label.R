test_that("no error when label value present", {
  expect_no_error(check_meta_label(example_meta, stop_on_error = TRUE))
})

test_that("errors with one missing label", {
  bad_meta <- data.frame(label = c("A", NA, "B"))
  expect_error(
    check_meta_label(bad_meta, stop_on_error = TRUE),
    "There is a label missing in 1 row"
  )
})

test_that("errors with multiple missing labels", {
  bad_meta <- data.frame(label = c("", NA, " "))
  expect_error(
    check_meta_label(bad_meta, stop_on_error = TRUE),
    "There are labels missing in 3 rows"
  )
})
