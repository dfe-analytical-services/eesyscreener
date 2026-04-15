# Test data for filter item checks =============================================

# example_meta has sex (Filter) and education_phase (Filter), both in the
# data dictionary. Replacing "All pupils" and "All phases" with valid items
# creates a passing dataset for check_data_dict_fil_item.
dd_pass_data <- example_data |>
  dplyr::mutate(
    sex = dplyr::if_else(.data$sex == "All pupils", "Male", .data$sex),
    education_phase = dplyr::if_else(
      .data$education_phase == "All phases",
      "Primary",
      .data$education_phase
    )
  )

# Meta with only sex as a filter column (used for singular test)
sex_only_meta <- example_meta |>
  dplyr::filter(
    .data$col_type != "Filter" | .data$col_name == "sex"
  )

# check_data_dict_col_name =====================================================

test_that("passes when all col_names are in the data dictionary", {
  result <- check_data_dict_col_name(example_meta)
  expect_equal(result$result, "PASS")
  expect_no_error(check_data_dict_col_name(example_meta, stop_on_error = TRUE))
})

test_that("warns when a filter col_name is not in the data dictionary", {
  bad_meta <- example_meta |>
    dplyr::mutate(
      col_name = dplyr::if_else(
        .data$col_name == "sex",
        "non_standard_filter",
        .data$col_name
      )
    )
  result <- check_data_dict_col_name(bad_meta)
  expect_equal(result$result, "WARNING")
  expect_true(grepl("non_standard_filter", result$message))
  expect_true(grepl("Filters:", result$message))
  expect_false(is.na(result$guidance_url))
})

test_that("warns when an indicator col_name is not in the data dictionary", {
  bad_meta <- example_meta |>
    dplyr::mutate(
      col_name = dplyr::if_else(
        .data$col_name == "enrolment_count",
        "non_standard_indicator",
        .data$col_name
      )
    )
  result <- check_data_dict_col_name(bad_meta)
  expect_equal(result$result, "WARNING")
  expect_true(grepl("non_standard_indicator", result$message))
  expect_true(grepl("Indicators:", result$message))
})

test_that("warns for multiple non-standard col_names across types", {
  bad_meta <- example_meta |>
    dplyr::mutate(
      col_name = dplyr::case_when(
        .data$col_name == "sex" ~ "bad_filter_one",
        .data$col_name == "education_phase" ~ "bad_filter_two",
        .data$col_name == "enrolment_count" ~ "bad_indicator",
        .default = .data$col_name
      )
    )
  result <- check_data_dict_col_name(bad_meta)
  expect_equal(result$result, "WARNING")
  expect_true(grepl("bad_filter_one", result$message))
  expect_true(grepl("bad_filter_two", result$message))
  expect_true(grepl("bad_indicator", result$message))
})

# check_data_dict_fil_item =====================================================

test_that("passes when all filter items are in the data dictionary", {
  result <- check_data_dict_fil_item(dd_pass_data, example_meta)
  expect_equal(result$result, "PASS")
  expect_no_error(
    check_data_dict_fil_item(dd_pass_data, example_meta, stop_on_error = TRUE)
  )
})

test_that("passes when no metadata filter columns are in the data dictionary", {
  no_dd_meta <- example_meta |>
    dplyr::mutate(col_name = paste0("custom_", .data$col_name))
  result <- check_data_dict_fil_item(example_data, no_dd_meta)
  expect_equal(result$result, "PASS")
  expect_true(grepl("No data dictionary filter columns", result$message))
})

test_that("warns with singular message for one non-standard filter item", {
  single_bad <- example_data |>
    dplyr::mutate(sex = "Nonbinary")
  result <- check_data_dict_fil_item(single_bad, sex_only_meta)
  expect_equal(result$result, "WARNING")
  expect_true(grepl("sex/Nonbinary", result$message))
  expect_true(grepl("combination is", result$message))
  expect_false(is.na(result$guidance_url))
})

test_that("warns with plural message for multiple non-standard filter items", {
  multi_bad <- example_data |>
    dplyr::mutate(
      sex = dplyr::case_when(
        .data$sex == "All pupils" ~ "Nonbinary",
        .data$sex == "Male" ~ "Unknown",
        .default = .data$sex
      )
    )
  result <- check_data_dict_fil_item(multi_bad, sex_only_meta)
  expect_equal(result$result, "WARNING")
  expect_true(grepl("sex/Nonbinary", result$message))
  expect_true(grepl("sex/Unknown", result$message))
  expect_true(grepl("combinations are", result$message))
})

test_that("warns for non-standard items across multiple filter columns", {
  result <- check_data_dict_fil_item(example_data, example_meta)
  expect_equal(result$result, "WARNING")
  expect_true(grepl("sex/All pupils", result$message))
  expect_true(grepl("education_phase/All phases", result$message))
})
