test_that("passes when all column names don't have a space in metadata example", {
  expect_no_error(precheck_col_name_spaces(example_meta, stop_on_error = TRUE))
})

test_that("errors when any column name has a space", {
  expect_error(
    precheck_col_name_spaces(
      example_meta |>
        select(col_name) |>
        rbind(
          data.frame(
            col_name = c(
              "education phase",
              "enrolment count"
            )
          )
        ),
      stop_on_error = TRUE
    )
  )
})

test_that("correctly identifies number of columns with spaces", {
  expect_identical(
    precheck_col_name_spaces(
      data.frame(
        col_name = c(
          "col 1 name",
          "col_2_name",
          "col 3 name",
          "col_4_name",
          "col 5 name"
        )
      ),
      stop_on_error = FALSE
    )$message,
    "There are one or more spaces in 3 col_name values in the metadata file at columns: 1,3,5."
  )
})

test_that("correctly identifies which columns have spaces", {
  expect_identical(
    precheck_col_name_spaces(
      data.frame(
        col_name = c(
          "col 1 name",
          "col_2_name",
          "col_3_name",
          "col 4 name",
          "col 5 name"
        )
      ),
      stop_on_error = FALSE
    )$message,
    "There are one or more spaces in 3 col_name values in the metadata file at columns: 1,4,5."
  )
})

test_that("correctly changes wording when only a single column has a space", {
  expect_identical(
    precheck_col_name_spaces(
      data.frame(
        col_name = c(
          "col_1_name",
          "col_2_name",
          "col_3_name",
          "col 4 name",
          "col_5_name"
        )
      ),
      stop_on_error = FALSE
    )$message,
    "There are one or more spaces in 1 col_name value in the metadata file at column: 4."
  )
})

test_that("correctly completes with NA values", {
  expect_identical(
    precheck_col_name_spaces(
      data.frame(
        col_name = c(
          "col_1_name",
          "col_2_name",
          "col_3_name",
          NA,
          "col_5_name"
        )
      ),
      stop_on_error = FALSE
    )$message,
    "There are no spaces in the col_name values."
  )
})
