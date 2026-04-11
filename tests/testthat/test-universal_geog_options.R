test_that("universal_geog_options has expected columns", {
  expect_true(all(c("code", "name") %in% names(universal_geog_options)))
})

test_that("universal_geog_options has no duplicate combinations", {
  expect_equal(
    universal_geog_options |>
      dplyr::summarise(
        count = dplyr::n(),
        .by = c("code", "name")
      ) |>
      dplyr::filter(count > 1) |>
      nrow(),
    0
  )
})

test_that("universal_geog_options contains Not applicable", {
  expect_true("Not applicable" %in% universal_geog_options$name)
})

test_that("universal_geog_options is in sync with source", {
  source_universal <- readr::read_csv(
    render_url("data/universal_geog_options.csv", domain = "screener_app_repo"),
    show_col_types = FALSE
  )
  expect_equal(nrow(universal_geog_options), nrow(source_universal))
})
