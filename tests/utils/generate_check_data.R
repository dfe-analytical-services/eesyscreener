# Quick script to help with copying test data from the existing screener

# Read in CSVs from GitHub

# 1. Find the file
# 2. View the 'raw'
# 3. Copy that URL into the below

dom <- "https://raw.githubusercontent.com/dfe-analytical-services/"
repo <- "dfe-published-data-qa/refs/heads/main/"
path_data <- "tests/testthat/fileValidation/data_empty_cols.csv"
path_meta <- "tests/testthat/fileValidation/data_empty_cols.meta.csv"

test_data <- read.csv(paste0(dom, repo, path_data))
test_meta <- read.csv(paste0(dom, repo, path_meta))

# Do some processing - really prune the file as small as you can!
test_data_pruned <- test_data[, -c(14:ncol(test_data))]
test_data_pruned <- test_data_pruned[1:3, ]
test_data_pruned <- test_data_pruned[, -11]

test_meta_pruned <- test_meta[-c(2:7), ]

# Save into the tests/testthat/test_data folder
# - Make sure the name relates to the function name you're using it to test

saveRDS(test_data_pruned, "tests/testthat/test_data/check_empty_cols.RDS")
saveRDS(test_meta_pruned, "tests/testthat/test_data/check_empty_cols.meta.RDS")
