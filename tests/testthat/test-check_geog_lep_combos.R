lep_data <- example_data |>
  dplyr::mutate(
    geographic_level = "Local Enterprise Partnership",
    local_enterprise_partnership_code = "E37000001",
    local_enterprise_partnership_name = "Black Country"
  )

test_that("passes when LEP columns are absent", {
  result <- check_geog_lep_combos(example_data)
  expect_equal(result$result, "PASS")
  expect_no_error(check_geog_lep_combos(example_data, stop_on_error = TRUE))
})

test_that("passes with valid LEP combos", {
  expect_equal(check_geog_lep_combos(lep_data)$result, "PASS")
  expect_no_error(check_geog_lep_combos(lep_data, stop_on_error = TRUE))
})

test_that("fails with one invalid LEP combination (singular)", {
  bad_data <- lep_data |>
    dplyr::mutate(
      local_enterprise_partnership_code = "BADCODE",
      local_enterprise_partnership_name = "BadLEP"
    )
  result <- check_geog_lep_combos(bad_data)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("BADCODE BadLEP", result$message))
  expect_true(grepl("combination is", result$message))
  expect_false(is.na(result$guidance_url))
})

test_that("fails with multiple invalid LEP combinations (plural)", {
  bad_data <- rbind(
    lep_data |>
      dplyr::mutate(
        local_enterprise_partnership_code = "BADCODE1",
        local_enterprise_partnership_name = "BadLEP1"
      ),
    lep_data |>
      dplyr::mutate(
        local_enterprise_partnership_code = "BADCODE2",
        local_enterprise_partnership_name = "BadLEP2"
      )
  )
  result <- check_geog_lep_combos(bad_data)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("BADCODE1 BadLEP1", result$message))
  expect_true(grepl("BADCODE2 BadLEP2", result$message))
  expect_true(grepl("combinations are", result$message))
})

test_that("ignores rows where local_enterprise_partnership_code is 'x'", {
  x_data <- lep_data |>
    dplyr::mutate(
      local_enterprise_partnership_code = "x",
      local_enterprise_partnership_name = "anything"
    )
  result <- check_geog_lep_combos(x_data)
  expect_equal(result$result, "PASS")
})

test_that("accepts z code combinations from universal geog options", {
  z_data <- lep_data |>
    dplyr::mutate(
      local_enterprise_partnership_code = "z",
      local_enterprise_partnership_name = "Not applicable"
    )
  result <- check_geog_lep_combos(z_data)
  expect_equal(result$result, "PASS")
})
