test_that("Checks do not pull large data into memory", {
  # This test runs the checks in stingy mode, which refuses to run if a check
  # attempts to materialise the data.
  # More info here: https://duckplyr.tidyverse.org/articles/prudence.html
  # If a test really needs to break this test, then we'll need to do some
  # development on the EES infrastructure side of things to allow that to run
  # successfully.
  expect_no_error(
    screen_dfs(example_comma_data, example_comma_meta, prudence = "stingy")
  )
})

test_that("screen_dfs() produces no duckplyr fallbacks", {
  # Catches both severities of duckplyr fallback:
  #   "Error processing" - has an error as $parent condition; would fail
  #     expect_no_error() if not caught here first
  #   "Cannot process"   - informational only; does not fail expect_no_error()
  #     but still represents silent degradation to plain dplyr
  # Placing withCallingHandlers() inside expect_no_error() means our handler
  # fires first (closest to the signal site), muffles the message before rlang
  # can re-signal the parent error, and records it for inspection.
  #
  # IF THIS TEST FAILS:
  # The fallback messages printed by expect_length() identify which dplyr
  # operation triggered the fallback. Common causes and fixes are documented
  # in .github/CONTRIBUTING.md under "Diagnosing and fixing duckplyr fallbacks".
  #
  # To diagnose interactively:
  #   1. pkgload::load_all(".", quiet = TRUE)
  #   2. duckplyr::methods_overwrite()
  #   3. Wrap the suspect check function with withCallingHandlers(), catching
  #      rlang_message conditions and inspecting sys.calls() to find the exact
  #      line that triggers the fallback
  #   4. duckplyr::methods_restore() when done
  fallbacks <- character(0)
  expect_no_error(
    withCallingHandlers(
      screen_dfs(example_data, example_meta),
      message = function(m) {
        msg <- conditionMessage(m)
        if (grepl("Cannot process|Error processing", msg)) {
          fallbacks <<- c(fallbacks, trimws(msg))
          invokeRestart("muffleMessage")
        }
      }
    )
  )
  expect_length(fallbacks, 0L)
})
