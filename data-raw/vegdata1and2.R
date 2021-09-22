## code to prepare `vegdata1` dataset goes here

vegdata1 <- read.csv2("./data-raw/vegdata1.csv")
vegdata2 <- read.csv2("./data-raw/vegdata2.csv")

usethis::use_data(vegdata1, overwrite = TRUE)
usethis::use_data(vegdata2, overwrite = TRUE)
