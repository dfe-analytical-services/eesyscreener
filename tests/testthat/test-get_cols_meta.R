test_that("get_cols_meta returns col_name by default", {
  meta <- data.frame(
    col_name = c("a", "b", "c"),
    filter_grouping_column = c("g1", "g2", "g3")
  )
  expect_equal(
    sort(get_cols_meta(meta)),
    c("a", "b", "c")
  )
})

test_that("get_cols_meta includes grouping columns if requested", {
  meta <- data.frame(
    col_name = c("a", "b", "c"),
    filter_grouping_column = c("g1", "g2", "g3")
  )
  expect_equal(
    sort(get_cols_meta(meta, grouping_cols = TRUE)),
    sort(c("a", "b", "c", "g1", "g2", "g3"))
  )
})

test_that("get_cols_meta returns unique values", {
  meta <- data.frame(
    col_name = c("a", "b", "a"),
    filter_grouping_column = c("g1", "g2", "g1")
  )
  expect_equal(
    sort(get_cols_meta(meta, grouping_cols = TRUE)),
    sort(c("a", "b", "g1", "g2"))
  )
  meta <- data.frame(
    col_name = c("a", "b", "a"),
    filter_grouping_column = c("a", "a", "g1")
  )
  expect_equal(
    sort(get_cols_meta(meta, grouping_cols = TRUE)),
    sort(c("a", "b", "g1"))
  )
})

test_that("removes empty strings and NAs", {
  meta <- data.frame(
    col_name = c("a", "b", "", NA),
    filter_grouping_column = c("g1", "", NA, "g2")
  )
  expect_equal(
    sort(get_cols_meta(meta, grouping_cols = TRUE)),
    sort(c("a", "b", "g1", "g2"))
  )
})
