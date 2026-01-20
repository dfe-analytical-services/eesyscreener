test_that("passes when all indicator_unit values are not present for when col_type is Filter ", {
  expect_equal(check_meta_ind_unit(example_meta)$message, "No filters have an indicator_unit value.")
  expect_no_error(check_meta_ind_unit(example_meta, stop_on_error = TRUE))
})

test_that("fails with one indicator_unit for a Filter", {
  meta <- data.frame(
    col_name = c("A", "B", "C"),
    col_type = c("Filter", "Filter", "Indicator"),
    label = c("Aa", "Bb", "Cc"),
    indicator_unit = c("2", "", ""),
    stringsAsFactors = FALSE
  )
  result <- check_meta_ind_unit(meta)
  expect_equal(result$result, "FAIL")
  expect_true(grepl(
    "Filters should not have an indicator_unit value in the metadata file. This occurs for columns: Aa at positions: 1.",
    result$message
  ))
})

test_that("gives column names and positions when multiple col_type Filters have a non-empty indicator unit", {
  meta <- data.frame(
    col_name = c("A", "B", "C"),
    col_type = c("Filter", "Filter", "Indicator"),
    label = c("Aa", "Bb", "Cc"),
    indicator_unit = c("1", "2", ""),
    stringsAsFactors = FALSE
  )
  result <- check_meta_ind_unit(meta)
  expect_equal(result$result, "FAIL")
  expect_true(grepl("Filters should not have an indicator_unit value in the metadata file. This occurs for columns: Aa, Bb at positions: 1, 2.", result$message))
})

test_that("Values in Indicator don't matter", {
  meta <- data.frame(
    col_name = c("A", "B", "C"),
    col_type = c("Filter", "Filter", "Indicator"),
    label = c("Aa", "Bb", "Cc"),
    indicator_unit = c("1", "", "0"),
    stringsAsFactors = FALSE
  )
  result <- check_meta_ind_unit(meta)
  expect_equal(result$result, "FAIL")
  expect_true(grepl(
    "Filters should not have an indicator_unit value in the metadata file. This occurs for columns: Aa at positions: 1.",
    result$message
  ))
})

test_that("NAs don't matter", {
  meta <- data.frame(
    col_name = c("A", "B", "C"),
    col_type = c("Filter", "Filter", "Indicator"),
    label = c("Aa", "Bb", "Cc"),
    indicator_unit = c(NA, "2", NA),
    stringsAsFactors = FALSE
  )
  expect_equal(check_meta_ind_unit(meta)$message, "Filters should not have an indicator_unit value in the metadata file. This occurs for columns: Bb at positions: 2.")
})


test_that("Passes when empty", {
  meta <- data.frame(
    col_name = c("A", "B", "C"),
    col_type = c("Filter", "Filter", "Indicator"),
    label = c("Aa", "Bb", "Cc"),
    indicator_unit = c("", "", "C"),
    stringsAsFactors = FALSE
  )
  expect_equal(check_meta_ind_unit(meta)$message, "No filters have an indicator_unit value.")
})
