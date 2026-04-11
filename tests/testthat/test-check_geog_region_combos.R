regional_data <- example_data |>
  dplyr::mutate(
    geographic_level = "Regional",
    region_code = "E12000001",
    region_name = "North East"
  )

test_that("passes when region columns are absent", {
  result <- check_geog_region_combos(example_data)
  expect_equal(result$result, "PASS")
  expect_no_error(check_geog_region_combos(example_data, stop_on_error = TRUE))
})

test_that("passes with valid regional combos", {
  expect_equal(check_geog_region_combos(regional_data)$result, "PASS")
  expect_no_error(
    check_geog_region_combos(regional_data, stop_on_error = TRUE)
  )
})

test_that("fails with one invalid regional combination (singular)", {
  bad_data <- regional_data |>
    dplyr::mutate(region_code = "E12000001", region_name = "BadRegion")
  result <- check_geog_region_combos(bad_data)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("E12000001 BadRegion", result$message))
  expect_true(grepl("combination is", result$message))
  expect_false(is.na(result$guidance_url))
})

test_that("fails with multiple invalid regional combinations (plural)", {
  bad_data <- rbind(
    regional_data |>
      dplyr::mutate(region_code = "BADCODE1", region_name = "BadRegion1"),
    regional_data |>
      dplyr::mutate(region_code = "BADCODE2", region_name = "BadRegion2")
  )
  result <- check_geog_region_combos(bad_data)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("BADCODE1 BadRegion1", result$message))
  expect_true(grepl("BADCODE2 BadRegion2", result$message))
  expect_true(grepl("combinations are", result$message))
})

test_that("fails for Regional rows with 'x' region_code", {
  x_regional <- regional_data |>
    dplyr::mutate(region_code = "x", region_name = "anything")
  result <- check_geog_region_combos(x_regional)
  expect_equal(result$result, "FAIL")
})

test_that("ignores 'x' region_code for non-Regional rows", {
  national_with_x <- example_data |>
    dplyr::mutate(region_code = "x", region_name = "anything")
  result <- check_geog_region_combos(national_with_x)
  expect_equal(result$result, "PASS")
})

test_that("accepts z code combinations from universal geog options", {
  z_data <- regional_data |>
    dplyr::mutate(region_code = "z", region_name = "Not applicable")
  result <- check_geog_region_combos(z_data)
  expect_equal(result$result, "PASS")
})
