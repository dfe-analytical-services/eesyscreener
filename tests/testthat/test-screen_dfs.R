# TODO: Add more robust structure tests

test_that("passes for example files", {
  expect_no_error(suppressMessages(screen_dfs(
    example_data,
    example_meta,
    verbose = TRUE
  )))
  expect_no_error(screen_dfs(example_data, example_meta))
})

test_that("fails col prechecks", {
  missing_meta <- example_meta[, -1:-2]

  expect_error(
    screen_dfs(example_data, missing_meta, stop_on_error = TRUE),
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
    screen_dfs(example_data, gunsnroses_meta, stop_on_error = TRUE),
    "invalid col_type"
  )

  res_table <- screen_dfs(example_data, gunsnroses_meta)

  expect_equal(
    res_table[res_table$check == "meta_col_type", "result"],
    "FAIL"
  )
})

test_that("dd_checks = FALSE runs without error", {
  expect_no_error(screen_dfs(example_data, example_meta, dd_checks = FALSE))
})

test_that("dd_checks = FALSE excludes data dictionary checks", {
  res_table <- screen_dfs(example_data, example_meta, dd_checks = FALSE)
  expect_false("data_dict_col_name" %in% res_table$check)
  expect_false("data_dict_fil_item" %in% res_table$check)
  expect_false("harmonised_variables" %in% res_table$check)
  expect_false("harmonised_eth_vals" %in% res_table$check)
  expect_false("harmonised_eth_char_grp" %in% res_table$check)
  expect_false("harmonised_eth_char_vals" %in% res_table$check)
})

test_that("dd_checks = FALSE still runs base API checks", {
  res_table <- screen_dfs(example_data, example_meta, dd_checks = FALSE)
  expect_true("api_char_col_name" %in% res_table$check)
  expect_true("api_char_col_label" %in% res_table$check)
  expect_true("api_char_loc_code" %in% res_table$check)
  expect_true("api_char_filter_items" %in% res_table$check)
})
