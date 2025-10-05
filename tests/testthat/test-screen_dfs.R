# TODO: Add more robust structure tests

test_that("passes for example files", {
  expect_no_error(screen_dfs(example_data, example_meta, output = "error-only"))
})

test_that("fails with invalid col_type", {
  bad_meta <- example_meta
  bad_meta$col_type <- "November rain"

  expect_error(
    screen_dfs(example_data, bad_meta, output = "error-only"),
    "invalid col_type"
  )
})
