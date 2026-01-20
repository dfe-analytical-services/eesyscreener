test_that("check_filter_defaults gives WARNING correctly when no totals or filter defaults are used", {
  expect_equal(
    check_filter_defaults(
      example_data,
      example_meta
    )$result,
    "WARNING"
  )
})

test_that("test filter default combinations", {
  # Case when all filters have a filter default
  expect_equal(
    check_filter_defaults(
      example_data,
      example_meta |>
        dplyr::mutate(
          filter_default = dplyr::case_when(
            col_name == "education_phase" ~ "All phases",
            col_name == "sex" ~ "All pupils",
            .default = ""
          )
        )
    )$result,
    "PASS"
  )

  # Case when all filters have a Total
  expect_equal(
    check_filter_defaults(
      example_data |>
        dplyr::mutate(
          dplyr::across(
            c("sex", "education_phase"),
            ~ replace(., grepl("All ", .), "Total")
          )
        ),
      example_meta
    )$result,
    "PASS"
  )

  # Case when one filter has a Total and another has a filter default
  expect_equal(
    check_filter_defaults(
      example_data |>
        dplyr::mutate(
          dplyr::across(c("sex"), ~ replace(., grepl("All ", .), "Total"))
        ),
      example_meta |>
        dplyr::mutate(
          filter_default = dplyr::case_when(
            col_name == "education_phase" ~ "All phases",
            .default = ""
          )
        )
    )$result,
    "PASS"
  )
})
