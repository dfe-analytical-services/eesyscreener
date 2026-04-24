#' Run all ZIP structure checks against a ZIP file
#'
#' Orchestrates the `check_zip_*` family of checks. Runs `check_zip_readable()`
#' first and returns early if it fails (subsequent checks require a readable
#' ZIP). Otherwise, runs all remaining structure checks and returns a combined
#' results data frame.
#'
#' The `stage` column is set to `"ZIP structure"` for every row, mirroring
#' how `screen_filenames()` and `screen_dfs()` attach their stage labels.
#'
#' @param zippath A character string giving the path to the ZIP file.
#' @param verbose logical, if TRUE prints feedback messages to console for
#' every test, if FALSE run silently
#' @param stop_on_error logical, if TRUE will stop with an error if any check
#' returns "FAIL", and will throw genuine warning if any returns "WARNING"
#'
#' @return A data frame with columns `check`, `result`, `message`,
#'   `guidance_url`, and `stage`, one row per check run. If
#'   `check_zip_readable()` fails, only that single row is returned.
#'
#' @examples
#' \dontrun{
#' screen_zip_structure("path/to/upload.zip")
#' }
#' @export
screen_zip_structure <- function(
  zippath,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  attach_stage <- function(df) {
    df$stage <- "ZIP structure"
    df
  }

  readable_result <- check_zip_readable(
    zippath,
    verbose = verbose,
    stop_on_error = stop_on_error
  ) |>
    attach_stage()

  if (readable_result$result == "FAIL") {
    return(readable_result)
  }

  file_entries <- zip::zip_list(zippath)$filename
  has_manifest <- "dataset_names.csv" %in% file_entries

  all_results <- readable_result

  flat_result <- check_zip_flat_structure(
    file_entries,
    verbose = verbose,
    stop_on_error = stop_on_error
  ) |>
    attach_stage()
  all_results <- rbind(all_results, flat_result)

  manifest_presence_result <- check_zip_manifest_presence(
    file_entries,
    verbose = verbose,
    stop_on_error = stop_on_error
  ) |>
    attach_stage()
  all_results <- rbind(all_results, manifest_presence_result)

  if (has_manifest) {
    tmp_manifest <- tempfile()
    on.exit(unlink(tmp_manifest, recursive = TRUE), add = TRUE)
    dir.create(tmp_manifest)
    zip::unzip(zippath, files = "dataset_names.csv", exdir = tmp_manifest)
    manifest_df <- utils::read.csv(
      file.path(tmp_manifest, "dataset_names.csv"),
      stringsAsFactors = FALSE
    )

    format_result <- check_zip_manifest_format(
      manifest_df,
      verbose = verbose,
      stop_on_error = stop_on_error
    ) |>
      attach_stage()
    all_results <- rbind(all_results, format_result)

    pairs_result <- check_zip_pairs(
      file_entries,
      manifest_df,
      verbose = verbose,
      stop_on_error = stop_on_error
    ) |>
      attach_stage()
    all_results <- rbind(all_results, pairs_result)

    unreferenced_result <- check_zip_no_unreferenced(
      file_entries,
      manifest_df,
      verbose = verbose,
      stop_on_error = stop_on_error
    ) |>
      attach_stage()
    all_results <- rbind(all_results, unreferenced_result)
  } else {
    unreferenced_result <- check_zip_no_unreferenced(
      file_entries,
      NULL,
      verbose = verbose,
      stop_on_error = stop_on_error
    ) |>
      attach_stage()
    all_results <- rbind(all_results, unreferenced_result)
  }

  all_results
}
