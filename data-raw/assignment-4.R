## code to prepare all datasets for assignment 4 goes here

GutterTor_Ellenberg <- read.csv("./data-raw/GutterTor_Ellenberg.csv", sep = ";")
GutterTor_env <- read.csv("./data-raw/GutterTor_env.csv", sep = ";")
GutterTor_sp <- read.csv("./data-raw/GutterTor_Species.csv", sep = ";")


usethis::use_data(GutterTor_Ellenberg, overwrite = TRUE)
usethis::use_data(GutterTor_env, overwrite = TRUE)
usethis::use_data(GutterTor_sp, overwrite = TRUE)
