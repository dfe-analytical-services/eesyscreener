test_that("Checks do not pull large data into memory", {
  # This test runs the checks in stingy mode, which refuses to run if a check
  # attempts to materialise the data.
  # More info here: https://duckplyr.tidyverse.org/articles/prudence.html
  # If a test really needs to break this test, then we'll need to do some
  # development on the EES infrastructure side of things to allow that to run
  # successfully.
  expect_no_error(
    screen_dfs(example_comma_data, example_comma_meta, prudence = "stingy")
  )
})
