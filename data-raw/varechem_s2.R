## code to prepare `varechem` dataset goes here

varechem_s2 <- read.csv("./data-raw/varechem-session2.csv", sep = ";")

usethis::use_data(varechem_s2, overwrite = TRUE)
