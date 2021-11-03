## code to prepare datasets for research questions goes here

Compiegne_sp <- read.csv("./data-raw/Compiegne_sp.csv", sep = ";")
Compiegne_env <- read.csv("./data-raw/Compiegne_env.csv", sep = ";")

usethis::use_data(Compiegne_sp, overwrite = TRUE)
usethis::use_data(Compiegne_env, overwrite = TRUE)