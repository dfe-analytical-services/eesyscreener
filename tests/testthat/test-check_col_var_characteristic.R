test_that("passes when no characteristic fields are present", {
  expect_equal(check_col_var_characteristic(example_meta)$result, "PASS")
  expect_no_error(check_col_var_characteristic(
    example_meta,
    stop_on_error = TRUE
  ))
})

test_that("warns when 'characteristic' is in col_name", {
  bad_meta <- example_meta |>
    rbind(data.frame(
      col_name = "characteristic",
      col_type = "Filter",
      label = "Characteristic",
      indicator_grouping = "",
      indicator_unit = "",
      indicator_dp = NA_real_,
      filter_hint = "",
      filter_grouping_column = "",
      filter_default = ""
    ))
  result <- check_col_var_characteristic(bad_meta)
  expect_equal(result$result, "WARNING")
  expect_true(grepl("characteristic", result$message))
  expect_warning(check_col_var_characteristic(bad_meta, stop_on_error = TRUE))
})

test_that("warns when 'characteristic_group' is in col_name", {
  bad_meta <- example_meta |>
    rbind(data.frame(
      col_name = "characteristic_group",
      col_type = "Filter",
      label = "Characteristic Group",
      indicator_grouping = "",
      indicator_unit = "",
      indicator_dp = NA_real_,
      filter_hint = "",
      filter_grouping_column = "",
      filter_default = ""
    ))
  result <- check_col_var_characteristic(bad_meta)
  expect_equal(result$result, "WARNING")
  expect_true(grepl("characteristic_group", result$message))
  expect_warning(check_col_var_characteristic(bad_meta, stop_on_error = TRUE))
})

test_that("warns when 'characteristic_group' is in filter_grouping_column", {
  bad_meta <- example_meta
  bad_meta$filter_grouping_column[1] <- "characteristic_group"
  result <- check_col_var_characteristic(bad_meta)
  expect_equal(result$result, "WARNING")
  expect_true(grepl("characteristic_group", result$message))
  expect_warning(check_col_var_characteristic(bad_meta, stop_on_error = TRUE))
})
