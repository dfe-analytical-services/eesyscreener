mat_data <- example_data |>
  dplyr::mutate(
    geographic_level = "MAT",
    trust_id = "MAT001",
    trust_name = "Academy Trust A"
  )

test_that("passes when no lower-level geography levels are present", {
  result <- check_geog_other_code_dupes(example_data)
  expect_equal(result$result, "PASS")
  expect_true(grepl("not present", result$message))
  expect_no_error(check_geog_other_code_dupes(
    example_data,
    stop_on_error = TRUE
  ))
})

test_that("passes with valid one-to-one code to name mapping", {
  result <- check_geog_other_code_dupes(mat_data)
  expect_equal(result$result, "PASS")
  expect_true(grepl("Every geography code", result$message))
  expect_no_error(check_geog_other_code_dupes(mat_data, stop_on_error = TRUE))
})

test_that("fails when one code has multiple names (singular)", {
  bad_data <- rbind(
    mat_data |> dplyr::mutate(trust_name = "Trust A"),
    mat_data |> dplyr::mutate(trust_name = "Trust B")
  )
  result <- check_geog_other_code_dupes(bad_data)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("MAT001", result$message))
  expect_true(grepl("2 different names", result$message))
  expect_true(grepl("code has", result$message))
})

test_that("fails when multiple codes have multiple names (plural)", {
  bad_data <- rbind(
    mat_data |> dplyr::mutate(trust_id = "MAT001", trust_name = "Trust A"),
    mat_data |> dplyr::mutate(trust_id = "MAT001", trust_name = "Trust B"),
    mat_data |> dplyr::mutate(trust_id = "MAT002", trust_name = "Trust C"),
    mat_data |> dplyr::mutate(trust_id = "MAT002", trust_name = "Trust D")
  )
  result <- check_geog_other_code_dupes(bad_data)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("MAT001", result$message))
  expect_true(grepl("MAT002", result$message))
  expect_true(grepl("codes have", result$message))
  expect_error(check_geog_other_code_dupes(bad_data, stop_on_error = TRUE))
})

test_that("passes when lower-level level is present but columns are absent", {
  no_cols_data <- example_data |>
    dplyr::mutate(geographic_level = "MAT")
  result <- check_geog_other_code_dupes(no_cols_data)
  expect_equal(result$result, "PASS")
})

test_that("passes when code column contains NA or blank values", {
  na_data <- rbind(
    mat_data,
    mat_data |> dplyr::mutate(trust_id = NA, trust_name = "Unknown"),
    mat_data |> dplyr::mutate(trust_id = "", trust_name = "Also Unknown")
  )
  result <- check_geog_other_code_dupes(na_data)
  expect_equal(result$result, "PASS")
})

test_that("checks across all lower-level geography types", {
  sponsor_data <- example_data |>
    dplyr::mutate(
      geographic_level = "Sponsor",
      sponsor_id = "SP001",
      sponsor_name = "Sponsor A"
    )
  bad_sponsor_data <- rbind(
    sponsor_data |> dplyr::mutate(sponsor_name = "Sponsor A"),
    sponsor_data |> dplyr::mutate(sponsor_name = "Sponsor B")
  )
  result <- check_geog_other_code_dupes(bad_sponsor_data)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("SP001", result$message))
})
