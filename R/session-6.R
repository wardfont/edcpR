## code to prepare datasets for session 6 goes here

varechem_s6 <- read.csv("./data-raw/varechem_s6.csv")
varespec_s6 <- read.csv("./data-raw/varespec_s6.csv")

usethis::use_data(varechem_s6, overwrite = TRUE)
usethis::use_data(varespec_s6, overwrite = TRUE)
