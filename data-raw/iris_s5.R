## code to prepare datasets for research questions goes here

iris_s5 <- read.csv("./data-raw/iris_s5.csv")[-1]

usethis::use_data(iris_s5, overwrite = TRUE)
