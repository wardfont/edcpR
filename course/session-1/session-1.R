# An R script is just a simple .txt file but with the .R file extension instead
# The only thing in this file is what you see here.

a <- 1
a

# bigger object
data <- cars

class(a)
class(data)
class(data$speed)

# ---------------- #

#ask for documentation
?lm()

?class()

install.packages("dplyr")
library(dplyr)

?dplyr

browseVignettes(package = "dplyr")

vignette(package = "dplyr")
vignette("dplyr", package = "dplyr")


