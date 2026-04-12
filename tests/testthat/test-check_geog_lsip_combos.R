lsip_data <- example_data |>
  dplyr::mutate(
    geographic_level = "Local skills improvement plan area",
    lsip_code = "E69000002",
    lsip_name = "Buckinghamshire"
  )

test_that("passes when lsip columns are absent", {
  result <- check_geog_lsip_combos(example_data)
  expect_equal(result$result, "PASS")
  expect_no_error(check_geog_lsip_combos(example_data, stop_on_error = TRUE))
})

test_that("passes with valid lsip combos", {
  expect_equal(check_geog_lsip_combos(lsip_data)$result, "PASS")
  expect_no_error(check_geog_lsip_combos(lsip_data, stop_on_error = TRUE))
})

test_that("fails with one invalid lsip combination (singular)", {
  bad_data <- lsip_data |>
    dplyr::mutate(lsip_code = "BADCODE", lsip_name = "BadLSIP")
  result <- check_geog_lsip_combos(bad_data)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("BADCODE BadLSIP", result$message))
  expect_true(grepl("combination is", result$message))
  expect_false(is.na(result$guidance_url))
})

test_that("fails with multiple invalid lsip combinations (plural)", {
  bad_data <- rbind(
    lsip_data |>
      dplyr::mutate(lsip_code = "BADCODE1", lsip_name = "BadLSIP1"),
    lsip_data |>
      dplyr::mutate(lsip_code = "BADCODE2", lsip_name = "BadLSIP2")
  )
  result <- check_geog_lsip_combos(bad_data)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("BADCODE1 BadLSIP1", result$message))
  expect_true(grepl("BADCODE2 BadLSIP2", result$message))
  expect_true(grepl("combinations are", result$message))
})

test_that("fails for LSIP rows with 'x' lsip_code", {
  x_lsip <- lsip_data |>
    dplyr::mutate(lsip_code = "x", lsip_name = "anything")
  result <- check_geog_lsip_combos(x_lsip)
  expect_equal(result$result, "FAIL")
})

test_that("ignores 'x' lsip_code for non-LSIP rows", {
  national_with_x <- example_data |>
    dplyr::mutate(lsip_code = "x", lsip_name = "anything")
  result <- check_geog_lsip_combos(national_with_x)
  expect_equal(result$result, "PASS")
})

test_that("accepts z code combinations from universal geog options", {
  z_data <- lsip_data |>
    dplyr::mutate(lsip_code = "z", lsip_name = "Not applicable")
  result <- check_geog_lsip_combos(z_data)
  expect_equal(result$result, "PASS")
})
