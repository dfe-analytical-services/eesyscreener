test_that("Duplicate row test", {
  expect_equal(
    data_dictionary |>
      dplyr::summarise(
        count = dplyr::n(),
        .by = c(
          "col_name",
          "filter_item",
          "col_name_parent",
          "filter_item_parent"
        )
      ) |>
      dplyr::filter(count > 1) |>
      nrow(),
    0
  )
})

test_that("Check for non-standard characters", {
  expect_equal(
    data_dictionary |>
      dplyr::filter(if_any(everything(), ~ grepl("[$^&@'#~]", .))) |>
      nrow(),
    0
  )
})

test_that("Package data dictionary is up to date with source from thescreener app", {
  source_data_dictionary <- readr::read_csv(
    render_url("data/data-dictionary.csv", domain = "screener_app_repo")
  )
  expect_equal(
    data_dictionary |>
      nrow(),
    source_data_dictionary |>
      nrow()
  )
})
