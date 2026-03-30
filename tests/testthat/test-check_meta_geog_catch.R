test_that("passes when no filters are geography columns", {
  meta <- data.frame(
    col_name = c("gender", "ethnicity", "headcount"),
    col_type = c("Filter", "Filter", "Indicator"),
    filter_grouping_column = c(NA, NA, NA),
    stringsAsFactors = FALSE
  )
  expect_equal(check_meta_geog_catch(meta)$result, "PASS")
  expect_no_error(check_meta_geog_catch(meta, stop_on_error = TRUE))
  expect_no_error(check_meta_geog_catch(
    example_meta,
    stop_on_error = TRUE
  ))
})

test_that("fails when one filter is a geography column", {
  meta <- data.frame(
    col_name = c("region_code", "gender", "headcount"),
    col_type = c("Filter", "Filter", "Indicator"),
    filter_grouping_column = c(NA, NA, NA),
    stringsAsFactors = FALSE
  )
  expect_equal(check_meta_geog_catch(meta)$result, "FAIL")
  expect_error(check_meta_geog_catch(meta, stop_on_error = TRUE))
  expect_true(grepl("region_code", check_meta_geog_catch(meta)$message))
})

test_that("fails when multiple filters are geography columns", {
  meta <- data.frame(
    col_name = c("region_code", "la_name", "headcount"),
    col_type = c("Filter", "Filter", "Indicator"),
    filter_grouping_column = c(NA, NA, NA),
    stringsAsFactors = FALSE
  )
  expect_equal(check_meta_geog_catch(meta)$result, "FAIL")
  expect_error(check_meta_geog_catch(meta, stop_on_error = TRUE))
  expect_true(grepl("region_code", check_meta_geog_catch(meta)$message))
  expect_true(grepl("la_name", check_meta_geog_catch(meta)$message))
})

test_that("catches exact geography column names", {
  geo_names <- c(
    "laestab",
    "estab",
    "urn",
    "ukprn",
    "region",
    "la",
    "lad",
    "rsc",
    "pcon",
    "lep",
    "mca",
    "oa",
    "ward",
    "mat"
  )
  for (geo_name in geo_names) {
    meta <- data.frame(
      col_name = c(geo_name, "gender", "headcount"),
      col_type = c("Filter", "Filter", "Indicator"),
      filter_grouping_column = c(NA, NA, NA),
      stringsAsFactors = FALSE
    )
    expect_equal(
      check_meta_geog_catch(meta)$result,
      "FAIL",
      info = paste("Should catch:", geo_name)
    )
  }
})

test_that("catches geography patterns with suffixes", {
  geo_patterns <- c(
    "school_name",
    "provider_code",
    "institution_urn",
    "la_code",
    "region_name",
    "pcon_code"
  )
  for (pattern in geo_patterns) {
    meta <- data.frame(
      col_name = c(pattern, "gender", "headcount"),
      col_type = c("Filter", "Filter", "Indicator"),
      filter_grouping_column = c(NA, NA, NA),
      stringsAsFactors = FALSE
    )
    expect_equal(
      check_meta_geog_catch(meta)$result,
      "FAIL",
      info = paste("Should catch:", pattern)
    )
  }
})

test_that("excludes school_name/provider_name when only filter", {
  meta_school <- data.frame(
    col_name = c("school_name", "headcount"),
    col_type = c("Filter", "Indicator"),
    filter_grouping_column = c(NA, NA),
    stringsAsFactors = FALSE
  )
  expect_equal(check_meta_geog_catch(meta_school)$result, "PASS")

  meta_provider <- data.frame(
    col_name = c("provider_name", "headcount"),
    col_type = c("Filter", "Indicator"),
    filter_grouping_column = c(NA, NA),
    stringsAsFactors = FALSE
  )
  expect_equal(check_meta_geog_catch(meta_provider)$result, "PASS")
})

test_that("catches school_name when not the only filter", {
  meta <- data.frame(
    col_name = c("school_name", "gender", "headcount"),
    col_type = c("Filter", "Filter", "Indicator"),
    filter_grouping_column = c(NA, NA, NA),
    stringsAsFactors = FALSE
  )
  expect_equal(check_meta_geog_catch(meta)$result, "FAIL")
})

test_that("catches geography columns in filter_grouping_column", {
  meta <- data.frame(
    col_name = c("gender", "headcount"),
    col_type = c("Filter", "Indicator"),
    filter_grouping_column = c("region_code", NA),
    stringsAsFactors = FALSE
  )
  expect_equal(check_meta_geog_catch(meta)$result, "FAIL")
  expect_true(grepl("region_code", check_meta_geog_catch(meta)$message))
})

test_that("passes when no filters exist", {
  meta <- data.frame(
    col_name = c("headcount", "enrolments"),
    col_type = c("Indicator", "Indicator"),
    filter_grouping_column = c(NA, NA),
    stringsAsFactors = FALSE
  )
  expect_equal(check_meta_geog_catch(meta)$result, "PASS")
})

test_that("is case insensitive", {
  meta <- data.frame(
    col_name = c("REGION_CODE", "gender", "headcount"),
    col_type = c("Filter", "Filter", "Indicator"),
    filter_grouping_column = c(NA, NA, NA),
    stringsAsFactors = FALSE
  )
  expect_equal(check_meta_geog_catch(meta)$result, "FAIL")
})

test_that("singular message for one caught filter", {
  meta <- data.frame(
    col_name = c("la_code", "gender", "headcount"),
    col_type = c("Filter", "Filter", "Indicator"),
    filter_grouping_column = c(NA, NA, NA),
    stringsAsFactors = FALSE
  )
  result <- check_meta_geog_catch(meta)
  expect_true(grepl("filter appears to be a geographic column", result$message))
})

test_that("plural message for multiple caught filters", {
  meta <- data.frame(
    col_name = c("la_code", "region_name", "headcount"),
    col_type = c("Filter", "Filter", "Indicator"),
    filter_grouping_column = c(NA, NA, NA),
    stringsAsFactors = FALSE
  )
  result <- check_meta_geog_catch(meta)
  expect_true(grepl(
    "filters appear to be geographic columns",
    result$message
  ))
})
