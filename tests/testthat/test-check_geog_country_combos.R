test_that("passes with valid country combinations", {
  expect_equal(check_geog_country_combos(example_data)$result, "PASS")
  expect_no_error(check_geog_country_combos(example_data, stop_on_error = TRUE))
})

test_that("fails with one invalid country combination (singular message)", {
  bad_data <- example_data |>
    dplyr::mutate(
      country_code = "E92000001",
      country_name = "InvalidCountry"
    )
  result <- check_geog_country_combos(bad_data)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("E92000001 InvalidCountry", result$message))
  expect_true(grepl("combination is", result$message))
  expect_false(is.na(result$guidance_url))
})

test_that("fails with multiple invalid combinations (plural message)", {
  bad_data <- rbind(
    example_data |>
      dplyr::mutate(country_code = "BADCODE1", country_name = "BadCountry1"),
    example_data |>
      dplyr::mutate(country_code = "BADCODE2", country_name = "BadCountry2")
  )
  result <- check_geog_country_combos(bad_data)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("BADCODE1 BadCountry1", result$message))
  expect_true(grepl("BADCODE2 BadCountry2", result$message))
  expect_true(grepl("combinations are", result$message))
})

test_that("Ignores rows where country_code is 'x'", {
  na_data <- example_data |>
    dplyr::mutate(country_code = "x", country_name = "anything")
  result <- check_geog_country_combos(na_data)
  expect_equal(result$result, "PASS")
})

test_that("accepts z code combinations from universal geog options", {
  z_data <- example_data |>
    dplyr::mutate(country_code = "z", country_name = "Not applicable")
  result <- check_geog_country_combos(z_data)
  expect_equal(result$result, "PASS")
})
