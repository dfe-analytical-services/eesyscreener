test_that("passes when no filters have an indicator_grouping value", {
  expect_equal(check_meta_indicator_grouping(example_meta)$result, "PASS")
  expect_no_error(check_meta_indicator_grouping(
    example_meta,
    stop_on_error = TRUE
  ))
})

test_that("errors when any filter has an indicator_grouping value", {
  expect_error(
    check_meta_indicator_grouping(
      example_meta |>
        dplyr::mutate(indicator_grouping = 0),
      stop_on_error = TRUE
    )
  )
  expect_error(
    check_meta_indicator_grouping(
      example_meta |>
        dplyr::mutate(
          indicator_grouping = dplyr::case_when(
            col_name == "sex" ~ "percentage",
            TRUE ~ indicator_grouping
          )
        ),
      stop_on_error = TRUE
    )
  )
})
