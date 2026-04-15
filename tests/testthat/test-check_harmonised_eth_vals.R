eth_major_data <- example_data |>
  dplyr::mutate(ethnicity_major = "White")

eth_minor_data <- example_data |>
  dplyr::mutate(ethnicity_minor = "Irish")

eth_both_data <- example_data |>
  dplyr::mutate(
    ethnicity_major = "White",
    ethnicity_minor = "Irish"
  )

test_that("passes with example data (no ethnicity columns)", {
  result <- check_harmonised_eth_vals(example_data)
  expect_equal(result$result, "PASS")
  expect_no_error(
    check_harmonised_eth_vals(example_data, stop_on_error = TRUE)
  )
})

test_that("passes with valid ethnicity_major values", {
  expect_equal(check_harmonised_eth_vals(eth_major_data)$result, "PASS")
})

test_that("passes with valid ethnicity_minor values", {
  expect_equal(check_harmonised_eth_vals(eth_minor_data)$result, "PASS")
})

test_that("valid ethnicity_major and ethnicity_minor combinations", {
  expect_equal(check_harmonised_eth_vals(eth_both_data)$result, "PASS")
})

test_that("warns with one invalid ethnicity_major value (singular)", {
  bad_data <- eth_major_data |>
    dplyr::mutate(ethnicity_major = "Invalid Ethnicity")
  result <- check_harmonised_eth_vals(bad_data)
  expect_equal(result$result, "WARNING")
  expect_true(grepl("Invalid Ethnicity", result$message))
  expect_false(is.na(result$guidance_url))
  expect_warning(
    check_harmonised_eth_vals(bad_data, stop_on_error = TRUE),
    "Invalid Ethnicity"
  )
})

test_that("warns with multiple invalid ethnicity_major values (plural)", {
  bad_data <- rbind(
    eth_major_data |> dplyr::mutate(ethnicity_major = "Bad Ethnicity 1"),
    eth_major_data |> dplyr::mutate(ethnicity_major = "Bad Ethnicity 2")
  )
  result <- check_harmonised_eth_vals(bad_data)
  expect_equal(result$result, "WARNING")
  expect_true(grepl("Bad Ethnicity 1", result$message))
  expect_true(grepl("Bad Ethnicity 2", result$message))
})

test_that("warns with one invalid ethnicity_minor value (singular)", {
  bad_data <- eth_minor_data |>
    dplyr::mutate(ethnicity_minor = "Invalid Minor")
  result <- check_harmonised_eth_vals(bad_data)
  expect_equal(result$result, "WARNING")
  expect_true(grepl("Invalid Minor", result$message))
})

test_that("invalid ethnicity_major and ethnicity_minor combination", {
  bad_data <- eth_both_data |>
    dplyr::mutate(
      ethnicity_major = "White",
      ethnicity_minor = "Invalid Minor"
    )
  result <- check_harmonised_eth_vals(bad_data)
  expect_equal(result$result, "WARNING")
  expect_true(grepl("Invalid Minor", result$message))
  expect_true(grepl("combination", result$message))
})

test_that("passes when valid combination exists alongside invalid one", {
  mixed_data <- rbind(
    eth_both_data,
    eth_both_data |>
      dplyr::mutate(ethnicity_major = "White", ethnicity_minor = "Irish")
  )
  # Both combos are valid
  expect_equal(check_harmonised_eth_vals(mixed_data)$result, "PASS")
})
