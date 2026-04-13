test_that("passes with example data (no duplicates)", {
  result <- check_general_dupes(example_data, example_meta)
  expect_equal(result$result, "PASS")
  expect_no_error(check_general_dupes(
    example_data,
    example_meta,
    stop_on_error = TRUE
  ))
})

test_that("fails with one duplicate row (singular)", {
  dupe_data <- rbind(example_data, example_data[1, ])
  result <- check_general_dupes(dupe_data, example_meta)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("1 duplicate row", result$message))
  expect_true(grepl("There is", result$message))
  expect_error(check_general_dupes(
    dupe_data,
    example_meta,
    stop_on_error = TRUE
  ))
})

test_that("fails with multiple duplicate rows (plural)", {
  dupe_data <- rbind(example_data, example_data[1:2, ])
  result <- check_general_dupes(dupe_data, example_meta)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("2 duplicate rows", result$message))
  expect_true(grepl("There are", result$message))
})

test_that("pass message notes which rows were excluded", {
  result <- check_general_dupes(example_data, example_meta)
  expect_true(grepl(
    "School, Provider, Institution, and Planning area",
    result$message
  ))
})

test_that("excludes only Institution and Planning area for School-only data", {
  school_data <- example_data |>
    dplyr::mutate(
      geographic_level = "School",
      school_urn = paste0("URN", dplyr::row_number()),
      school_name = paste0("School ", dplyr::row_number())
    )
  result <- check_general_dupes(school_data, example_meta)
  expect_equal(result$result, "PASS")
  expect_true(grepl("Institution and Planning area", result$message))
  expect_false(grepl("School,", result$message))
})

test_that("detects duplicates in School-only data", {
  school_data <- example_data |>
    dplyr::mutate(
      geographic_level = "School",
      school_urn = paste0("URN", dplyr::row_number()),
      school_name = paste0("School ", dplyr::row_number())
    )
  dupe_school <- rbind(school_data, school_data[1, ])
  result <- check_general_dupes(dupe_school, example_meta)
  expect_equal(result$result, "FAIL")
})

test_that("excludes only Institution and Planning area for Provider-only", {
  provider_data <- example_data |>
    dplyr::mutate(
      geographic_level = "Provider",
      provider_urn = paste0("URN", dplyr::row_number()),
      provider_name = paste0("Provider ", dplyr::row_number())
    )
  result <- check_general_dupes(provider_data, example_meta)
  expect_equal(result$result, "PASS")
  expect_true(grepl("Institution and Planning area", result$message))
  expect_false(grepl("Provider,", result$message))
})

test_that("detects duplicates in Provider-only data", {
  provider_data <- example_data |>
    dplyr::mutate(
      geographic_level = "Provider",
      provider_urn = paste0("URN", dplyr::row_number()),
      provider_name = paste0("Provider ", dplyr::row_number())
    )
  dupe_provider <- rbind(provider_data, provider_data[1, ])
  result <- check_general_dupes(dupe_provider, example_meta)
  expect_equal(result$result, "FAIL")
})

test_that("ignores rows at excluded geographic levels", {
  mixed_data <- example_data |>
    dplyr::mutate(geographic_level = "National")
  # Add a school row that would be a duplicate if not excluded
  school_row <- example_data[1, ] |>
    dplyr::mutate(geographic_level = "School")
  mixed_data <- rbind(mixed_data, school_row, school_row)
  result <- check_general_dupes(mixed_data, example_meta)
  expect_equal(result$result, "PASS")
})

test_that("filter group columns are included in the duplicate check key", {
  # Add a grouping column to the data that is not itself listed as a filter
  data_with_group_col <- example_data |>
    dplyr::mutate(sex_group = "All")

  # Meta referencing sex_group as the filter grouping column for sex
  meta_with_group <- example_meta
  meta_with_group$filter_grouping_column[1] <- "sex_group"

  # Two rows identical in all filter columns but with different sex_group values
  row_a <- data_with_group_col[1, ] |> dplyr::mutate(sex_group = "Group A")
  row_b <- data_with_group_col[1, ] |> dplyr::mutate(sex_group = "Group B")
  combined <- rbind(data_with_group_col, row_a, row_b)

  # With sex_group in the key: row_a and row_b are distinct, no duplicates
  expect_equal(check_general_dupes(combined, meta_with_group)$result, "PASS")

  # Without sex_group in the key: row_a and row_b look identical → FAIL
  expect_equal(check_general_dupes(combined, example_meta)$result, "FAIL")
})

test_that("return_dupes returns empty data frame with all columns", {
  result <- check_general_dupes(example_data, example_meta, return_dupes = TRUE)
  expect_s3_class(result, "data.frame")
  expect_equal(nrow(result), 0)
  expect_equal(names(result), names(example_data))
})

test_that("return_dupes returns all copies of duplicated rows with all cols", {
  dupe_data <- rbind(example_data, example_data[1:2, ])
  result <- check_general_dupes(dupe_data, example_meta, return_dupes = TRUE)
  expect_s3_class(result, "data.frame")
  # 2 original + 2 copies = 4 rows where the key appears more than once
  expect_equal(nrow(result), 4)
  expect_equal(names(result), names(dupe_data))
})

test_that("return_dupes excludes rows at excluded geographic levels", {
  national_data <- example_data |>
    dplyr::mutate(geographic_level = "National")
  school_row <- example_data[1, ] |>
    dplyr::mutate(geographic_level = "School")
  mixed_data <- rbind(national_data, school_row, school_row)
  result <- check_general_dupes(mixed_data, example_meta, return_dupes = TRUE)
  expect_equal(nrow(result), 0)
})
