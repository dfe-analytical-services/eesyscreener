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
#' @param verbose logical, if TRUE prints feedback messages to console for
#' every test, if FALSE run silently
#' @param stop_on_error logical, if TRUE will stop with an error if the result
#' is "FAIL", and will throw genuine warning if result is "WARNING"
#'
#' @inherit screen_filenames return
#'
#' @examples
#' screen_dfs(example_data, example_meta)
#' @export
screen_dfs <- function(data, meta, verbose = FALSE, stop_on_error = FALSE) {
  validate_arg_dfs(data, meta)
  validate_arg_logical(verbose, "verbose")
  validate_arg_logical(stop_on_error, "stop_on_error")

  data <- duckplyr::as_duckdb_tibble(data)

  # Precheck columns ----------------------------------------------------------
  precheck_col_results <- rbind(
    precheck_col_req_meta(
      meta,
      verbose = verbose,
      stop_on_error = stop_on_error
    ),
    precheck_col_invalid_meta(
      meta,
      verbose = verbose,
      stop_on_error = stop_on_error
    ),
    precheck_col_req_data(
      data,
      verbose = verbose,
      stop_on_error = stop_on_error
    ),
    precheck_col_to_rows(
      data,
      meta,
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  )

  precheck_col_results <- precheck_col_results |>
    cbind("stage" = "Precheck columns")

  if (any(precheck_col_results[["result"]] == "FAIL")) {
    return(as.data.frame(precheck_col_results))
  }

  # Precheck meta -------------------------------------------------------------
  precheck_meta_results <- rbind(
    precheck_meta_col_type(
      meta,
      verbose = verbose,
      stop_on_error = stop_on_error
    ),
    precheck_meta_ob_unit(
      meta,
      verbose = verbose,
      stop_on_error = stop_on_error
    ),
    precheck_meta_col_name(
      meta,
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  )

  precheck_meta_results <- precheck_col_results |>
    rbind(
      precheck_meta_results |>
        cbind("stage" = "Precheck meta")
    )

  if (any(precheck_meta_results[["result"]] == "FAIL")) {
    return(as.data.frame(precheck_meta_results))
  }

  # Check meta ----------------------------------------------------------------
  check_meta_results <- rbind(
    check_meta_ind_dp_set(meta, verbose, stop_on_error),
    check_meta_filter_group_match(
      data,
      meta,
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  )

  check_meta_results <- precheck_meta_results |>
    rbind(
      check_meta_results |>
        cbind("stage" = "Check meta")
    )

  if (any(check_meta_results[["result"]] == "FAIL")) {
    return(as.data.frame(check_meta_results))
  }

  # Turn on duckdb ------------------------------------------------------------
  # Only doing this here as not necessary for the metadata checks
  suppressMessages(duckplyr::methods_overwrite())

  # Some other bits -----------------------------------------------------------

  # Precheck time -------------------------------------------------------------
  precheck_time_results <- rbind(
    precheck_time_id_valid(
      data,
      meta,
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  )

  precheck_time_results <- check_meta_results |>
    rbind(
      precheck_time_results |>
        cbind("stage" = "Precheck time")
    )

  if (any(precheck_time_results[["result"]] == "FAIL")) {
    return(as.data.frame(precheck_time_results))
  }

  # Check API -----------------------------------------------------------------
  check_api_results <- rbind(
    check_api_char_limit(
      meta[["col_name"]],
      "column-name",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
    # TODO: Add extra variations here
  )

  api_pass <- all(check_api_results[["result"]] == "PASS")

  final_results <- precheck_time_results |>
    rbind(
      check_api_results |>
        cbind("stage" = "Check API")
    )

  if (any(final_results[["result"]] == "FAIL")) {
    return(as.data.frame(final_results))
  }

  # Success return ------------------------------------------------------------
  if (api_pass && verbose) {
    cli::cli_alert_success("Data and metadata passed all checks")
  } else if (verbose) {
    cli::cli_alert_info(
      paste(
        "Data and metadata passed, but warnings prevent it being suitable for",
        "the API"
      )
    )
  }

  final_results
}
