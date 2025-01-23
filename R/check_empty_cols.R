# data_empty_cols -------------------------------------
# check for blank cols in the data file

check_empty_cols <- function(file) {
  blank_cols <- setdiff(names(file), names(remove_empty(file, which = "cols", quiet = TRUE)))

  if (length(blank_cols) == 0) {
    output <- list(
      "result" = "PASS",
      "message" = "The data file does not have any blank columns"
    )
  } else {
    if (length(blank_cols) == 1) {
      output <- list(
        "result" = "FAIL",
        "message" = paste0("The following column in the data file is empty: '", paste0(blank_cols, collapse = "', '"), "'.")
      )
    } else {
      output <- list(
        "result" = "FAIL",
        "message" = paste0("The following columns in the data file are empty: '", paste0(blank_cols, collapse = "', '"), "'.")
      )
    }
  }

  return(output)
}
