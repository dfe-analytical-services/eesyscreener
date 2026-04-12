# Base data with a testable geographic level (LAD) including lad_code/lad_name
lad_data <- example_data |>
  dplyr::mutate(
    geographic_level = "Local authority district",
    lad_code = "E06000001",
    lad_name = "Hartlepool"
  )

# LAD data where lad_name is "Not available" and lad_code is correctly "x"
lad_na_valid <- lad_data |>
  dplyr::mutate(lad_code = "x", lad_name = "Not available")

# LAD data where lad_name is "Not available" but lad_code is wrong
lad_na_bad <- lad_data |>
  dplyr::mutate(lad_code = "BADCODE", lad_name = "Not available")

test_that("passes when no testable geographic levels are present", {
  result <- check_geog_na_code(example_data)
  expect_equal(result$result, "PASS")
  expect_no_error(check_geog_na_code(example_data, stop_on_error = TRUE))
})

test_that("passes when testable levels have valid 'Not available' codes", {
  result <- check_geog_na_code(lad_na_valid)
  expect_equal(result$result, "PASS")
  expect_no_error(check_geog_na_code(lad_na_valid, stop_on_error = TRUE))
})

test_that("passes when testable level rows have normal (non-NA) entries", {
  result <- check_geog_na_code(lad_data)
  expect_equal(result$result, "PASS")
  expect_no_error(check_geog_na_code(lad_data, stop_on_error = TRUE))
})

test_that("fails with one level having bad 'Not available' code (singular)", {
  result <- check_geog_na_code(lad_na_bad)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("Local authority district", result$message))
  expect_true(grepl("level has", result$message))
  expect_true(grepl("'x'", result$message))
})

test_that("errors on stop_on_error with failing data", {
  expect_error(check_geog_na_code(lad_na_bad, stop_on_error = TRUE))
})

test_that("fails with multiple levels having bad codes (plural)", {
  pcon_na_bad <- example_data |>
    dplyr::mutate(
      geographic_level = "Parliamentary constituency",
      pcon_code = "BADPCON",
      pcon_name = "Not available"
    )

  multi_bad <- dplyr::bind_rows(lad_na_bad, pcon_na_bad)
  result <- check_geog_na_code(multi_bad)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("Local authority district", result$message))
  expect_true(grepl("Parliamentary constituency", result$message))
  expect_true(grepl("levels have", result$message))
})

test_that("passes when testable level columns are absent from data", {
  # LAD level present but lad_code/lad_name columns are missing
  no_col_data <- example_data |>
    dplyr::mutate(geographic_level = "Local authority district")
  result <- check_geog_na_code(no_col_data)
  expect_equal(result$result, "PASS")
})

test_that("excluded levels (National, Regional, Institution) are not checked", {
  national_bad <- example_data |>
    dplyr::mutate(country_code = "BADCODE", country_name = "Not available")
  result <- check_geog_na_code(national_bad)
  expect_equal(result$result, "PASS")
})
