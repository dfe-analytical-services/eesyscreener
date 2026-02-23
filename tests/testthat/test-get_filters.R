test_that("get_filters returns expected structure and values", {
  meta <- example_meta
  meta$filter_grouping_column[1] <- "sex_group"
  result_all <- get_filters(meta, include_filter_groups = TRUE)

  expect_type(result_all, "character")
  expect_true("sex_group" %in% result_all)
  expect_true("sex" %in% result_all)
  expect_false(any(result_all == ""))
  expect_false(anyNA(result_all))
  expect_true(length(unique(result_all)) == length(result_all))
})

test_that("get_filters returns only filter columns", {
  result <- get_filters(example_meta, include_filter_groups = FALSE)

  expect_type(result, "character")
  expect_true("sex" %in% result)
  expect_false("sex_group" %in% result)
  expect_false(any(result == ""))
  expect_false(anyNA(result))
  expect_true(length(unique(result)) == length(result))
})
