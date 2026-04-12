test_that("acceptable_lads has expected columns", {
  expect_true(all(c("lad_code", "lad_name") %in% names(acceptable_lads)))
})

test_that("acceptable_lads has no duplicate combinations", {
  expect_equal(
    acceptable_lads |>
      dplyr::summarise(
        count = dplyr::n(),
        .by = c("lad_code", "lad_name")
      ) |>
      dplyr::filter(count > 1) |>
      nrow(),
    0
  )
})

test_that("acceptable_lads contains Hartlepool", {
  expect_true("Hartlepool" %in% acceptable_lads$lad_name)
  expect_true("E06000001" %in% acceptable_lads$lad_code)
})

test_that("acceptable_lads is in sync with source", {
  source_lads <- readr::read_csv(
    render_url("data/lads.csv", domain = "screener_app_repo"),
    show_col_types = FALSE
  )
  expect_equal(nrow(acceptable_lads), nrow(source_lads))
})
