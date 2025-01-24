test_that("Output structure is as expected", {
  output <- screen_files(
    "data.csv",
    "data.meta.csv",
    example_data,
    example_data.meta
  )

  expect_type(output, "list")
  expect_length(output, 3)
  expect_equal(
    names(output),
    c("results_table", "overall_stage", "overall_message")
  )

  expect_equal(
    names(output$results_table),
    c("check", "result", "message", "stage")
  )

  expect_equal(class(output$results_table), "data.frame")

  expect_equal(output$overall_stage, "Passed")
  expect_equal(output$overall_message, "Passed all checks")

  expect_equal(nrow(output$results_table), nrow(unique(output$results_table)))

  expect_false(any(is.na(output$results_table)))
  expect_false(any(output$results_table == ""))
})
