test_that("acceptable_pcons has expected columns", {
  expect_true(all(c("pcon_code", "pcon_name") %in% names(acceptable_pcons)))
})

test_that("acceptable_pcons has no duplicate combinations", {
  expect_equal(
    acceptable_pcons |>
      dplyr::summarise(
        count = dplyr::n(),
        .by = c("pcon_code", "pcon_name")
      ) |>
      dplyr::filter(count > 1) |>
      nrow(),
    0
  )
})

test_that("acceptable_pcons contains Ealing North", {
  expect_true("Ealing North" %in% acceptable_pcons$pcon_name)
  expect_true("E14000675" %in% acceptable_pcons$pcon_code)
})

test_that("acceptable_pcons contains 2024 boundaries", {
  expect_true("Hamble Valley" %in% acceptable_pcons$pcon_name)
  expect_true("E14001263" %in% acceptable_pcons$pcon_code)
})
