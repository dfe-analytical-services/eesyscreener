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

test_that("uses filter group columns in duplicate check", {
  meta_with_group <- example_meta
  meta_with_group$filter_grouping_column[1] <- "sex"
  # Adding a duplicate row that differs only on the indicator (not checked)
  dupe_data <- rbind(example_data, example_data[1, ])
  result <- check_general_dupes(dupe_data, meta_with_group)
  expect_equal(result$result, "FAIL")
})
