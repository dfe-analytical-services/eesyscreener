# If adding new tests, this will fail if you haven't also updated the example
# output. Make sure you update example_output using the script in data_raw
# after you've added a new check. Another point of failure is if you've added
# a new family of tests and either you've not folded it into the results
# collation properly or you've not done the stage to write to the logfile.
test_that("Log file generation works as expected", {
  test_dir <- tempdir()
  paths <- write_ees_files(example_data, example_meta, test_dir, "log-test")

  log_key <- "zxc987_1"
  log_file <- paste0("eesyscreener_log_", log_key, ".json")
  log_path <- file.path(test_dir, log_file)
  result <- screen_csv(
    paths$data_path,
    paths$meta_path,
    "test.csv",
    "test.meta.csv",
    log_key = log_key,
    log_dir = test_dir
  )
  expect_true(file.exists(log_path))

  test_json_content <- jsonlite::read_json(log_path, simplifyVector = TRUE)

  # Check if `example_output` is up to date with the current results
  expect_equal(
    test_json_content$results |> nrow(),
    example_output |> nrow()
  )

  # Check the screening is marked as completed and progress = 100%
  expect_equal(
    test_json_content$completed,
    TRUE
  )

  expect_equal(
    test_json_content$progress,
    100
  )

  # Expect a warning if the log file already exists
  expect_warning(
    screen_csv(
      paths$data_path,
      paths$meta_path,
      "test.csv",
      "test.meta.csv",
      log_key = log_key,
      log_dir = test_dir
    )
  )

  expect_no_error(
    screen_csv(
      paths$data_path,
      paths$meta_path,
      "test.csv",
      "test.meta.csv",
      log_key = "new_key",
      log_dir = NULL
    )
  )

  # Now clean up after yourself
  file.remove(paths$data_path)
  file.remove(paths$meta_path)
  file.remove(log_path)
})
