#' Check we have the right columns for the geographic level
#'
#' @param data A data frame of the data file
#' @param verbose logical, if TRUE prints feedback messages to console for
#' every test, if FALSE run silently
#' @param stop_on_error logical, if TRUE will stop with an error if the result
#' is "FAIL", and will throw genuine warning if result is "WARNING"
#'
#' @family check_geography
#'
#' @examples
#' precheck_geography_level_present(example_data)
#' precheck_geography_level_present(example_data, verbose = TRUE)
#' precheck_geography_level_present(example_comma_data, verbose = TRUE)
#' @export
precheck_geography_level_present <- function(
  data,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  if (all(data$geographic_level == "National")) {
    output <- list(
      "message" = "There is only National level data in the file.",
      "result" = "IGNORE"
    )
  } else {
    expected_cols <- function(i) {
      # if a geographic level is present, then this returns the expected cols from the pre-defined geography_matrix
      if (i[1] %in% data$geographic_level) {
        return(i[2:4])
      }
    }
    # filter out the non table tool rows / cols from geography matrix
    geography_present <- geography_df |>
      dplyr::filter(geographic_level != "Planning area") |>
      dplyr::select(-row_number) |>
      as.matrix()

    missing_cols <- unlist(apply(geography_present, 1, expected_cols))
    missing_cols <- missing_cols[!is.na(missing_cols)] |>
      setdiff(names(data))
    if (length(missing_cols) == 0) {
      output <- list(
        "message" = "The geography columns are present as expected for the geographic_level values in the file.",
        "result" = "PASS"
      )
    } else {
      missing_cols <- paste0("'", missing_cols, "'", sep = "")
      output <- list(
        "message" = paste0(
          "Given that the following geographic_level values are present: '",
          paste(unique(data$geographic_level), collapse = "', '"),
          cli::pluralize(
            "'; <br> - the following column{?s} {?is/are} missing from the file: {missing_cols}."
          )
        ),
        "result" = "FAIL"
      )
    }
  }

  return(output)
}
