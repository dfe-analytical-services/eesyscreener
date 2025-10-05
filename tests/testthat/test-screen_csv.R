test_that("Output structure is as expected", {
  # Start by creating some temporary CSVs
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

  # Clean up temp files
  file.remove(data_file)
  file.remove(meta_file)

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

test_that("Fails with invalid args", {
  expect_error(screen_csv(1, 2), "`datapath` must be a single string")
  expect_error(screen_csv("string", 2), "`metapath` must be a single string")
})

test_that("Substitutes in filenames if not given", {
  data_path <- paste0(tempdir(), "\\test.csv")
  meta_path <- paste0(tempdir(), "\\test.meta.csv")

  data.table::fwrite(example_data, data_path)
  data.table::fwrite(example_meta, meta_path)

  output_messages <- screen_csv(data_path, meta_path)$results_table$message

  expect_true(
    any(grepl("test.csv", output_messages)),
    "'test.csv' not found in output_messages"
  )
  expect_true(
    any(grepl("test.meta.csv", output_messages)),
    "'test.meta.csv' not found in output_messages"
  )

  file.remove(data_path)
  file.remove(meta_path)
})

test_that("Example file passes", {
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

  file.remove(data_file)
  file.remove(meta_file)
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
  txt_file <- tempfile(fileext = ".txt")
  txt_meta <- tempfile(fileext = ".txt")
  data_file <- tempfile(fileext = ".csv")
  meta_file <- tempfile(fileext = ".meta.csv")

  data.table::fwrite(example_data, data_file)
  data.table::fwrite(example_meta, meta_file)
  writeLines(c("This is not a CSV file"), txt_file)
  writeLines(c("This is not a CSV file"), txt_meta)

  expect_error(
    screen_csv(txt_file, txt_meta, output = "error-only"),
    "Data file"
  )
  expect_error(
    screen_csv(txt_file, meta_file, output = "error-only"),
    "Data file"
  )
  expect_error(
    screen_csv(data_file, txt_meta, output = "error-only"),
    "Metadata file"
  )

  file.remove(data_file)
  file.remove(meta_file)
  file.remove(txt_file)
  file.remove(txt_meta)
})

test_that("Example file fails with filename", {
  data_file <- tempfile(fileext = ".csv")
  meta_file <- tempfile(fileext = ".meta.csv")

  data.table::fwrite(example_data, data_file)
  data.table::fwrite(example_meta, meta_file)

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

  file.remove(data_file)
  file.remove(meta_file)

  # Run again but with implied filenames
  data_path <- file.path(tempdir(), "nonono.csv")
  meta_path <- file.path(tempdir(), "nonono-meta.csv")

  data.table::fwrite(example_data, data_path)
  data.table::fwrite(example_meta, meta_path)

  expect_equal(
    screen_csv(data_path, meta_path)$overall_stage,
    "filename checks"
  )

  expect_error(
    screen_csv(data_path, meta_path, output = "console"),
    "The filenames do not follow the recommended naming convention"
  )

  file.remove(data_path)
  file.remove(meta_path)
})

test_that("fails check dfs", {
  gunsnroses_meta <- example_meta
  gunsnroses_meta$col_type <- "November rain"

  data_path <- file.path(tempdir(), "gnr.csv")
  meta_path <- file.path(tempdir(), "gnr.meta.csv")

  data.table::fwrite(example_data, data_path)
  data.table::fwrite(gunsnroses_meta, meta_path)

  expect_error(
    screen_csv(data_path, meta_path, output = "error-only"),
    "invalid col_type"
  )

  res_table <- screen_csv(data_path, meta_path)$results_table

  expect_equal(
    res_table[res_table$check == "meta_col_type", "result"],
    "FAIL"
  )

  file.remove(data_path)
  file.remove(meta_path)
})

# TODO: add tests for different failure stages and edge cases
