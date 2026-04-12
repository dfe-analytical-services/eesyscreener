test_that("acceptable_edas has expected columns", {
  expect_true(all(
    c(
      "english_devolved_area_code",
      "english_devolved_area_name"
    ) %in%
      names(acceptable_edas)
  ))
})

test_that("acceptable_edas has no duplicate combinations", {
  expect_equal(
    acceptable_edas |>
      dplyr::summarise(
        count = dplyr::n(),
        .by = c(
          "english_devolved_area_code",
          "english_devolved_area_name"
        )
      ) |>
      dplyr::filter(count > 1) |>
      nrow(),
    0
  )
})

test_that("acceptable_edas contains Greater London Authority", {
  expect_true(
    "Greater London Authority" %in% acceptable_edas$english_devolved_area_name
  )
  expect_true(
    "E61000001" %in% acceptable_edas$english_devolved_area_code
  )
})

test_that("acceptable_edas is in sync with source", {
  source_edas <- readr::read_csv(
    render_url("data/english_devolved_areas.csv", domain = "screener_app_repo"),
    show_col_types = FALSE
  ) |>
    dplyr::select("english_devolved_area_code", "english_devolved_area_name") |>
    dplyr::distinct()
  expect_equal(nrow(acceptable_edas), nrow(source_edas))
})
