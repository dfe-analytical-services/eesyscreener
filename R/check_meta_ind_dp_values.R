#' Check indicator_dp only contains blanks or positive integer values.
#'
#' This function checks that The indicator_dp column only contains blanks or
#' positive integer values.
#'
#' @inheritParams precheck_meta_col_type
#'
#' @inherit check_filename_spaces return
#'
#' @family check_meta
#'
#' @examples
#' check_meta_ind_dp_values(example_meta)
#' check_meta_ind_dp_values(example_meta, verbose = TRUE)
#' @export
check_meta_ind_dp_values <- function(
  meta,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  if (all(is.na(meta$indicator_dp))) {
    test_output(
      "ind_dp_values",
      "PASS",
      "The indicator_dp column only contains blanks.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    if (is.numeric(meta$indicator_dp)) {
      is_integer <- function(x) {
        test <- all.equal(x, as.integer(x), check.attributes = FALSE)
        if (test == TRUE) {
          TRUE
        } else {
          FALSE
        }
      }

      meta$integer <- lapply(meta$indicator_dp, is_integer)
      meta$notNegative <- lapply(meta$indicator_dp, function(x) x >= 0)
      failed_rows <- rbind(
        meta |> dplyr::filter(integer == FALSE),
        meta |> dplyr::filter(.data$notNegative == FALSE)
      )

      if (nrow(failed_rows) != 0) {
        test_output(
          "ind_dp_values",
          "FAIL",
          paste0(
            "The indicator_dp column must only contain blanks,",
            " zero, or positive integer values in the metadata file."
          ),
          verbose = verbose,
          stop_on_error = stop_on_error
        )
      } else {
        test_output(
          "ind_dp_values",
          "PASS",
          paste0(
            "The indicator_dp column only contains blanks,",
            " zero, or positive integer values."
          ),
          verbose = verbose,
          stop_on_error = stop_on_error
        )
      }
    } else {
      test_output(
        "ind_dp_values",
        "FAIL",
        paste0(
          "The indicator_dp column must only contain blanks,",
          " zero, or positive integer values in the metadata file."
        ),
        verbose = verbose,
        stop_on_error = stop_on_error
      )
    }
  }
}
