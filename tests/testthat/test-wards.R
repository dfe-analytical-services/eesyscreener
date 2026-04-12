test_that("acceptable_wards has expected columns", {
  expect_true(all(c("ward_code", "ward_name") %in% names(acceptable_wards)))
})

test_that("acceptable_wards has no duplicate combinations", {
  expect_equal(
    acceptable_wards |>
      dplyr::summarise(
        count = dplyr::n(),
        .by = c("ward_code", "ward_name")
      ) |>
      dplyr::filter(count > 1) |>
      nrow(),
    0
  )
})

test_that("acceptable_wards contains Penicuik", {
  expect_true("Penicuik" %in% acceptable_wards$ward_name)
  expect_true("S13003018" %in% acceptable_wards$ward_code)
})

test_that("acceptable_wards is in sync with source", {
  source_wards <- readr::read_csv(
    render_url(
      "data/ward_lad_la_pcon_hierarchy.csv",
      domain = "screener_app_repo"
    ),
    show_col_types = FALSE
  ) |>
    dplyr::select("ward_code", "ward_name") |>
    dplyr::distinct()
  expect_equal(nrow(acceptable_wards), nrow(source_wards))
})
