#' Validate Data and Metadata Files
#'
#' This function performs a series of validation checks on data and metadata files.
#'
#' @param datafilename A string representing the name of the data file.
#' @param metafilename A string representing the name of the metadata file.
#' @param dataseparator A string representing the separator used in the data file.
#' @param metaseparator A string representing the separator used in the metadata file.
#' @param datafile A data frame containing the data file content.
#' @param metafile A data frame containing the metadata file content.
#'
#' @return A tibble with the results of the validation checks.
#'
#' @details The function performs the following validation checks:
#' \itemize{
#'   \item Checks for spaces in the data and metadata filenames.
#'   \item Checks for special characters in the data and metadata filenames.
#'   \item Ensures naming conventions are followed for the data and metadata filenames.
#'   \item Converts rows to columns for comparison between data and metadata files.
#'   \item Validates the file separators used in the data and metadata files.
#'   \item Checks for empty rows in the data and metadata files.
#'   \item Checks for empty columns in the data file.
#'   \item Ensures mandatory columns are present in the data and metadata files.
#' }
#'
#' @keywords internal
#' @examples
#' \dontrun{
#' datafile <- read.csv("data.csv")
#' metafile <- read.csv("meta.csv")
#' result <- fileValidation("data.csv", "meta.csv", ",", ",", datafile, metafile)
#' print(result)
#' }
fileValidation <- function(datafilename, metafilename, dataseparator, metaseparator, datafile, metafile) {
  as_tibble(t(rbind(
    cbind(
      data_filename_spaces(datafilename), # active test
      meta_filename_spaces(metafilename), # active test
      data_filename_special_characters(datafilename), # active test
      meta_filename_special_characters(metafilename), # active test
      naming_convention(datafilename, metafilename), # active test
      rows_to_cols(datafile, metafile), # active test
      file_separator(dataseparator, metaseparator), # active test
      data_empty_rows(datafile), # active test
      meta_empty_rows(metafile), # active test
      data_empty_cols(datafile), # active test
      data_mandatory_cols(datafile), # active test
      meta_mandatory_cols(metafile) # active test
    ),
    "stage" = "fileValidation",
    "test" = c(activeTests$`R/fileValidation.r`)
  )))
}
