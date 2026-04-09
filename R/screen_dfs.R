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
#' @param log_key Keystring for creating log file. If given, the screening will
#' write a log file to disk called eesyscreening_log_<log_key>.json default=NULL
#' @param log_dir Directory within which to place the log file. default="./"
#' @param dd_checks Run the Data dictionary tests, default=TRUE (this is implemented to allow devs
#' to update robot test data to be consistent with data dictionary tests).
#' @param verbose logical, if TRUE prints feedback messages to console for
#' every test, if FALSE run silently
#' @param stop_on_error logical, if TRUE will stop with an error if the result
#' is "FAIL", and will throw genuine warning if result is "WARNING"
#' @param prudence prudence as used by duckplyr, default = "lavish". Can also
#' be "stingy" and "thrifty".
#'
#' @inherit screen_filenames return
#'
#' @examples
#' screen_dfs(example_data, example_meta)
#' @export
screen_dfs <- function(
  data,
  meta,
  log_key = NULL,
  log_dir = "./",
  dd_checks = TRUE,
  verbose = FALSE,
  stop_on_error = FALSE,
  prudence = "lavish"
) {
  validate_arg_dfs(data, meta)

  validate_arg_logical(verbose, "verbose")
  validate_arg_logical(stop_on_error, "stop_on_error")

  # Shorthand for easier script reading
  vb <- verbose
  soe <- stop_on_error

  if (!duckplyr::is_duckdb_tibble(data)) {
    data <- duckplyr::as_duckdb_tibble(data, prudence = prudence)
  }
  data_details <- list(
    ncols = data |> dplyr::tbl_vars() |> length(),
    nrows = data |> dplyr::count() |> dplyr::pull("n")
  )

  suppressMessages(duckplyr::methods_restore())

  # Precheck columns ----------------------------------------------------------
  precheck_col_results <- rbind(
    precheck_col_req_meta(meta, vb, soe),
    precheck_col_invalid_meta(meta, vb, soe),
    precheck_col_req_data(data, vb, soe),
    precheck_col_to_rows(data, meta, vb, soe)
  )

  all_results <- precheck_col_results |>
    dplyr::mutate(stage = "Precheck columns")

  write_json_log(
    all_results,
    log_key = log_key,
    log_dir = log_dir,
    data_details = data_details
  )

  if (any(all_results[["result"]] == "FAIL")) {
    return(as.data.frame(all_results))
  }

  # Check columns ----------------------------------------------------------
  check_col_results <- rbind(
    check_col_names_spaces(data, vb, soe)
  )

  all_results <- all_results |>
    rbind(
      check_col_results |>
        dplyr::mutate(stage = "Check columns")
    )

  write_json_log(
    all_results,
    log_key = log_key,
    log_dir = log_dir,
    data_details = data_details
  )

  if (any(all_results[["result"]] == "FAIL")) {
    return(as.data.frame(all_results))
  }

  # Precheck meta -------------------------------------------------------------
  precheck_meta_results <- rbind(
    precheck_meta_col_type(meta, vb, soe),
    precheck_meta_ob_unit(meta, vb, soe),
    precheck_meta_col_name(meta, vb, soe)
  )

  all_results <- all_results |>
    rbind(
      precheck_meta_results |>
        dplyr::mutate(stage = "Precheck meta")
    )

  write_json_log(
    all_results,
    log_key = log_key,
    log_dir = log_dir,
    data_details = data_details
  )

  if (any(all_results[["result"]] == "FAIL")) {
    return(as.data.frame(all_results))
  }

  # Check meta ----------------------------------------------------------------
  check_meta_results <- rbind(
    check_meta_duplicate_label(meta, vb, soe),
    check_meta_filter_group(meta, vb, soe),
    check_meta_filter_group_is_filter(meta, vb, soe),
    check_meta_filter_group_match(data, meta, vb, soe),
    check_meta_label(meta, vb, soe),
    check_meta_filter_hint(meta, vb, soe),
    check_meta_indicator_dp(meta, vb, soe),
    check_meta_col_name_spaces(meta, vb, soe),
    check_meta_col_name_duplicate(meta, vb, soe),
    check_meta_ind_dp_set(meta, vb, soe),
    check_meta_ind_unit(meta, vb, soe),
    check_meta_indicator_grouping(meta, vb, soe)
  )

  all_results <- all_results |>
    rbind(
      check_meta_results |>
        dplyr::mutate(stage = "Check meta")
    )

  write_json_log(
    all_results,
    log_key = log_key,
    log_dir = log_dir,
    data_details = data_details
  )

  if (any(all_results[["result"]] == "FAIL")) {
    return(as.data.frame(all_results))
  }

  # Turn on duckdb ------------------------------------------------------------
  # Only doing this here as not necessary for the metadata checks
  suppressMessages(duckplyr::methods_overwrite())

  # Precheck time -------------------------------------------------------------
  precheck_time_results <- rbind(
    precheck_time_id_valid(data, vb, soe)
  )

  all_results <- all_results |>
    rbind(
      precheck_time_results |>
        dplyr::mutate(stage = "Precheck time")
    )

  write_json_log(
    all_results,
    log_key = log_key,
    log_dir = log_dir,
    data_details = data_details
  )

  if (any(all_results[["result"]] == "FAIL")) {
    return(as.data.frame(all_results))
  }

  # Check Time ----------------------------------------------------------------
  check_time_results <- rbind(
    check_time_period(
      data,
      verbose = verbose,
      stop_on_error = stop_on_error
    ),
    check_time_period_six(
      data,
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  )

  all_results <- all_results |>
    rbind(
      check_time_results |>
        dplyr::mutate(stage = "Check time")
    )

  write_json_log(
    all_results,
    log_key = log_key,
    log_dir = log_dir,
    data_details = data_details
  )

  if (any(all_results[["result"]] == "FAIL")) {
    return(as.data.frame(all_results))
  }

  # Precheck geog -------------------------------------------------------------
  precheck_geography_results <- rbind(
    precheck_geog_level(
      data,
      verbose = verbose,
      stop_on_error = stop_on_error
    ),
    precheck_geog_level_present(
      data,
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  )

  all_results <- all_results |>
    rbind(
      precheck_geography_results |>
        dplyr::mutate(stage = "Precheck geography")
    )

  write_json_log(
    all_results,
    log_key = log_key,
    log_dir = log_dir,
    data_details = data_details
  )

  if (any(all_results[["result"]] == "FAIL")) {
    return(as.data.frame(all_results))
  }

  # Check Filters -------------------------------------------------------------
  check_filter_results <- rbind(
    check_filter_defaults(data, meta, vb, soe),
    check_filter_whitespace(data, meta, vb, soe)
  )

  all_results <- all_results |>
    rbind(
      check_filter_results |>
        dplyr::mutate(stage = "Check filters")
    )

  write_json_log(
    all_results,
    log_key = log_key,
    log_dir = log_dir,
    data_details = data_details
  )

  if (any(all_results[["result"]] == "FAIL")) {
    return(as.data.frame(all_results))
  }

  # Check API -----------------------------------------------------------------
  check_api_results <- rbind(
    check_api_char_col_name(data, vb, soe),
    check_api_char_col_label(meta, vb, soe),
    check_api_char_loc_code(data, vb, soe),
    check_api_char_filter_items(data, meta, vb, soe)
  )

  all_results <- all_results |>
    rbind(
      check_api_results |>
        dplyr::mutate(stage = "Check API")
    )

  write_json_log(
    all_results,
    log_key = log_key,
    log_dir = log_dir,
    data_details = data_details
  )

  api_pass <- all(check_api_results[["result"]] == "PASS")

  if (any(all_results[["result"]] == "FAIL")) {
    return(as.data.frame(all_results))
  }

  # Success return ------------------------------------------------------------
  if (verbose) {
    if (api_pass) {
      cli::cli_alert_success("Data and metadata passed all checks")
    } else {
      cli::cli_alert_info(
        paste(
          "Data and metadata passed, but warnings prevent it being suitable for",
          "the API"
        )
      )
    }
  }

  as.data.frame(all_results)
}
