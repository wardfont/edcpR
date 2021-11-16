## code to prepare all datasets for session 5 goes here

plant_growth <- read.csv("./data-raw/plantgrowth.csv", sep = ";")
meerdaal <- read.csv("./data-raw/Meerdaal.csv", sep = ";")
kembel_sp <- read.csv("./data-raw/kembel_sp.csv")

usethis::use_data(plant_growth, overwrite = TRUE)
usethis::use_data(meerdaal, overwrite = TRUE)
usethis::use_data(kembel_sp, overwrite = TRUE)
