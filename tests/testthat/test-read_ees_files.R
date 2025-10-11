test_that("returns expected structure for valid CSVs", {
  data_file <- tempfile(fileext = ".csv")
  meta_file <- tempfile(fileext = ".meta.csv")
  write.csv(data.frame(a = 1:3, b = 4:6), data_file, row.names = FALSE)
  write.csv(
    data.frame(col_type = c("Filter", "Indicator")),
    meta_file,
    row.names = FALSE
  )

  files <- read_ees_files(data_file, meta_file)
  expect_type(files, "list")
  expect_true(all(c("data", "meta") %in% names(files)))
  expect_s3_class(files$data, "data.frame")
  expect_s3_class(files$meta, "data.frame")

  file.remove(data_file)
  file.remove(meta_file)
})

test_that("errors if data file does not exist", {
  meta_file <- tempfile(fileext = ".meta.csv")
  write.csv(data.frame(col_type = c("Filter")), meta_file, row.names = FALSE)
  expect_error(
    read_ees_files("no_such_file.csv", meta_file),
    "No file found at"
  )
  file.remove(meta_file)
})

test_that("errors if meta file does not exist", {
  data_file <- tempfile(fileext = ".csv")
  write.csv(data.frame(a = 1:3), data_file, row.names = FALSE)
  expect_error(
    read_ees_files(data_file, "no_such_file.meta.csv"),
    "No file found at"
  )
  file.remove(data_file)
})

test_that("errors if data file is not a CSV", {
  data_file <- tempfile(fileext = ".txt")
  meta_file <- tempfile(fileext = ".meta.csv")
  writeLines("not a csv", data_file)
  write.csv(data.frame(col_type = c("Filter")), meta_file, row.names = FALSE)
  expect_error(
    read_ees_files(data_file, meta_file),
    "Data file at.*does not have a CSV MIME type"
  )
  file.remove(data_file)
  file.remove(meta_file)
})

test_that("errors if meta file is not a CSV", {
  data_file <- tempfile(fileext = ".csv")
  meta_file <- tempfile(fileext = ".txt")
  write.csv(data.frame(a = 1:3), data_file, row.names = FALSE)
  writeLines("not a csv", meta_file)
  expect_error(
    read_ees_files(data_file, meta_file),
    "Metadata file at.*does not have a CSV MIME type"
  )
  file.remove(data_file)
  file.remove(meta_file)
})
