pcon_data <- example_data |>
  dplyr::mutate(
    geographic_level = "Parliamentary Constituency",
    pcon_code = "E14000675",
    pcon_name = "Ealing North"
  )

test_that("passes when pcon columns are absent", {
  result <- check_geog_pcon_combos(example_data)
  expect_equal(result$result, "PASS")
  expect_no_error(check_geog_pcon_combos(example_data, stop_on_error = TRUE))
})

test_that("passes with valid pcon combos", {
  expect_equal(check_geog_pcon_combos(pcon_data)$result, "PASS")
  expect_no_error(check_geog_pcon_combos(pcon_data, stop_on_error = TRUE))
})

test_that("passes with valid 2024 boundary pcon combos", {
  pcon_2024_data <- example_data |>
    dplyr::mutate(
      geographic_level = "Parliamentary Constituency",
      pcon_code = "E14001263",
      pcon_name = "Hamble Valley"
    )
  expect_equal(check_geog_pcon_combos(pcon_2024_data)$result, "PASS")
})

test_that("fails with one invalid pcon combination (singular)", {
  bad_data <- pcon_data |>
    dplyr::mutate(pcon_code = "BADCODE", pcon_name = "BadPCon")
  result <- check_geog_pcon_combos(bad_data)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("BADCODE BadPCon", result$message))
  expect_true(grepl("combination is", result$message))
  expect_false(is.na(result$guidance_url))
})

test_that("fails with multiple invalid pcon combinations (plural)", {
  bad_data <- rbind(
    pcon_data |>
      dplyr::mutate(pcon_code = "BADCODE1", pcon_name = "BadPCon1"),
    pcon_data |>
      dplyr::mutate(pcon_code = "BADCODE2", pcon_name = "BadPCon2")
  )
  result <- check_geog_pcon_combos(bad_data)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("BADCODE1 BadPCon1", result$message))
  expect_true(grepl("BADCODE2 BadPCon2", result$message))
  expect_true(grepl("combinations are", result$message))
})

test_that("ignores rows where pcon_code is 'x'", {
  x_data <- pcon_data |>
    dplyr::mutate(pcon_code = "x", pcon_name = "anything")
  result <- check_geog_pcon_combos(x_data)
  expect_equal(result$result, "PASS")
})

test_that("accepts z code combinations from universal geog options", {
  z_data <- pcon_data |>
    dplyr::mutate(pcon_code = "z", pcon_name = "Not applicable")
  result <- check_geog_pcon_combos(z_data)
  expect_equal(result$result, "PASS")
})
