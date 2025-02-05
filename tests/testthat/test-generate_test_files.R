test_that("sub functions return a data frame", {
  expect_equal(
    generate_data_file(2010:2015, "Sheffield Central", "E14000919", 2, 3) |>
      class(),
    "data.frame"
  )
  expect_equal(
    generate_meta_file(2, 3) |>
      class(),
    "data.frame"
  )
})

test_that("generate_test_dfs returns a list", {
  expect_equal(
    generate_test_dfs(2010:2015, "Sheffield Central", "E14000919", 2, 3) |>
      class(),
    "list"
  )
})

test_that("generate_test_dfs returns a list with two data frames", {
  expect_equal(
    generate_test_dfs(2010:2015, "Sheffield Central", "E14000919", 2, 3)$data |>
      class(),
    "data.frame"
  )
  expect_equal(
    generate_test_dfs(2010:2015, "Sheffield Central", "E14000919", 2, 3)$meta |>
      class(),
    "data.frame"
  )
})

test_that("columns are as expected", {
  expect_equal(
    generate_data_file(2010:2015, "Sheffield Central", "E14000919", 2, 3) |>
      colnames(),
    c(
      "time_period",
      "time_identifier",
      "geographic_level",
      "country_name",
      "country_code",
      "pcon_name",
      "pcon_code",
      "filter1",
      "filter2",
      "indicator1",
      "indicator2",
      "indicator3"
    )
  )
  expect_equal(
    generate_meta_file(2, 3) |>
      colnames(),
    c(
      "col_name",
      "col_type",
      "label",
      "indicator_grouping",
      "indicator_unit",
      "indicator_dp",
      "filter_hint",
      "filter_grouping_column"
    )
  )
})

test_that("number of rows is expected", {
  expect_equal(
    nrow(generate_data_file(2010:2015, "Sheffield Central", "E14000919", 2, 3)),
    6 * 1 * 8 * 2
  )
  expect_equal(
    nrow(generate_meta_file(2, 3)),
    2 + 3
  )
})
