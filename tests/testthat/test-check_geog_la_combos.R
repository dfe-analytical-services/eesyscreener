la_data <- example_data |>
  dplyr::mutate(
    geographic_level = "Local Authority",
    old_la_code = "805",
    new_la_code = "E06000001",
    la_name = "Hartlepool"
  )

test_that("passes when LA columns are absent", {
  result <- check_geog_la_combos(example_data)
  expect_equal(result$result, "PASS")
  expect_no_error(check_geog_la_combos(example_data, stop_on_error = TRUE))
})

test_that("passes with valid LA combos", {
  expect_equal(check_geog_la_combos(la_data)$result, "PASS")
  expect_no_error(check_geog_la_combos(la_data, stop_on_error = TRUE))
})

test_that("fails with one invalid LA combination (singular)", {
  bad_data <- la_data |>
    dplyr::mutate(
      old_la_code = "999",
      new_la_code = "BADCODE",
      la_name = "BadLA"
    )
  result <- check_geog_la_combos(bad_data)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("999 BADCODE BadLA", result$message))
  expect_true(grepl("combination is", result$message))
  expect_false(is.na(result$guidance_url))
})

test_that("fails with multiple invalid LA combinations (plural)", {
  bad_data <- rbind(
    la_data |>
      dplyr::mutate(
        old_la_code = "998",
        new_la_code = "BADCODE1",
        la_name = "BadLA1"
      ),
    la_data |>
      dplyr::mutate(
        old_la_code = "999",
        new_la_code = "BADCODE2",
        la_name = "BadLA2"
      )
  )
  result <- check_geog_la_combos(bad_data)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("998 BADCODE1 BadLA1", result$message))
  expect_true(grepl("999 BADCODE2 BadLA2", result$message))
  expect_true(grepl("combinations are", result$message))
})

test_that("ignores rows where new_la_code is 'x'", {
  x_data <- la_data |>
    dplyr::mutate(new_la_code = "x", la_name = "anything")
  result <- check_geog_la_combos(x_data)
  expect_equal(result$result, "PASS")
})

test_that("ignores rows where any LA column is NA", {
  na_data <- la_data |>
    dplyr::mutate(
      old_la_code = NA_character_,
      new_la_code = "BADCODE",
      la_name = "BadLA"
    )
  result <- check_geog_la_combos(na_data)
  expect_equal(result$result, "PASS")
})

test_that("accepts z code combinations from universal geog options", {
  z_data <- la_data |>
    dplyr::mutate(
      old_la_code = "z",
      new_la_code = "z",
      la_name = "Not applicable"
    )
  result <- check_geog_la_combos(z_data)
  expect_equal(result$result, "PASS")
})
