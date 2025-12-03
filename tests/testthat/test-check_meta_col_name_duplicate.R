test_that("passes when all column names are unique", {
  expect_no_error(check_meta_col_name_duplicate(
    example_meta,
    stop_on_error = TRUE
  ))
})

test_that("errors when any column name is duplicated", {
  expect_error(
    check_meta_col_name_duplicate(
      example_meta |>
        rbind(example_meta[1, ]),
      stop_on_error = TRUE
    )
  )
  expect_error(
    check_meta_col_name_duplicate(
      example_meta |>
        rbind(example_meta[2:3, ]),
      stop_on_error = TRUE
    )
  )
})
