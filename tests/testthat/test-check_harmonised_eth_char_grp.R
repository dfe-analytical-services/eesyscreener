char_grp_data <- example_data |>
  dplyr::mutate(characteristic_group = "Ethnicity Major")

test_that("passes with example data (no characteristic_group column)", {
  result <- check_harmonised_eth_char_grp(example_data)
  expect_equal(result$result, "PASS")
  expect_no_error(
    check_harmonised_eth_char_grp(example_data, stop_on_error = TRUE)
  )
})

test_that("passes with standard ethnicity characteristic_group values", {
  for (grp in c(
    "Ethnicity Major",
    "Ethnicity Minor",
    "Ethnicity Detailed",
    "Minority Ethnic"
  )) {
    data_grp <- example_data |>
      dplyr::mutate(characteristic_group = grp)
    expect_equal(
      check_harmonised_eth_char_grp(data_grp)$result,
      "PASS",
      info = paste("Expected PASS for:", grp)
    )
  }
})

test_that("passes with combined filter groups containing standard phrase", {
  combined_data <- example_data |>
    dplyr::mutate(characteristic_group = "Gender and Minority Ethnic")
  expect_equal(check_harmonised_eth_char_grp(combined_data)$result, "PASS")
})

test_that("passes when characteristic_group has non-ethnicity values only", {
  non_eth_data <- example_data |>
    dplyr::mutate(characteristic_group = "Gender")
  expect_equal(check_harmonised_eth_char_grp(non_eth_data)$result, "PASS")
})

test_that("one non-standard ethnicity characteristic_group (singular)", {
  bad_data <- char_grp_data |>
    dplyr::mutate(characteristic_group = "Ethnic Background")
  result <- check_harmonised_eth_char_grp(bad_data)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("Ethnic Background", result$message))
  expect_false(is.na(result$guidance_url))
  expect_error(
    check_harmonised_eth_char_grp(bad_data, stop_on_error = TRUE),
    "Ethnic Background"
  )
})

test_that("multiple non-standard ethnicity characteristic_groups (plural)", {
  bad_data <- rbind(
    example_data |> dplyr::mutate(characteristic_group = "Ethnic Background"),
    example_data |> dplyr::mutate(characteristic_group = "Ethnic Origin")
  )
  result <- check_harmonised_eth_char_grp(bad_data)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("Ethnic Background", result$message))
  expect_true(grepl("Ethnic Origin", result$message))
})

test_that("matching is case-insensitive for ethnicity detection", {
  # "ethnicity group" contains "ethnic" case-insensitively but is non-standard
  bad_data <- example_data |>
    dplyr::mutate(characteristic_group = "ETHNICITY GROUP")
  result <- check_harmonised_eth_char_grp(bad_data)
  expect_equal(result$result, "FAIL")
})
