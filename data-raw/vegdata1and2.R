## code to prepare `vegdata1` and `vegdata2` dataset goes here

vegdata1 <- read.csv("./data-raw/vegdata1.csv", sep = ";")
vegdata1$Date <- as.Date(vegdata1$Date, format = "%e.%m.%Y")
vegdata2 <- read.csv("./data-raw/vegdata2.csv", sep = ";")
vegdata2$Date <- as.Date(vegdata2$Date, format = "%d/%m/%Y")

usethis::use_data(vegdata1, overwrite = TRUE)
usethis::use_data(vegdata2, overwrite = TRUE)
