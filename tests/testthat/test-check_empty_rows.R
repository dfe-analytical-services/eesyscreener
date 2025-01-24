test_data <- readRDS("./test_data/check_empty_rows.RDS")
test_meta <- readRDS("./test_data/check_empty_rows.meta.RDS")

# Run function
data_check <- check_empty_rows(test_data, "data")
meta_check <- check_empty_rows(test_meta, "metadata")

test_that("fails as expected", {
  expect_equal(data_check$result, "FAIL")
  expect_equal(meta_check$result, "FAIL")
})

test_that("messages are expected, including number of rows found", {
  expect_equal(
    data_check$message,
    paste(
      "There are 125,644 blank rows in the data file. Try opening the CSV",
      "in notepad if you're not sure where the blank rows are."
    )
  )
  expect_equal(
    meta_check$message,
    paste(
      "There are 5 blank rows in the metadata file. Try opening the CSV in",
      "notepad if you're not sure where the blank rows are."
    )
  )
})

test_that("returns the right format", {
  expect_type(data_check, "list")
  expect_length(data_check, 3)
  expect_equal(
    names(data_check),
    c("check", "result", "message")
  )
})
