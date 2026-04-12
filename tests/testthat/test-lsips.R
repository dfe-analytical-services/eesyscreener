test_that("acceptable_lsips has expected columns", {
  expect_true(all(c("lsip_code", "lsip_name") %in% names(acceptable_lsips)))
})

test_that("acceptable_lsips has no duplicate combinations", {
  expect_equal(
    acceptable_lsips |>
      dplyr::summarise(
        count = dplyr::n(),
        .by = c("lsip_code", "lsip_name")
      ) |>
      dplyr::filter(count > 1) |>
      nrow(),
    0
  )
})

test_that("acceptable_lsips contains Buckinghamshire", {
  expect_true("Buckinghamshire" %in% acceptable_lsips$lsip_name)
  expect_true("E69000002" %in% acceptable_lsips$lsip_code)
})

test_that("acceptable_lsips is in sync with source", {
  source_lsips <- readr::read_csv(
    render_url("data/lsips.csv", domain = "screener_app_repo"),
    show_col_types = FALSE
  ) |>
    dplyr::select("lsip_code", "lsip_name") |>
    dplyr::distinct()
  expect_equal(nrow(acceptable_lsips), nrow(source_lsips))
})
