lad_data <- example_data |>
  dplyr::mutate(
    geographic_level = "Local Authority District",
    lad_code = "E06000001",
    lad_name = "Hartlepool"
  )

test_that("passes when LAD columns are absent", {
  result <- check_geog_lad_combos(example_data)
  expect_equal(result$result, "PASS")
  expect_no_error(check_geog_lad_combos(example_data, stop_on_error = TRUE))
})

test_that("passes with valid LAD combos", {
  expect_equal(check_geog_lad_combos(lad_data)$result, "PASS")
  expect_no_error(check_geog_lad_combos(lad_data, stop_on_error = TRUE))
})

test_that("fails with one invalid LAD combination (singular)", {
  bad_data <- lad_data |>
    dplyr::mutate(lad_code = "BADCODE", lad_name = "BadLAD")
  result <- check_geog_lad_combos(bad_data)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("BADCODE BadLAD", result$message))
  expect_true(grepl("combination is", result$message))
  expect_false(is.na(result$guidance_url))
})

test_that("fails with multiple invalid LAD combinations (plural)", {
  bad_data <- rbind(
    lad_data |>
      dplyr::mutate(lad_code = "BADCODE1", lad_name = "BadLAD1"),
    lad_data |>
      dplyr::mutate(lad_code = "BADCODE2", lad_name = "BadLAD2")
  )
  result <- check_geog_lad_combos(bad_data)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("BADCODE1 BadLAD1", result$message))
  expect_true(grepl("BADCODE2 BadLAD2", result$message))
  expect_true(grepl("combinations are", result$message))
})

test_that("ignores rows where lad_code is 'x'", {
  x_data <- lad_data |>
    dplyr::mutate(lad_code = "x", lad_name = "anything")
  result <- check_geog_lad_combos(x_data)
  expect_equal(result$result, "PASS")
})

test_that("accepts z code combinations from universal geog options", {
  z_data <- lad_data |>
    dplyr::mutate(lad_code = "z", lad_name = "Not applicable")
  result <- check_geog_lad_combos(z_data)
  expect_equal(result$result, "PASS")
})
