## code to prepare `vegdata_a2` dataset goes here

vegdata_a2 <- read.csv("./data-raw/vegdata-assignment2.csv")
vegdata_a2$Cover_herb <- as.character(vegdata_a2$Cover_herb)

usethis::use_data(vegdata_a2, overwrite = TRUE)
