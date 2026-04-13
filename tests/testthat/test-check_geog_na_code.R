# Base data with a testable geographic level (Provider) including
# provider_ukprn and provider_name
provider_data <- example_data |>
  dplyr::mutate(
    geographic_level = "Provider",
    provider_ukprn = "10000123",
    provider_name = "Test Provider"
  )

# Provider data where provider_name is "Not available" and provider_ukprn
# is correctly "x"
provider_na_valid <- provider_data |>
  dplyr::mutate(provider_ukprn = "x", provider_name = "Not available")

# Provider data where provider_name is "Not available" but provider_ukprn
# is wrong
provider_na_bad <- provider_data |>
  dplyr::mutate(provider_ukprn = "BADCODE", provider_name = "Not available")

test_that("passes when no testable geographic levels are present", {
  result <- check_geog_na_code(example_data)
  expect_equal(result$result, "PASS")
  expect_no_error(check_geog_na_code(example_data, stop_on_error = TRUE))
})

test_that("passes when testable levels have valid 'Not available' codes", {
  result <- check_geog_na_code(provider_na_valid)
  expect_equal(result$result, "PASS")
  expect_no_error(check_geog_na_code(provider_na_valid, stop_on_error = TRUE))
})

test_that("passes when testable level rows have normal (non-NA) entries", {
  result <- check_geog_na_code(provider_data)
  expect_equal(result$result, "PASS")
  expect_no_error(check_geog_na_code(provider_data, stop_on_error = TRUE))
})

test_that("fails with one level having bad 'Not available' code (singular)", {
  result <- check_geog_na_code(provider_na_bad)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("Provider", result$message))
  expect_true(grepl("level has", result$message))
  expect_true(grepl("'x'", result$message))
})

test_that("errors on stop_on_error with failing data", {
  expect_error(check_geog_na_code(provider_na_bad, stop_on_error = TRUE))
})

test_that("fails with multiple levels having bad codes (plural)", {
  school_na_bad <- example_data |>
    dplyr::mutate(
      geographic_level = "School",
      school_urn = "BADURN",
      school_name = "Not available"
    )

  multi_bad <- dplyr::bind_rows(provider_na_bad, school_na_bad)
  result <- check_geog_na_code(multi_bad)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("Provider", result$message))
  expect_true(grepl("School", result$message))
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
