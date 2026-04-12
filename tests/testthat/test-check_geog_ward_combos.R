ward_data <- example_data |>
  dplyr::mutate(
    geographic_level = "Ward",
    ward_code = "S13003018",
    ward_name = "Penicuik"
  )

test_that("passes when ward columns are absent", {
  result <- check_geog_ward_combos(example_data)
  expect_equal(result$result, "PASS")
  expect_no_error(check_geog_ward_combos(example_data, stop_on_error = TRUE))
})

test_that("passes with valid ward combos", {
  expect_equal(check_geog_ward_combos(ward_data)$result, "PASS")
  expect_no_error(check_geog_ward_combos(ward_data, stop_on_error = TRUE))
})

test_that("fails with one invalid ward combination (singular)", {
  bad_data <- ward_data |>
    dplyr::mutate(ward_code = "BADCODE", ward_name = "BadWard")
  result <- check_geog_ward_combos(bad_data)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("BADCODE BadWard", result$message))
  expect_true(grepl("combination is", result$message))
  expect_false(is.na(result$guidance_url))
})

test_that("fails with multiple invalid ward combinations (plural)", {
  bad_data <- rbind(
    ward_data |>
      dplyr::mutate(ward_code = "BADCODE1", ward_name = "BadWard1"),
    ward_data |>
      dplyr::mutate(ward_code = "BADCODE2", ward_name = "BadWard2")
  )
  result <- check_geog_ward_combos(bad_data)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("BADCODE1 BadWard1", result$message))
  expect_true(grepl("BADCODE2 BadWard2", result$message))
  expect_true(grepl("combinations are", result$message))
})

test_that("fails for Ward rows with 'x' ward_code", {
  x_ward <- ward_data |>
    dplyr::mutate(ward_code = "x", ward_name = "anything")
  result <- check_geog_ward_combos(x_ward)
  expect_equal(result$result, "FAIL")
})

test_that("ignores 'x' ward_code for non-Ward rows", {
  national_with_x <- example_data |>
    dplyr::mutate(ward_code = "x", ward_name = "anything")
  result <- check_geog_ward_combos(national_with_x)
  expect_equal(result$result, "PASS")
})

test_that("accepts z code combinations from universal geog options", {
  z_data <- ward_data |>
    dplyr::mutate(ward_code = "z", ward_name = "Not applicable")
  result <- check_geog_ward_combos(z_data)
  expect_equal(result$result, "PASS")
})
