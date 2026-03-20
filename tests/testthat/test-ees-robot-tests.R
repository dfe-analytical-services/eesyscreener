# Checking that the screener runs to completion on all robot tests
test_that("Check EES robot test files", {
  test_dir <- tempdir()
  for (robot in ees_robot_test_data) {
    test_dir = tempdir()
    paths <- write_ees_files(robot$data, robot$meta, test_dir, robot$robot_name)
    
    screener_output <- expect_no_error(screen_csv(paths$data, paths$meta))

    # Now test that all results are either PASS, WARNING or FAIL
    results <- screener_output$results$result |> unique()
        expect_true(      all(results %in% c("PASS", "WARNING", "FAIL")))

    file.remove(paths$data_path)
    file.remove(paths$meta_path)
  }
})

