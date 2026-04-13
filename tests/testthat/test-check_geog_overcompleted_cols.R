# Base data with National level only - should always pass
national_data <- example_data

# Data with Regional level and properly completed columns
regional_data <- example_data |>
  dplyr::mutate(
    geographic_level = "Regional",
    region_code = "E12000001",
    region_name = "North East"
  )

# Data with LA level rows
la_data <- example_data |>
  dplyr::mutate(
    geographic_level = "Local authority",
    new_la_code = "E09000001",
    la_name = "City of London",
    region_code = "E12000007",
    region_name = "London"
  )

test_that("passes with National-only data", {
  result <- check_geog_overcompleted_cols(national_data, example_meta)
  expect_equal(result$result, "PASS")
  expect_no_error(
    check_geog_overcompleted_cols(
      national_data,
      example_meta,
      stop_on_error = TRUE
    )
  )
})

test_that("passes when geographic columns are correctly populated", {
  # Regional columns present only for Regional rows
  combined <- dplyr::bind_rows(national_data, regional_data)
  result <- check_geog_overcompleted_cols(combined, example_meta)
  expect_equal(result$result, "PASS")
})

test_that("passes when compatible levels have columns populated", {
  # region columns populated for LA rows is expected
  result <- check_geog_overcompleted_cols(la_data, example_meta)
  expect_equal(result$result, "PASS")
})

test_that("fails when one column is overcompleted (singular)", {
  # region_code filled in for National rows
  bad_data <- national_data |>
    dplyr::mutate(
      region_code = "E12000001"
    )
  result <- check_geog_overcompleted_cols(bad_data, example_meta)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("region_code", result$message))
  expect_true(grepl("column is", result$message))
})

test_that("fails when multiple columns are overcompleted (plural)", {
  bad_data <- national_data |>
    dplyr::mutate(
      region_code = "E12000001",
      region_name = "North East"
    )
  result <- check_geog_overcompleted_cols(bad_data, example_meta)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("region_code", result$message))
  expect_true(grepl("region_name", result$message))
  expect_true(grepl("columns are", result$message))
  expect_error(
    check_geog_overcompleted_cols(bad_data, example_meta, stop_on_error = TRUE)
  )
})

test_that("ignores columns not present in data", {
  # No lad columns in data, so even with LAD rows, no overcomplete detected
  lad_rows <- national_data |>
    dplyr::mutate(geographic_level = "Local authority district")
  combined <- dplyr::bind_rows(national_data, lad_rows)
  result <- check_geog_overcompleted_cols(combined, example_meta)
  expect_equal(result$result, "PASS")
})

test_that("NA and empty string values are not flagged", {
  bad_data <- national_data |>
    dplyr::mutate(
      region_code = NA_character_,
      region_name = ""
    )
  result <- check_geog_overcompleted_cols(bad_data, example_meta)
  expect_equal(result$result, "PASS")
})

test_that("School name skipped when it is the only filter", {
  school_data <- example_data |>
    dplyr::mutate(
      geographic_level = "School",
      school_urn = "100000",
      school_name = "Test School",
      school_laestab = "1234567"
    )

  # National rows also have school_name populated (it's a filter)
  combined <- dplyr::bind_rows(
    national_data |>
      dplyr::mutate(
        school_urn = NA_character_,
        school_name = "Test School",
        school_laestab = NA_character_
      ),
    school_data
  )

  # Meta where school_name is the only filter
  school_meta <- data.frame(
    col_name = c("school_name", "enrolment_count"),
    col_type = c("Filter", "Indicator"),
    label = c("School name", "Number of enrolments"),
    indicator_grouping = c("", ""),
    indicator_unit = c("", ""),
    indicator_dp = c("", "0"),
    filter_hint = c("", ""),
    filter_grouping_column = c("", "")
  )

  result <- check_geog_overcompleted_cols(combined, school_meta)
  # school_name should be skipped, but school_urn and school_laestab
  # should not be flagged as they are NA for national rows
  expect_equal(result$result, "PASS")
})

test_that("mid-level geog columns flagged for non-compatible levels", {
  # LEP code populated for National rows
  bad_data <- national_data |>
    dplyr::mutate(
      local_enterprise_partnership_code = "E37000001",
      local_enterprise_partnership_name = "Test LEP"
    )
  result <- check_geog_overcompleted_cols(bad_data, example_meta)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("local_enterprise_partnership_code", result$message))
})

test_that("low-level geog columns flagged for all other levels", {
  # Provider columns populated for National rows
  bad_data <- national_data |>
    dplyr::mutate(
      provider_ukprn = "12345678",
      provider_name = "Test Provider"
    )
  result <- check_geog_overcompleted_cols(bad_data, example_meta)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("provider_ukprn", result$message))
})
