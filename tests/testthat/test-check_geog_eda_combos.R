eda_data <- example_data |>
  dplyr::mutate(
    english_devolved_area_code = "E61000001",
    english_devolved_area_name = "Greater London Authority"
  )

test_that("passes when eda columns are absent", {
  result <- check_geog_eda_combos(example_data)
  expect_equal(result$result, "PASS")
  expect_no_error(check_geog_eda_combos(example_data, stop_on_error = TRUE))
})

test_that("passes with valid eda combos", {
  expect_equal(check_geog_eda_combos(eda_data)$result, "PASS")
  expect_no_error(check_geog_eda_combos(eda_data, stop_on_error = TRUE))
})

test_that("fails with one invalid eda combination (singular)", {
  bad_data <- eda_data |>
    dplyr::mutate(
      english_devolved_area_code = "BADCODE",
      english_devolved_area_name = "BadEDA"
    )
  result <- check_geog_eda_combos(bad_data)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("BADCODE BadEDA", result$message))
  expect_true(grepl("combination is", result$message))
  expect_false(is.na(result$guidance_url))
})

test_that("fails with multiple invalid eda combinations (plural)", {
  bad_data <- rbind(
    eda_data |>
      dplyr::mutate(
        english_devolved_area_code = "BADCODE1",
        english_devolved_area_name = "BadEDA1"
      ),
    eda_data |>
      dplyr::mutate(
        english_devolved_area_code = "BADCODE2",
        english_devolved_area_name = "BadEDA2"
      )
  )
  result <- check_geog_eda_combos(bad_data)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("BADCODE1 BadEDA1", result$message))
  expect_true(grepl("BADCODE2 BadEDA2", result$message))
  expect_true(grepl("combinations are", result$message))
})

test_that("ignores 'x' english_devolved_area_code", {
  x_eda <- eda_data |>
    dplyr::mutate(
      english_devolved_area_code = "x",
      english_devolved_area_name = "anything"
    )
  result <- check_geog_eda_combos(x_eda)
  expect_equal(result$result, "PASS")
})

test_that("accepts z code combinations from universal geog options", {
  z_data <- eda_data |>
    dplyr::mutate(
      english_devolved_area_code = "z",
      english_devolved_area_name = "Not applicable"
    )
  result <- check_geog_eda_combos(z_data)
  expect_equal(result$result, "PASS")
})
