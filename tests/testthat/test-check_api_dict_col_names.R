test_that("check example_meta passes dictionary col_names check", {
  expect_equal(
    check_api_dict_col_names(
      example_meta
    )$result,
    "PASS"
  )
})

test_that("check for fail when non standard filter is included", {
  expect_equal(
    check_api_dict_col_names(
      example_meta |>
        dplyr::mutate(
          col_name = stringr::str_replace(
            col_name,
            "sex",
            "non_standard_filter"
          )
        )
    )$result,
    "WARNING"
  )
})


test_that("check for fail when non standard indicator is included", {
  expect_equal(
    check_api_dict_col_names(
      example_meta |>
        dplyr::mutate(
          col_name = stringr::str_replace(
            col_name,
            "enrolment_count",
            "non_standard_indicator"
          )
        )
    )$result,
    "WARNING"
  )
})
