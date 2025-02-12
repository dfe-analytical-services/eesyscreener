% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/check_empty_cols.R
\name{check_empty_cols}
\alias{check_empty_cols}
\title{Check for empty columns}
\usage{
check_empty_cols(df, filename = NULL)
}
\arguments{
\item{df}{The data frame to check}

\item{filename}{A character string of the filename to check}
}
\value{
A list containing:
\describe{
\item{check}{Character string with the stage that the check belongs to.}
\item{result}{Character string, either "PASS", "FAIL" or "ADVISORY".}
\item{message}{Character string with feedback about the check.}
}
}
\description{
This function checks for empty cols in a given data frame and returns a list
with the check result and a message.
}
\details{
Filename is optional and is used to populate the feedback message.
}
\examples{
df <- eesyscreener::example_data
check_empty_cols(df, "datafile.csv")
check_empty_cols(df)

}
