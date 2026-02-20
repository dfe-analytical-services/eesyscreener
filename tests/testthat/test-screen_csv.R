test_that("Output structure is as expected", {
  # Start by creating some temporary CSVs
  data_file <- tempfile(fileext = ".csv")
  meta_file <- tempfile(fileext = ".meta.csv")

  write.csv(example_data, data_file, row.names = FALSE)
  write.csv(example_meta, meta_file, row.names = FALSE)

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
  expect_length(output, 4)
  expect_equal(
    names(output),
    c("results_table", "overall_stage", "passed", "api_suitable")
  )

  expect_equal(
    names(output$results_table),
    c("check", "result", "message", "guidance_url", "stage")
  )

  expect_gt(dplyr::distinct(output$results_table, stage) |> nrow(), 2)

  expect_equal(class(output$results_table), "data.frame")

  expect_equal(nrow(output$results_table), nrow(unique(output$results_table)))

  expect_true(all(
    output[["results_table"]][["result"]] %in% c("PASS", "FAIL", "ADVISORY")
  ))

  for (col in c("check", "message", "stage")) {
    expect_false(any(is.na(output$results_table[[col]])))
    expect_false(any(output$results_table[[col]] == ""))
  }

  expect_type(output$api_suitable, "logical")
})

test_that("Fails with invalid args", {
  expect_error(screen_csv(1, 2), "`datapath` must be a single string")
  expect_error(screen_csv("string", 2), "`metapath` must be a single string")
})

test_that("Substitutes in filenames if not given", {
  data_path <- paste0(tempdir(), "\\test.csv")
  meta_path <- paste0(tempdir(), "\\test.meta.csv")

  write.csv(example_data, data_path, row.names = FALSE)
  write.csv(example_meta, meta_path, row.names = FALSE)

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

  write.csv(example_data, data_file, row.names = FALSE)
  write.csv(example_meta, meta_file, row.names = FALSE)

  output <- screen_csv(
    data_file,
    meta_file,
    "data.csv",
    "data.meta.csv"
  )

  expect_equal(output$overall_stage, "Passed")
  expect_equal(output$passed, TRUE)

  expect_no_error(
    screen_csv(
      data_file,
      meta_file,
      "data.csv",
      "data.meta.csv"
    )
  )

  expect_no_error(
    screen_csv(
      data_file,
      meta_file,
      "data.csv",
      "data.meta.csv",
      verbose = TRUE
    )
  )

  expect_no_error(
    screen_csv(
      data_file,
      meta_file,
      "data.csv",
      "data.meta.csv",
      stop_on_error = TRUE
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

  write.csv(example_data, data_file, row.names = FALSE)
  write.csv(example_meta, meta_file, row.names = FALSE)
  writeLines(c("This is not a CSV file"), txt_file)
  writeLines(c("This is not a CSV file"), txt_meta)

  expect_error(
    screen_csv(txt_file, txt_meta, stop_on_error = TRUE),
    "Data file"
  )
  expect_error(
    screen_csv(txt_file, meta_file, stop_on_error = TRUE),
    "Data file"
  )
  expect_error(
    screen_csv(data_file, txt_meta, stop_on_error = TRUE),
    "Meta data file"
  )

  file.remove(data_file)
  file.remove(meta_file)
  file.remove(txt_file)
  file.remove(txt_meta)
})

test_that("Example file fails with filename", {
  data_file <- tempfile(fileext = ".csv")
  meta_file <- tempfile(fileext = ".meta.csv")

  write.csv(example_data, data_file, row.names = FALSE)
  write.csv(example_meta, meta_file, row.names = FALSE)

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
      verbose = TRUE,
      stop_on_error = TRUE
    ),
    "The filenames do not follow the recommended naming convention"
  )

  file.remove(data_file)
  file.remove(meta_file)

  # Run again but with implied filenames
  data_path <- file.path(tempdir(), "nonono.csv")
  meta_path <- file.path(tempdir(), "nonono-meta.csv")

  write.csv(example_data, data_path, row.names = FALSE)
  write.csv(example_meta, meta_path, row.names = FALSE)

  expect_equal(
    screen_csv(data_path, meta_path)$overall_stage,
    "filename checks"
  )

  expect_error(
    screen_csv(data_path, meta_path, stop_on_error = TRUE),
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

  write.csv(example_data, data_path, row.names = FALSE)
  write.csv(gunsnroses_meta, meta_path, row.names = FALSE)

  expect_error(
    screen_csv(data_path, meta_path, stop_on_error = TRUE),
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

test_that("api_suitable returns FALSE for unsuitable files", {
  data_path <- tempfile(fileext = ".csv")
  meta_path <- tempfile(fileext = ".meta.csv")
  write.csv(example_api_long, data_path, row.names = FALSE)
  write.csv(example_api_long_meta, meta_path, row.names = FALSE)

  result <- screen_csv(data_path, meta_path, "api.csv", "api.meta.csv")
  expect_true(!is.null(result$api_suitable))
  expect_false(result$api_suitable)

  expect_warning(
    screen_csv(
      data_path,
      meta_path,
      "api.csv",
      "api.meta.csv",
      stop_on_error = TRUE
    )
  )

  file.remove(data_path)
  file.remove(meta_path)
})

test_that("screen_csv completes for file containing commas in strings", {
  data_path <- tempfile(fileext = ".csv")
  meta_path <- tempfile(fileext = ".meta.csv")
  write.csv(example_comma_data, data_path, row.names = FALSE)
  write.csv(example_comma_meta, meta_path, row.names = FALSE)

  expect_no_error(
    screen_csv(data_path, meta_path, "late_comma.csv", "late_comma.meta.csv")
  )

  file.remove(data_path)
  file.remove(meta_path)
})

# TODO: Cam / Rich to fix this, failing on PRs for additional checks

# test_that("Log file is created successfully", {
#   data_path <- tempfile(fileext = ".csv")
#   meta_path <- tempfile(fileext = ".meta.csv")
#   write.csv(example_data, data_path, row.names = FALSE)
#   write.csv(example_meta, meta_path, row.names = FALSE)
#
#   log_dir = tempdir()
#   log_file = paste0("eesyscreener_log_zxc987.json")
#   log_path = file.path(log_dir, log_file)
#   result <- screen_csv(
#     data_path,
#     meta_path,
#     "test.csv",
#     "test.meta.csv",
#     log_key = "zxc987",
#     log_dir = log_dir
#   )
#   expect_true(file.exists(log_path))
#   # Check if we need to update `example_output`
#   expect_equal(
#     jsonlite::read_json(log_path, simplifyVector = TRUE)$results |> nrow(),
#     example_output |> nrow()
#   )
#   expect_warning(
#     screen_csv(
#       data_path,
#       meta_path,
#       "test.csv",
#       "test.meta.csv",
#       log_key = "zxc987",
#       log_dir = log_dir
#     )
#   )
#   file.remove(data_path)
#   file.remove(meta_path)
#   file.remove(log_path)
# })

# TODO: add tests for different failure stages and edge cases
