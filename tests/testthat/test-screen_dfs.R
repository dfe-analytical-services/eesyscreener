# TODO: Add more robust structure tests

test_that("passes for example files", {
  expect_no_error(screen_dfs(example_data, example_meta, output = "error-only"))
  expect_no_error(screen_dfs(example_data, example_meta, output = "console"))
  expect_no_error(screen_dfs(example_data, example_meta))
})

test_that("fails col prechecks", {
  missing_meta <- example_meta[, -1:-2]

  expect_error(
    screen_dfs(example_data, missing_meta, output = "error-only"),
    "required columns are missing"
  )

  res_table <- screen_dfs(example_data, missing_meta)

  expect_equal(
    res_table[res_table$check == "col_req_meta", "result"],
    "FAIL"
  )
})

test_that("fails meta prechecks", {
  gunsnroses_meta <- example_meta
  gunsnroses_meta$col_type <- "November rain"

  expect_error(
    screen_dfs(example_data, gunsnroses_meta, output = "error-only"),
    "invalid col_type"
  )

  res_table <- screen_dfs(example_data, gunsnroses_meta)

  expect_equal(
    res_table[res_table$check == "meta_col_type", "result"],
    "FAIL"
  )
})
