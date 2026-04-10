test_that("every exported check function has a row in example_output", {
  namespace_lines <- readLines(system.file(
    "NAMESPACE",
    package = "eesyscreener"
  ))
  exported <- gsub(
    "^export\\((.+)\\)$",
    "\\1",
    grep("^export\\(", namespace_lines, value = TRUE)
  )

  check_fns <- exported[grepl("^(check|precheck)_", exported)]

  stripped <- sub("^(check|precheck)_", "", check_fns)

  missing <- setdiff(stripped, example_output$check)

  expect_equal(
    missing,
    character(0),
    info = paste(
      "Functions exported but not found in example_output$check",
      "(after prefix strip):",
      paste(missing, collapse = ", ")
    )
  )
})
