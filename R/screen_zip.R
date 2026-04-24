#' Screen a ZIP archive for upload to EES
#'
#' Validates the ZIP structure with `screen_zip_structure()`, then extracts
#' the archive and runs `screen_csv()` on every data/meta pair inside it.
#' All pairs are always screened — there is no early exit once the structure
#' checks pass.
#'
#' @param zippath A character string giving the path to the ZIP file.
#' @inheritParams screen_csv
#'
#' @return A list containing:
#' \itemize{
#'   \item `structure_results` — data frame from `screen_zip_structure()`
#'   \item `pair_results` — named list of `screen_csv()` results, one per
#'     pair, named by the data file stem
#'   \item `overall_stage` — `"ZIP structure"` if structure checks failed,
#'     `"Passed"` if all pairs passed, otherwise the failing stage from the
#'     first failing pair
#'   \item `passed` — `TRUE` only if all structure checks and all pairs passed
#'   \item `api_suitable` — `TRUE` only if all structure checks and all pairs
#'     are API suitable
#' }
#'
#' If `screen_zip_structure()` finds any FAIL the function returns early with
#' `passed = FALSE` and `overall_stage = "ZIP structure"` before extracting
#' the archive.
#'
#' @examples
#' \dontrun{
#' # Build a single-pair ZIP from the built-in example data
#' tmp_zip <- tempfile(fileext = ".zip")
#' d <- tempfile()
#' dir.create(d)
#' write.csv(example_data, file.path(d, "ex.csv"), row.names = FALSE)
#' write.csv(example_meta, file.path(d, "ex.meta.csv"), row.names = FALSE)
#' zip::zip(tmp_zip, c("ex.csv", "ex.meta.csv"), root = d)
#'
#' res <- screen_zip(tmp_zip, verbose = TRUE)
#' res$passed
#' }
#' @export
screen_zip <- function(
  zippath,
  log_key = NULL,
  log_dir = "./",
  dd_checks = TRUE,
  verbose = FALSE,
  stop_on_error = FALSE
) {
  structure_results <- screen_zip_structure(
    zippath,
    verbose = verbose,
    stop_on_error = stop_on_error
  )

  if (any(structure_results$result == "FAIL")) {
    return(list(
      structure_results = structure_results,
      pair_results = list(),
      overall_stage = "ZIP structure",
      passed = FALSE,
      api_suitable = FALSE
    ))
  }

  tmp <- tempfile()
  dir.create(tmp)
  on.exit(unlink(tmp, recursive = TRUE), add = TRUE)
  zip::unzip(zippath, exdir = tmp)

  file_entries <- zip::zip_list(zippath)$filename
  has_manifest <- "dataset_names.csv" %in% file_entries

  if (has_manifest) {
    manifest_df <- utils::read.csv(
      file.path(tmp, "dataset_names.csv"),
      stringsAsFactors = FALSE
    )
    stems <- manifest_df$file_name
  } else {
    data_files <- file_entries[
      grepl("\\.csv$", file_entries) & !grepl("\\.meta\\.csv$", file_entries)
    ]
    stems <- sub("\\.csv$", "", data_files)
  }

  pair_results <- list()
  for (stem in stems) {
    data_path <- file.path(tmp, paste0(stem, ".csv"))
    meta_path <- file.path(tmp, paste0(stem, ".meta.csv"))
    pair_results[[stem]] <- screen_csv(
      data_path,
      meta_path,
      datafilename = paste0(stem, ".csv"),
      metafilename = paste0(stem, ".meta.csv"),
      log_key = log_key,
      log_dir = log_dir,
      dd_checks = dd_checks,
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }

  all_passed <- all(vapply(pair_results, function(r) r$passed, logical(1)))
  all_api_suitable <- all(
    vapply(pair_results, function(r) r$api_suitable, logical(1))
  )

  if (!all_passed) {
    failing <- Filter(function(r) !r$passed, pair_results)
    overall_stage <- failing[[1]]$overall_stage
  } else {
    overall_stage <- "Passed"
  }

  list(
    structure_results = structure_results,
    pair_results = pair_results,
    overall_stage = overall_stage,
    passed = all_passed,
    api_suitable = all_api_suitable
  )
}
