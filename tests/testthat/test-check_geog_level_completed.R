regional_data <- example_data |>
  dplyr::mutate(
    geographic_level = "Regional",
    region_code = "E12000001",
    region_name = "North East"
  )

test_that("passes with national example data", {
  result <- check_geog_level_completed(example_data)
  expect_equal(result$result, "PASS")
  expect_no_error(check_geog_level_completed(
    example_data,
    stop_on_error = TRUE
  ))
})

test_that("passes when regional columns are fully completed", {
  result <- check_geog_level_completed(regional_data)
  expect_equal(result$result, "PASS")
})

test_that("fails when one column is incomplete (singular)", {
  bad_data <- regional_data |>
    dplyr::mutate(region_code = NA_character_)
  result <- check_geog_level_completed(bad_data)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("region_code", result$message))
  expect_true(grepl("column is", result$message))
})

test_that("fails when multiple columns are incomplete (plural)", {
  bad_data <- regional_data |>
    dplyr::mutate(
      region_code = NA_character_,
      region_name = NA_character_
    )
  result <- check_geog_level_completed(bad_data)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("region_code", result$message))
  expect_true(grepl("region_name", result$message))
  expect_true(grepl("columns are", result$message))
  expect_error(check_geog_level_completed(bad_data, stop_on_error = TRUE))
})

test_that("skips new_la_code for local authority level", {
  la_data <- example_data |>
    dplyr::mutate(
      geographic_level = "Local authority",
      new_la_code = NA_character_,
      la_name = "Some LA",
      old_la_code = "123"
    )
  result <- check_geog_level_completed(la_data)
  expect_equal(result$result, "PASS")
})

test_that("fails when la_name is NA for local authority rows", {
  la_data <- example_data |>
    dplyr::mutate(
      geographic_level = "Local authority",
      new_la_code = "E10000001",
      la_name = NA_character_,
      old_la_code = "123"
    )
  result <- check_geog_level_completed(la_data)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("la_name", result$message))
})

test_that("fails when old_la_code is NA for local authority rows", {
  la_data <- example_data |>
    dplyr::mutate(
      geographic_level = "Local authority",
      new_la_code = "E10000001",
      la_name = "Some LA",
      old_la_code = NA_character_
    )
  result <- check_geog_level_completed(la_data)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("old_la_code", result$message))
})

test_that("fails when just one value in a column is NA", {
  bad_data <- regional_data |>
    dplyr::mutate(
      region_code = ifelse(
        dplyr::row_number() == 4,
        NA_character_,
        region_code
      )
    )
  result <- check_geog_level_completed(bad_data)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("region_code", result$message))
})

test_that("fails when just one value in a column is a blank string", {
  bad_data <- regional_data |>
    dplyr::mutate(
      region_name = ifelse(
        dplyr::row_number() == 2,
        "",
        region_name
      )
    )
  result <- check_geog_level_completed(bad_data)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("region_name", result$message))
})

test_that("passes silently when data only contains Planning area rows", {
  # Planning area is excluded from this check by design; those rows are
  # flagged as ignored by check_geog_ignored_rows() instead
  planning_data <- example_data |>
    dplyr::mutate(geographic_level = "Planning area")
  result <- check_geog_level_completed(planning_data)
  expect_equal(result$result, "PASS")
})

test_that("passes silently when expected columns are absent from data", {
  # Columns not present in the data at all are skipped here; their absence is
  # caught by check_geog_la_col_present() / check_geog_region_col_present()
  regional_no_cols <- example_data |>
    dplyr::mutate(geographic_level = "Regional")
  result <- check_geog_level_completed(regional_no_cols)
  expect_equal(result$result, "PASS")
})
