test_that("acceptable_leps has expected columns", {
  expect_true(all(
    c(
      "local_enterprise_partnership_code",
      "local_enterprise_partnership_name"
    ) %in%
      names(acceptable_leps)
  ))
})

test_that("acceptable_leps has no duplicate combinations", {
  expect_equal(
    acceptable_leps |>
      dplyr::summarise(
        count = dplyr::n(),
        .by = c(
          "local_enterprise_partnership_code",
          "local_enterprise_partnership_name"
        )
      ) |>
      dplyr::filter(count > 1) |>
      nrow(),
    0
  )
})

test_that("acceptable_leps contains Black Country", {
  expect_true(
    "Black Country" %in% acceptable_leps$local_enterprise_partnership_name
  )
  expect_true(
    "E37000001" %in% acceptable_leps$local_enterprise_partnership_code
  )
})

test_that("acceptable_leps is in sync with source", {
  source_leps <- readr::read_csv(
    render_url("data/leps.csv", domain = "screener_app_repo"),
    show_col_types = FALSE
  )
  expect_equal(nrow(acceptable_leps), nrow(source_leps))
})
