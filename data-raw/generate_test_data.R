# Quick script to help with copying test data from the existing screener

# Read in CSVs from GitHub

# 1. Find the file
# 2. View the 'raw'
# 3. Copy that URL into the below

test_data <- read.csv("https://raw.githubusercontent.com/dfe-analytical-services/dfe-published-data-qa/refs/heads/main/tests/testthat/fileValidation/data_empty_rows.csv")
test_meta <- read.csv("https://raw.githubusercontent.com/dfe-analytical-services/dfe-published-data-qa/refs/heads/main/tests/testthat/fileValidation/data_empty_rows.meta.csv")

# Do some processing - really prune the file as small as you can!
test_data_pruned <- test_data |>
  subset(select = -c(6:61))

test_meta_pruned <- test_meta[-c(1:51), ] |>
  # add some blank rows
  rbind(data.frame(matrix(ncol = ncol(test_meta), nrow = 5, dimnames = list(NULL, names(test_meta)))))

# Save into the tests/testthat/test_data folder
# - Make sure the name relates to the function name you're using it to test
saveRDS(test_data_pruned, "tests/testthat/test_data/check_empty_rows.RDS")
saveRDS(test_meta_pruned, "tests/testthat/test_data/check_empty_rows.meta.RDS")
