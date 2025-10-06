terms <- c("Spring term", "Autumn term", "Summer term")

months <- c(
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December"
)

weeks <- c(
  "Week 1",
  "Week 2",
  "Week 3",
  "Week 4",
  "Week 5",
  "Week 6",
  "Week 7",
  "Week 8",
  "Week 9",
  "Week 10",
  "Week 11",
  "Week 12",
  "Week 13",
  "Week 14",
  "Week 15",
  "Week 16",
  "Week 17",
  "Week 18",
  "Week 19",
  "Week 20",
  "Week 21",
  "Week 22",
  "Week 23",
  "Week 24",
  "Week 25",
  "Week 26",
  "Week 27",
  "Week 28",
  "Week 29",
  "Week 30",
  "Week 31",
  "Week 32",
  "Week 33",
  "Week 34",
  "Week 35",
  "Week 36",
  "Week 37",
  "Week 38",
  "Week 39",
  "Week 40",
  "Week 41",
  "Week 42",
  "Week 43",
  "Week 44",
  "Week 45",
  "Week 46",
  "Week 47",
  "Week 48",
  "Week 49",
  "Week 50",
  "Week 51",
  "Week 52"
)

financial_quarters <- c(
  "Financial year Q1",
  "Financial year Q2",
  "Financial year Q3",
  "Financial year Q4"
)

financial_halves <- c(
  "Part 1 (April to September)",
  "Part 2 (October to March)"
)

acceptable_time_ids <- c(
  "Autumn and spring term",
  "Calendar year",
  "Financial year",
  "Academic year",
  "Tax year",
  "Reporting year",
  terms,
  weeks,
  months,
  financial_quarters,
  financial_halves
)

usethis::use_data(acceptable_time_ids, overwrite = TRUE)
