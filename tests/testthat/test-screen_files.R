test_that("Output structure is as expected", {
  output <- screen_files(
    "data.csv",
    "data.meta.csv",
    example_data,
    example_meta
  )

  expect_type(output, "list")
  expect_length(output, 3)
  expect_equal(
    names(output),
    c("results_table", "overall_stage", "overall_message")
  )

  expect_equal(
    names(output$results_table),
    c("check", "result", "message", "guidance_url", "stage")
  )

  expect_equal(class(output$results_table), "data.frame")

  expect_equal(output$overall_stage, "Passed")
  expect_equal(output$overall_message, "Passed all checks")

  expect_equal(nrow(output$results_table), nrow(unique(output$results_table)))

  expect_true(all(
    output[["results_table"]][["result"]] %in% c("PASS", "FAIL", "ADVISORY")
  ))

  for (col in c("check", "message", "stage")) {
    expect_false(any(is.na(output$results_table[[col]])))
    expect_false(any(output$results_table[[col]] == ""))
  }
})

test_that("Example file passes", {
  expect_no_error(
    screen_files(
      "data.csv",
      "data.meta.csv",
      example_data,
      example_meta
    )
  )

  expect_equal(
    screen_files(
      "data.csv",
      "data.meta.csv",
      example_data,
      example_meta
    )$overall_stage,
    "Passed"
  )
})

# TODO: add tests for different output types
