la_data <- example_data |>
  dplyr::mutate(
    new_la_code = "E10000001",
    la_name = "Buckinghamshire",
    old_la_code = "010"
  )

test_that("passes when no LA columns are present", {
  result <- check_geog_la_col_present(example_data)
  expect_equal(result$result, "PASS")
  expect_true(grepl("No local authority columns", result$message))
  expect_no_error(check_geog_la_col_present(example_data, stop_on_error = TRUE))
})

test_that("passes when all three LA columns are present", {
  result <- check_geog_la_col_present(la_data)
  expect_equal(result$result, "PASS")
  expect_true(grepl("All local authority columns are present", result$message))
  expect_no_error(check_geog_la_col_present(la_data, stop_on_error = TRUE))
})

test_that("fails when two LA columns are missing (plural)", {
  one_col_data <- example_data |>
    dplyr::mutate(la_name = "Buckinghamshire")
  result <- check_geog_la_col_present(one_col_data)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("columns are", result$message))
  expect_true(grepl("new_la_code", result$message))
  expect_true(grepl("old_la_code", result$message))
  expect_error(check_geog_la_col_present(one_col_data, stop_on_error = TRUE))
})

test_that("fails when one LA column is missing (singular)", {
  two_col_data <- example_data |>
    dplyr::mutate(
      new_la_code = "E10000001",
      la_name = "Buckinghamshire"
    )
  result <- check_geog_la_col_present(two_col_data)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("column is", result$message))
  expect_true(grepl("old_la_code", result$message))
})
