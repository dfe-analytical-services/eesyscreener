test_that("Functions return the right format", {
  # TODO: do some mocking / do this better
  expect_equal(
    check_filename_spaces("passes.csv", verbose = FALSE) |> class(),
    "data.frame"
  )
  expect_length(check_filename_spaces("passes.csv", verbose = FALSE), 4)
  expect_equal(
    names(check_filename_spaces("passes.csv", verbose = FALSE)),
    c("check", "result", "message", "guidance_url")
  )
})
