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
#' @param dd_checks Run the Data dictionary tests, default=TRUE (this is
#' implemented to allow devs
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

  all_results <- NULL

  # Precheck columns ----------------------------------------------------------
  res <- run_and_log_check(
    all_results,
    rbind(
      precheck_col_req_meta(meta, vb, soe),
      precheck_col_invalid_meta(meta, vb, soe),
      precheck_col_req_data(data, vb, soe),
      precheck_col_to_rows(data, meta, vb, soe)
    ),
    "Precheck columns",
    log_key,
    log_dir,
    data_details
  )
  all_results <- res$all_results
  if (res$early_return) {
    return(as.data.frame(all_results))
  }

  # Precheck cross-file -------------------------------------------------------
  res <- run_and_log_check(
    all_results,
    rbind(
      precheck_cross_meta_to_data(data, meta, vb, soe),
      precheck_cross_data_to_meta(data, meta, vb, soe)
    ),
    "Precheck cross-file",
    log_key,
    log_dir,
    data_details
  )
  all_results <- res$all_results
  if (res$early_return) {
    return(as.data.frame(all_results))
  }

  # Check columns -------------------------------------------------------------
  res <- run_and_log_check(
    all_results,
    rbind(
      check_col_names_spaces(data, vb, soe),
      check_col_snake_case(data, vb, soe),
      check_col_var_start(data, vb, soe),
      check_col_ind_smushed(meta, vb, soe),
      check_col_var_characteristic(meta, vb, soe)
    ),
    "Check columns",
    log_key,
    log_dir,
    data_details
  )
  all_results <- res$all_results
  if (res$early_return) {
    return(as.data.frame(all_results))
  }

  # Precheck meta -------------------------------------------------------------
  res <- run_and_log_check(
    all_results,
    rbind(
      precheck_meta_col_type(meta, vb, soe),
      precheck_meta_ob_unit(meta, vb, soe),
      precheck_meta_col_name(meta, vb, soe)
    ),
    "Precheck meta",
    log_key,
    log_dir,
    data_details
  )
  all_results <- res$all_results
  if (res$early_return) {
    return(as.data.frame(all_results))
  }

  # Check meta ----------------------------------------------------------------
  res <- run_and_log_check(
    all_results,
    rbind(
      check_meta_dupe_label(meta, vb, soe),
      check_meta_fil_grp(meta, vb, soe),
      check_meta_fil_grp_dupe(meta, vb, soe),
      check_meta_fil_grp_is_fil(meta, vb, soe),
      check_meta_fil_grp_match(data, meta, vb, soe),
      check_meta_fil_grp_stripped(data, meta, vb, soe),
      check_meta_label(meta, vb, soe),
      check_meta_filter_hint(meta, vb, soe),
      check_meta_geog_catch(meta, vb, soe),
      check_meta_indicator_dp(meta, vb, soe),
      check_meta_col_name_spaces(meta, vb, soe),
      check_meta_col_name_dupe(meta, vb, soe),
      check_meta_ind_dp_set(meta, vb, soe),
      check_meta_ind_dp_values(meta, vb, soe),
      check_meta_ind_unit(meta, vb, soe),
      check_meta_ind_unit_validation(meta, vb, soe),
      check_meta_indicator_grouping(meta, vb, soe)
    ),
    "Check meta",
    log_key,
    log_dir,
    data_details
  )
  all_results <- res$all_results
  if (res$early_return) {
    return(as.data.frame(all_results))
  }

  # Turn on duckdb ------------------------------------------------------------
  # Only doing this here as not necessary for the metadata checks
  suppressMessages(duckplyr::methods_overwrite())

  # Precheck filters ----------------------------------------------------------
  res <- run_and_log_check(
    all_results,
    rbind(
      precheck_filter_not_singular(data, meta, vb, soe)
    ),
    "Precheck filters",
    log_key,
    log_dir,
    data_details
  )
  all_results <- res$all_results
  if (res$early_return) {
    return(as.data.frame(all_results))
  }

  # Precheck time -------------------------------------------------------------
  res <- run_and_log_check(
    all_results,
    rbind(
      precheck_time_period_num(data, vb, soe),
      precheck_time_id_valid(data, vb, soe),
      precheck_time_id_mix(data, vb, soe)
    ),
    "Precheck time",
    log_key,
    log_dir,
    data_details
  )
  all_results <- res$all_results
  if (res$early_return) {
    return(as.data.frame(all_results))
  }

  # Precheck geography --------------------------------------------------------
  res <- run_and_log_check(
    all_results,
    rbind(
      precheck_geog_level(data, vb, soe),
      precheck_geog_level_present(data, vb, soe)
    ),
    "Precheck geography",
    log_key,
    log_dir,
    data_details
  )
  all_results <- res$all_results
  if (res$early_return) {
    return(as.data.frame(all_results))
  }

  # Check time ----------------------------------------------------------------
  res <- run_and_log_check(
    all_results,
    rbind(
      check_time_period(data, vb, soe),
      check_time_period_six(data, vb, soe)
    ),
    "Check time",
    log_key,
    log_dir,
    data_details
  )
  all_results <- res$all_results
  if (res$early_return) {
    return(as.data.frame(all_results))
  }

  # Check geography -----------------------------------------------------------
  res <- run_and_log_check(
    all_results,
    rbind(
      check_geog_ignored_rows(data, vb, soe),
      check_geog_region_for_la(data, vb, soe),
      check_geog_region_for_lad(data, vb, soe)
    ),
    "Check geography",
    log_key,
    log_dir,
    data_details
  )
  all_results <- res$all_results
  if (res$early_return) {
    return(as.data.frame(all_results))
  }

  # Check filters -------------------------------------------------------------
  res <- run_and_log_check(
    all_results,
    rbind(
      check_filter_defaults(data, meta, vb, soe),
      check_filter_group_level(data, meta, vb, soe),
      check_filter_item_limit(data, meta, vb, soe),
      check_filter_whitespace(data, meta, vb, soe),
      check_filter_ob_total(data, meta, vb, soe),
      check_filter_blanks(data, meta, vb, soe)
    ),
    "Check filters",
    log_key,
    log_dir,
    data_details
  )
  all_results <- res$all_results
  if (res$early_return) {
    return(as.data.frame(all_results))
  }

  # Check geography -----------------------------------------------------------
  res <- run_and_log_check(
    all_results,
    rbind(
      check_geog_country_combos(data, vb, soe),
      check_geog_region_combos(data, vb, soe),
      check_geog_ward_combos(data, vb, soe),
      check_geog_pcon_combos(data, vb, soe),
      check_geog_lad_combos(data, vb, soe),
      check_geog_lep_combos(data, vb, soe),
      check_geog_lsip_combos(data, vb, soe),
      check_geog_la_combos(data, vb, soe)
    ),
    "Check geography",
    log_key,
    log_dir,
    data_details
  )
  all_results <- res$all_results
  if (res$early_return) {
    return(as.data.frame(all_results))
  }

  # Check indicators ----------------------------------------------------------
  res <- run_and_log_check(
    all_results,
    rbind(
      check_ind_invalid_entry(data, meta, vb, soe)
    ),
    "Check indicators",
    log_key,
    log_dir,
    data_details
  )
  all_results <- res$all_results
  if (res$early_return) {
    return(as.data.frame(all_results))
  }

  # Check API -----------------------------------------------------------------
  check_api_results <- rbind(
    check_api_char_col_name(data, vb, soe),
    check_api_char_col_label(meta, vb, soe),
    check_api_char_loc_code(data, vb, soe),
    check_api_char_filter_items(data, meta, vb, soe)
  )

  if (dd_checks) {
    check_api_results <- rbind(
      check_api_results,
      check_api_dict_col_names(meta, vb, soe)
    )
  }

  res <- run_and_log_check(
    all_results,
    check_api_results,
    "Check API",
    log_key,
    log_dir,
    data_details
  )
  all_results <- res$all_results
  if (res$early_return) {
    return(as.data.frame(all_results))
  }

  # Success return ------------------------------------------------------------
  api_pass <- all(
    all_results[all_results[["stage"]] == "Check API", "result"] == "PASS"
  )

  if (verbose) {
    if (api_pass) {
      cli::cli_alert_success("Data and metadata passed all checks")
    } else {
      cli::cli_alert_info(
        paste(
          "Data and metadata passed, but warnings prevent it",
          "being suitable for the API"
        )
      )
    }
  }

  as.data.frame(all_results)
}
