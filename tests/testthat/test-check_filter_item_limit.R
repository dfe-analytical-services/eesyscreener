test_that("Filter item limit error is triggered", {
  expect_error(
    check_filter_item_limit(
      example_data |>
        dplyr::left_join(data.frame(
          time_period = rep("201718", filter_item_limit + 1),
          dummy = 1:filter_item_limit + 1
        )),
      example_meta |>
        dplyr::bind_rows(data.frame(col_name = "dummy", col_type = "Filter"))
    )
  )
})
