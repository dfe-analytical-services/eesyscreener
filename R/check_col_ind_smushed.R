#' Check that no indicator column names contain typical filter entries
#'
#' Checks the metadata file for any indicators that appear to be 'smushed'.
#' Flags any indicator col_name that contains common filter entries (e.g. male,
#' female, asian, black, etc), which suggests the data may not conform to tidy
#' data principles and should instead be pivoted longer with a filter column to
#' contain the characteristic choices.
#'
#' @inheritParams precheck_meta_col_type
#'
#' @inherit check_filename_spaces return
#'
#' @family check_col
#'
#' @examples
#' check_col_ind_smushed(example_meta)
#' check_col_ind_smushed(example_meta, verbose = TRUE)
#' @export
check_col_ind_smushed <- function(
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  check_name <- get_check_name()

  common_filter_substrings <- c(
    "male",
    "female",
    "asian",
    "chinese",
    "indian",
    "pakistani",
    "bangladeshi",
    "black",
    "african",
    "caribbean",
    "white",
    "roma",
    "irish",
    "english",
    "british",
    "scottish",
    "welsh",
    "northern irish",
    "arab"
  )

  smushed_indicators <- meta |>
    dplyr::filter(
      .data$col_type == "Indicator",
      grepl(
        paste(common_filter_substrings, collapse = "|"),
        .data$col_name,
        ignore.case = TRUE
      )
    ) |>
    dplyr::pull(.data$col_name)

  if (length(smushed_indicators) == 0) {
    test_output(
      check_name,
      "PASS",
      "No indicators found containing typical filter entries.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    test_output(
      check_name,
      "FAIL",
      cli::pluralize(
        "The following {cli::qty(length(smushed_indicators))}indicator{?s} ",
        "{?appears/appear} to not conform to tidy data principles: '",
        paste0(smushed_indicators, collapse = "', '"),
        "'. We recommend pivoting your data longer and adding a filter to",
        " contain characteristic choices."
      ),
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }
}
