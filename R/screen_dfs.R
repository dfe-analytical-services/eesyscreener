#' Run all checks against data and metadata
#'
#' Run all of the checks from the package against the data and metadata
#' objects.
#'
#' Provide a pair of data.frames and this will run through the checks in order.
#'
#' @param data data.frame, for the data table, more efficient if supplied as a
#' lazy duckplyr data.frame
#' @param meta data.frame, for the metadata table
#' @param output Control the format of output, either 'table', 'error-only', or
#' 'console'
#' @inherit screen_filenames return
#'
#' @examples
#' screen_dfs(example_data, example_meta)
#' @export
screen_dfs <- function(data, meta, output = "table") {
  validate_arg_dfs(data, meta)
  validate_arg_output(output)

  # Precheck meta -------------------------------------------------------------
  precheck_meta_results <- rbind(
    precheck_meta_col_type(meta, output = output)
  )

  if (output == "table") {
    precheck_meta_results <- precheck_meta_results |>
      cbind(
        "stage" = "Precheck meta"
      )

    if (any(precheck_meta_results[["result"]] == "FAIL")) {
      return(
        list(
          "results_table" = as.data.frame(precheck_meta_results),
          "overall_stage" = "Meta prechecks",
          "overall_message" = "Failed meta prechecks"
        )
      )
    }
  }

  # Check meta ----------------------------------------------------------------

  # Success return ------------------------------------------------------------
  if (output == "console") {
    cli::cli_alert_success("Data and metadata passed all checks")
  } else if (output == "table") {
    precheck_meta_results
  }
}
