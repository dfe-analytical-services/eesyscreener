#' Screen a ZIP archive for upload to EES
#'
#' Validates the ZIP structure by running the `check_zip_*` family of checks,
#' then extracts the archive and runs `screen_csv()` on every data / meta pair
#' inside it. All pairs are always screened — there is no early exit once the
#' structure checks pass.
#'
#' @param zippath A character string giving the path to the ZIP file.
#' @inheritParams screen_csv
#'
#' @return A named list. The first element, `zip_structure`, is a data frame
#'   of ZIP structure check results (columns `check`, `result`, `message`,
#'   `guidance_url`, `stage`), one row per check. Each subsequent element is a
#'   `screen_csv()` result named by the data file stem (e.g. `result$my_data`).
#'   If any structure check fails the function returns early with only
#'   `zip_structure` present and no pair entries.
#'
#' @examples
#' \dontrun{
#' tmp_zip <- tempfile(fileext = ".zip")
#' d <- tempfile()
#' dir.create(d)
#' write.csv(example_data, file.path(d, "ex.csv"), row.names = FALSE)
#' write.csv(example_meta, file.path(d, "ex.meta.csv"), row.names = FALSE)
#' zip::zip(tmp_zip, c("ex.csv", "ex.meta.csv"), root = d)
#'
#' res <- screen_zip(tmp_zip, verbose = TRUE)
#' res$ex$passed
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
  attach_stage <- function(df) {
    df$stage <- "ZIP structure"
    df
  }

  readable_raw <- check_zip_readable(
    zippath,
    verbose = verbose,
    stop_on_error = stop_on_error
  )
  file_entries <- attr(readable_raw, "file_entries")
  readable_result <- attach_stage(readable_raw)

  if (readable_result$result == "FAIL") {
    return(list(zip_structure = readable_result))
  }

  has_names_file <- "dataset_names.csv" %in% file_entries

  structure_checks <- list(
    readable_result,
    attach_stage(check_zip_flat_structure(
      file_entries,
      verbose = verbose,
      stop_on_error = stop_on_error
    )),
    attach_stage(check_zip_names_file_presence(
      file_entries,
      verbose = verbose,
      stop_on_error = stop_on_error
    ))
  )

  names_file_df <- NULL
  format_passed <- TRUE
  if (has_names_file) {
    tmp_names_file <- tempfile()
    dir.create(tmp_names_file)
    on.exit(unlink(tmp_names_file, recursive = TRUE), add = TRUE)
    zip::unzip(zippath, files = "dataset_names.csv", exdir = tmp_names_file)

    # read.csv can throw on malformed CSVs (unterminated quotes, bad
    # encoding, etc.). Catch so screen_zip's "every failure surfaces as a
    # FAIL row" contract holds.
    names_file_df <- tryCatch(
      utils::read.csv(
        file.path(tmp_names_file, "dataset_names.csv"),
        stringsAsFactors = FALSE
      ),
      error = function(e) e
    )

    if (inherits(names_file_df, "error")) {
      read_fail <- attach_stage(test_output(
        "zip_names_file_format",
        "FAIL",
        paste0(
          "dataset_names.csv could not be read: ",
          conditionMessage(names_file_df),
          "."
        ),
        verbose = verbose,
        stop_on_error = stop_on_error
      ))
      structure_checks <- c(structure_checks, list(read_fail))
      names_file_df <- NULL
      format_passed <- FALSE
    } else {
      format_result <- attach_stage(check_zip_names_file_format(
        names_file_df,
        verbose = verbose,
        stop_on_error = stop_on_error
      ))
      structure_checks <- c(structure_checks, list(format_result))
      format_passed <- format_result$result == "PASS"
    }
  }

  # Skip pair / unreferenced checks when the names file is malformed — their
  # inputs would be unreliable and produce noisy false positives.
  if (format_passed) {
    structure_checks <- c(
      structure_checks,
      list(
        attach_stage(check_zip_pairs(
          file_entries,
          names_file_df,
          verbose = verbose,
          stop_on_error = stop_on_error
        )),
        attach_stage(check_zip_no_unreferenced(
          file_entries,
          names_file_df,
          verbose = verbose,
          stop_on_error = stop_on_error
        ))
      )
    )
  }

  zip_structure <- do.call(rbind, structure_checks)

  if (any(zip_structure$result == "FAIL")) {
    return(list(zip_structure = zip_structure))
  }

  # Safe to extract: check_zip_flat_structure has already rejected any entry
  # containing '/', which guards against path-traversal entries.
  tmp <- tempfile()
  dir.create(tmp)
  on.exit(unlink(tmp, recursive = TRUE), add = TRUE)
  zip::unzip(zippath, exdir = tmp)

  stems <- if (!is.null(names_file_df)) {
    names_file_df$file_name
  } else {
    extracted <- list.files(tmp, pattern = "\\.csv$")
    sub("\\.csv$", "", extracted[!grepl("\\.meta\\.csv$", extracted)])
  }

  # Stems can come from user-controlled dataset_names.csv content. Path
  # traversal is blocked upstream: check_zip_pairs requires
  # paste0(stem, ".csv") to exist as a zip entry, and check_zip_flat_structure
  # rejects any entry containing "/", so a "../foo" stem cannot reach here.
  pair_results <- list()
  for (stem in stems) {
    pair_results[[stem]] <- screen_csv(
      file.path(tmp, paste0(stem, ".csv")),
      file.path(tmp, paste0(stem, ".meta.csv")),
      datafilename = paste0(stem, ".csv"),
      metafilename = paste0(stem, ".meta.csv"),
      log_key = log_key,
      log_dir = log_dir,
      dd_checks = dd_checks,
      verbose = verbose,
      stop_on_error = stop_on_error
    )
  }

  c(list(zip_structure = zip_structure), pair_results)
}
