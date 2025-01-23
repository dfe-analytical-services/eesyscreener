read_file <- function(file_path) {
  file_separator <- capture.output(main_file <- data.table::fread(file_path, encoding = "UTF-8", na.strings = "", verbose = TRUE, strip.white = FALSE)) %>%
    .[grepl("sep=.* with", .)] %>%
    sub("with.*$", "", x = .) %>%
    trimws(.) %>%
    str_remove(., "^sep='") %>%
    str_remove(., "'$")

  output <- list(
    "mainFile" = main_File,
    "fileSeparator" = file_separator,
    "fileCharacter" = fread(file_path, encoding = "UTF-8", colClasses = c("character"), na.strings = NULL)
  )

  return(output)
}
