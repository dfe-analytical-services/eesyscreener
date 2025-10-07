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

  data <- duckplyr::as_duckdb_tibble(data)
  suppressMessages(duckplyr::methods_overwrite())

  # Precheck columns ----------------------------------------------------------
  precheck_col_results <- rbind(
    precheck_col_req_meta(meta, output = output),
    precheck_col_invalid_meta(meta, output = output),
    precheck_col_req_data(data, output = output),
    precheck_col_to_rows(data, meta, output = output)
  )

  if (output == "table") {
    precheck_col_results <- precheck_col_results |>
      cbind("stage" = "Precheck columns")

    if (any(precheck_col_results[["result"]] == "FAIL")) {
      return(as.data.frame(precheck_col_results))
    }
  }

  # Precheck meta -------------------------------------------------------------
  precheck_meta_results <- rbind(
    precheck_meta_col_type(meta, output = output),
    precheck_meta_ob_unit(meta, output = output),
    precheck_meta_col_name(meta, output = output)
  )

  if (output == "table") {
    precheck_meta_results <- precheck_col_results |>
      rbind(
        precheck_meta_results |>
          cbind("stage" = "Precheck meta")
      )

    if (any(precheck_meta_results[["result"]] == "FAIL")) {
      return(as.data.frame(precheck_meta_results))
    }
  }

  # Check meta ----------------------------------------------------------------

  # Some other bits -----------------------------------------------------------

  # Precheck time -------------------------------------------------------------
  precheck_time_results <- rbind(
    precheck_time_id_valid(data, meta, output = output)
  )

  if (output == "table") {
    precheck_time_results <- precheck_meta_results |>
      rbind(
        precheck_time_results |>
          cbind("stage" = "Precheck time")
      )

    if (any(precheck_time_results[["result"]] == "FAIL")) {
      return(as.data.frame(precheck_time_results))
    }
  }

  # Success return ------------------------------------------------------------
  if (output == "console") {
    cli::cli_alert_success("Data and metadata passed all checks")
  } else if (output == "table") {
    precheck_time_results
  }
}
