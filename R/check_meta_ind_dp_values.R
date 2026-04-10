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
  # Normalise: treat blank strings as NA; fail if non-blank values can't be
  # converted to numeric
  ind_dp <- meta$indicator_dp
  if (is.character(ind_dp)) {
    blanked <- ifelse(trimws(ind_dp) == "", NA_character_, ind_dp)
    non_blank <- blanked[!is.na(blanked)]
    coerced <- suppressWarnings(as.numeric(non_blank))
    if (any(is.na(coerced))) {
      return(test_output(
        "meta_ind_dp_values",
        "FAIL",
        paste0(
          "The indicator_dp column must only contain blanks,",
          " zero, or positive integer values in the metadata file."
        ),
        verbose = verbose,
        stop_on_error = stop_on_error
      ))
    }
    ind_dp <- suppressWarnings(as.numeric(blanked))
  }

  if (all(is.na(ind_dp))) {
    test_output(
      "meta_ind_dp_values",
      "PASS",
      "The indicator_dp column only contains blanks.",
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  } else {
    if (is.numeric(ind_dp)) {
      is_integer <- function(x) {
        if (is.na(x)) {
          return(TRUE)
        }
        test <- all.equal(x, as.integer(x), check.attributes = FALSE)
        isTRUE(test)
      }

      meta$integer <- vapply(ind_dp, is_integer, logical(1))
      meta$notNegative <- vapply(
        ind_dp,
        function(x) is.na(x) || x >= 0,
        logical(1)
      )
      failed_rows <- rbind(
        meta |> dplyr::filter(!.data$integer),
        meta |> dplyr::filter(!.data$notNegative)
      )

      if (nrow(failed_rows) != 0) {
        test_output(
          "meta_ind_dp_values",
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
          "meta_ind_dp_values",
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
        "meta_ind_dp_values",
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
