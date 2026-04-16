char_val_data <- example_data |>
  dplyr::mutate(
    characteristic_group = "Ethnicity Major",
    characteristic = "White"
  )

test_that("passes with example data (no characteristic columns)", {
  result <- check_harmonised_eth_char_vals(example_data)
  expect_equal(result$result, "PASS")
  expect_no_error(
    check_harmonised_eth_char_vals(example_data, stop_on_error = TRUE)
  )
})

test_that("passes with data missing characteristic_group only", {
  no_grp <- example_data |>
    dplyr::mutate(characteristic = "White")
  expect_equal(check_harmonised_eth_char_vals(no_grp)$result, "PASS")
})

test_that("passes with valid ethnicity characteristic values", {
  expect_equal(check_harmonised_eth_char_vals(char_val_data)$result, "PASS")
})

test_that("passes when characteristic_group is not ethnicity-related", {
  non_eth_data <- example_data |>
    dplyr::mutate(
      characteristic_group = "Gender",
      characteristic = "Any Random Value"
    )
  expect_equal(check_harmonised_eth_char_vals(non_eth_data)$result, "PASS")
})

test_that("passes with valid minor ethnicity value", {
  minor_data <- char_val_data |>
    dplyr::mutate(
      characteristic_group = "Ethnicity Minor",
      characteristic = "Irish"
    )
  expect_equal(check_harmonised_eth_char_vals(minor_data)$result, "PASS")
})

test_that("one invalid ethnicity characteristic value (singular)", {
  bad_data <- char_val_data |>
    dplyr::mutate(characteristic = "Invalid Ethnicity")
  result <- check_harmonised_eth_char_vals(bad_data)
  expect_equal(result$result, "WARNING")
  expect_true(grepl("Invalid Ethnicity", result$message))
  expect_false(is.na(result$guidance_url))
  expect_warning(
    check_harmonised_eth_char_vals(bad_data, stop_on_error = TRUE),
    "Invalid Ethnicity"
  )
})

test_that("multiple invalid ethnicity characteristic values (plural)", {
  bad_data <- rbind(
    char_val_data |> dplyr::mutate(characteristic = "Bad Value 1"),
    char_val_data |> dplyr::mutate(characteristic = "Bad Value 2")
  )
  result <- check_harmonised_eth_char_vals(bad_data)
  expect_equal(result$result, "WARNING")
  expect_true(grepl("Bad Value 1", result$message))
  expect_true(grepl("Bad Value 2", result$message))
})

test_that("only validates characteristic values in eth-related groups", {
  mixed_data <- rbind(
    char_val_data,
    example_data |>
      dplyr::mutate(
        characteristic_group = "Gender",
        characteristic = "Invalid But Not Ethnicity"
      )
  )
  # The invalid value is under "Gender" not ethnicity, so should PASS
  expect_equal(check_harmonised_eth_char_vals(mixed_data)$result, "PASS")
})
