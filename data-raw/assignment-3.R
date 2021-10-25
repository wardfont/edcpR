## code to prepare `leuven-a3` and `nphk-a3` dataset goes here

leuven_a3 <- read.csv("./data-raw/leuven_a3.csv")
nphk_a3 <- read.csv("./data-raw/nphk_a3.csv")

usethis::use_data(leuven_a3, overwrite = TRUE)
usethis::use_data(nphk_a3, overwrite = TRUE)
