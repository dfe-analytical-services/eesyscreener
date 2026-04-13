lad_data <- example_data |>
  dplyr::mutate(
    geographic_level = "Local authority district",
    lad_code = "E06000001",
    lad_name = "Hartlepool"
  )

test_that("passes when no applicable geographic levels are present", {
  result <- check_geog_na(example_data)
  expect_equal(result$result, "PASS")
  expect_true(grepl("No applicable", result$message))
  expect_no_error(check_geog_na(example_data, stop_on_error = TRUE))
})

test_that("passes when applicable levels are present with correct names", {
  result <- check_geog_na(lad_data)
  expect_equal(result$result, "PASS")
  expect_no_error(check_geog_na(lad_data, stop_on_error = TRUE))
})

test_that("passes when code is 'x' and name is 'Not available'", {
  na_data <- lad_data |>
    dplyr::mutate(lad_code = "x", lad_name = "Not available")
  result <- check_geog_na(na_data)
  expect_equal(result$result, "PASS")
})

test_that("fails when one level has code 'x' with wrong name (singular)", {
  bad_data <- example_data |>
    dplyr::mutate(
      geographic_level = "Provider",
      provider_ukprn = "x",
      provider_name = "Some Place"
    )
  result <- check_geog_na(bad_data)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("Provider", result$message))
  expect_true(grepl("level has", result$message))
})

test_that("fails when multiple levels have wrong names for 'x' code (plural)", {
  provider_bad <- example_data |>
    dplyr::mutate(
      geographic_level = "Provider",
      provider_ukprn = "x",
      provider_name = "Wrong"
    )
  school_bad <- example_data |>
    dplyr::mutate(
      geographic_level = "School",
      school_urn = "x",
      school_name = "Somewhere"
    )
  bad_data <- dplyr::bind_rows(provider_bad, school_bad)
  result <- check_geog_na(bad_data)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("Provider", result$message))
  expect_true(grepl("School", result$message))
  expect_true(grepl("levels have", result$message))
  expect_error(check_geog_na(bad_data, stop_on_error = TRUE))
})

test_that("passes when applicable level columns are absent from data", {
  # Ward level present but ward columns missing
  ward_data <- example_data |>
    dplyr::mutate(geographic_level = "Ward")
  result <- check_geog_na(ward_data)
  expect_equal(result$result, "PASS")
})

test_that("excluded levels (National, Regional) are not tested", {
  national_data <- example_data |>
    dplyr::mutate(country_code = "x", country_name = "Wrong Name")
  result <- check_geog_na(national_data)
  expect_equal(result$result, "PASS")
})
