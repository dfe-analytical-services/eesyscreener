skip_integration_tests()

test_that("passes for example files", {
  expect_no_error(suppressMessages(screen_dfs(
    example_data,
    example_meta,
    verbose = TRUE,
    use_duckdb = FALSE
  )))
  expect_no_error(screen_dfs(example_data, example_meta, use_duckdb = FALSE))
  expect_no_error(screen_dfs(example_data, example_meta, use_duckdb = TRUE))
})

test_that("fails col prechecks", {
  missing_meta <- example_meta[, -1:-2]

  expect_error(
    screen_dfs(
      example_data,
      missing_meta,
      stop_on_error = TRUE,
      use_duckdb = FALSE
    ),
    "required columns are missing"
  )

  res_table <- screen_dfs(example_data, missing_meta, use_duckdb = FALSE)

  expect_equal(
    res_table[res_table$check == "col_req_meta", "result"],
    "FAIL"
  )
})

test_that("fails meta prechecks", {
  gunsnroses_meta <- example_meta
  gunsnroses_meta$col_type <- "November rain"

  expect_error(
    screen_dfs(
      example_data,
      gunsnroses_meta,
      stop_on_error = TRUE,
      use_duckdb = FALSE
    ),
    "invalid col_type"
  )

  res_table <- screen_dfs(example_data, gunsnroses_meta, use_duckdb = FALSE)

  expect_equal(
    res_table[res_table$check == "meta_col_type", "result"],
    "FAIL"
  )
})

test_that("dd_checks = FALSE runs without error", {
  expect_no_error(screen_dfs(
    example_data,
    example_meta,
    dd_checks = FALSE,
    use_duckdb = FALSE
  ))
})

test_that("dd_checks = FALSE excludes data dictionary checks", {
  res_table <- screen_dfs(
    example_data,
    example_meta,
    dd_checks = FALSE,
    use_duckdb = FALSE
  )
  expect_false("data_dict_col_name" %in% res_table$check)
  expect_false("data_dict_fil_item" %in% res_table$check)
  expect_false("harmonised_variables" %in% res_table$check)
  expect_false("harmonised_eth_vals" %in% res_table$check)
  expect_false("harmonised_eth_char_grp" %in% res_table$check)
  expect_false("harmonised_eth_char_vals" %in% res_table$check)
})

test_that("dd_checks = FALSE still runs base API checks", {
  res_table <- screen_dfs(
    example_data,
    example_meta,
    dd_checks = FALSE,
    use_duckdb = FALSE
  )
  expect_true("api_char_col_name" %in% res_table$check)
  expect_true("api_char_col_label" %in% res_table$check)
  expect_true("api_char_loc_code" %in% res_table$check)
  expect_true("api_char_filter_items" %in% res_table$check)
})

test_that("use_duckdb = FALSE path matches use_duckdb = TRUE path", {
  # Pins the contract that screen_csv()'s <5 MB branch (use_duckdb = FALSE)
  # produces the same per-check results as the duckdb branch. Without this,
  # a regression in the in-memory path (e.g. an assumption of a duckdb tibble
  # leaking into a check, or methods_overwrite() state bleeding across calls)
  # would go undetected in CI.
  #
  # We drive screen_dfs() directly rather than generating a >5 MB CSV because:
  #   (a) the only behavioural difference between the routes lives behind the
  #       use_duckdb flag inside screen_dfs(), so testing it at this layer
  #       pins the contract without CSV I/O overhead;
  #   (b) generate_test_dfs() at 5 MB+ adds meaningful CI time for no extra
  #       coverage over what this test already gives;
  #   (c) existing tests in test-screen_csv.R already exercise screen_csv()
  #       on example_data (<1 KB), which hits the use_duckdb = FALSE branch
  #       end-to-end including file size detection.
  small <- suppressMessages(
    screen_dfs(example_data, example_meta, use_duckdb = FALSE)
  )
  big <- suppressMessages(
    screen_dfs(example_data, example_meta, use_duckdb = TRUE)
  )
  # Same checks, same results, same order — anything else indicates the
  # two execution paths have diverged.
  expect_equal(small$check, big$check)
  expect_equal(small$result, big$result)
})
