test_that("passes when only valid cols are present", {
  expect_no_error(precheck_col_invalid_meta(example_meta, stop_on_error = TRUE))
})

test_that("errors when invalid columns are present", {
  expect_error(
    precheck_col_invalid_meta(
      example_meta |>
        cbind("BadCol" = 1),
      stop_on_error = TRUE
    )
  )
  expect_error(
    precheck_col_invalid_meta(
      example_meta |>
        cbind("BadCol" = 1, "AnotherBadCol" = 2),
      stop_on_error = TRUE
    ),
    "columns"
  )
})
