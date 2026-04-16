test_that("passes with standard metadata column names", {
  result <- check_harmonised_variables(example_meta)
  expect_equal(result$result, "PASS")
  expect_no_error(
    check_harmonised_variables(example_meta, stop_on_error = TRUE)
  )
})

test_that("passes when no harmonised-pattern columns are present", {
  clean_meta <- example_meta |>
    dplyr::mutate(col_name = c("pupil_sex", "phase", "enrolment_count"))
  expect_equal(check_harmonised_variables(clean_meta)$result, "PASS")
})

test_that("fails with one non-standard harmonised column name (singular)", {
  bad_meta <- rbind(
    example_meta,
    data.frame(
      col_name = "ethnic_group",
      col_type = "Filter",
      label = "Ethnic group",
      indicator_grouping = "",
      indicator_unit = "",
      indicator_dp = NA,
      filter_hint = "",
      filter_grouping_column = "",
      filter_default = ""
    )
  )
  result <- check_harmonised_variables(bad_meta)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("ethnic_group", result$message))
  expect_false(is.na(result$guidance_url))
  expect_error(
    check_harmonised_variables(bad_meta, stop_on_error = TRUE),
    "ethnic_group"
  )
})

test_that("fails with multiple non-standard harmonised column names (plural)", {
  bad_meta <- rbind(
    example_meta,
    data.frame(
      col_name = c("ethnic_group", "sen_type"),
      col_type = "Filter",
      label = c("Ethnic group", "SEN type"),
      indicator_grouping = "",
      indicator_unit = "",
      indicator_dp = NA,
      filter_hint = "",
      filter_grouping_column = "",
      filter_default = ""
    )
  )
  result <- check_harmonised_variables(bad_meta)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("ethnic_group", result$message))
  expect_true(grepl("sen_type", result$message))
})

test_that("standard harmonised col names pass (e.g. ethnicity_major)", {
  good_meta <- rbind(
    example_meta,
    data.frame(
      col_name = "ethnicity_major",
      col_type = "Filter",
      label = "Ethnicity major",
      indicator_grouping = "",
      indicator_unit = "",
      indicator_dp = NA,
      filter_hint = "",
      filter_grouping_column = "",
      filter_default = ""
    )
  )
  expect_equal(check_harmonised_variables(good_meta)$result, "PASS")
})

test_that("catches non-standard harmonised name in filter_grouping_column", {
  bad_meta <- example_meta |>
    dplyr::mutate(
      filter_grouping_column = dplyr::if_else(
        .data$col_name == "sex",
        "ethnic_grp",
        .data$filter_grouping_column
      )
    )
  result <- check_harmonised_variables(bad_meta)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("ethnic_grp", result$message))
})
