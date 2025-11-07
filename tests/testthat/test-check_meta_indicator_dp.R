test_that("passes when no filters have an indicator_dp value", {
  expect_equal(check_meta_indicator_dp(example_meta)$result, "PASS")
  expect_no_error(check_meta_indicator_dp(example_meta, stop_on_error = TRUE))
})

test_that("errors when any filter has an indicator_dp value", {
  expect_error(
    check_meta_indicator_dp(example_meta |>
                         dplyr::mutate(indicator_dp = 0),
                       stop_on_error = TRUE)
  )
  expect_error(
    check_meta_indicator_dp(example_meta |>
                         dplyr::mutate(indicator_dp = dplyr::case_when(col_name == "sex" ~ "1",
                                                                       TRUE ~ indicator_dp)),
                       stop_on_error = TRUE)
  )
})
