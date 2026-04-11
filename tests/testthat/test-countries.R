test_that("countries has expected columns", {
  expect_true(all(c("country_code", "country_name") %in% names(countries)))
})

test_that("countries has no duplicate combinations", {
  expect_equal(
    countries |>
      dplyr::summarise(
        count = dplyr::n(),
        .by = c("country_code", "country_name")
      ) |>
      dplyr::filter(count > 1) |>
      nrow(),
    0
  )
})

test_that("countries contains England", {
  expect_true("England" %in% countries$country_name)
  expect_true("E92000001" %in% countries$country_code)
})

test_that("countries is in sync with source", {
  source_countries <- readr::read_csv(
    render_url("data/country.csv", domain = "screener_app_repo"),
    show_col_types = FALSE
  )
  expect_equal(nrow(countries), nrow(source_countries))
})
