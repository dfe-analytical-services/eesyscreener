# Start by creating some temporary CSVs
# - these are cleaned up at the end of the script
data_file <- tempfile(fileext = ".csv")
meta_file <- tempfile(fileext = ".meta.csv")

data.table::fwrite(example_data, data_file)
data.table::fwrite(example_meta, meta_file)

output <- screen_csv(
  data_file,
  meta_file,
  "data.csv",
  "data.meta.csv"
)

test_that("Output structure is as expected", {
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
  expect_equal(output$overall_stage, "Passed")
  expect_equal(output$overall_message, "Passed all checks")

  expect_no_error(
    screen_csv(
      data_file,
      meta_file,
      "data.csv",
      "data.meta.csv"
    )
  )
})

test_that("Fails gracefully if files can't be found", {
  expect_error(
    screen_csv(
      "tartan_paint.csv",
      "tartan_paint.meta.csv"
    ),
    "No file found"
  )
})

test_that("Fails gracefully if it's not a CSV", {
  # Create temp .txt files
  txt_file <- tempfile(fileext = ".txt")
  txt_meta <- tempfile(fileext = ".txt")

  writeLines(c("This is not a CSV file"), txt_file)
  writeLines(c("This is not a CSV file"), txt_meta)

  expect_error(
    screen_csv(txt_file, txt_meta, output = "error-only"),
    "Data file"
  )
  # Data file created at top and cleaned at bottom of script
  expect_error(
    screen_csv(txt_file, meta_file, output = "error-only"),
    "Data file"
  )
  # Meta file created at top and cleaned at bottom of script
  expect_error(
    screen_csv(data_file, txt_meta, output = "error-only"),
    "Metadata file"
  )

  # Remove temp files
  file.remove(txt_file)
  file.remove(txt_meta)
})

test_that("Example file fails with filename", {
  expect_equal(
    screen_csv(
      data_file,
      meta_file,
      "data.csv",
      "meta.csv",
    )$overall_stage,
    "filename checks"
  )

  expect_error(
    screen_csv(
      data_file,
      meta_file,
      "data.csv",
      "meta.csv",
      output = "console"
    ),
    "The filenames do not follow the recommended naming convention"
  )
})

# TODO: add tests for different failure stages and edge cases

# Clean up temp files =========================================================
file.remove(data_file)
file.remove(meta_file)
