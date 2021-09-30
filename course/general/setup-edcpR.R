## Run this part for the first install the pacakge, and at the start of each session to update it -------------- #

# Package you need to install a github package
if(!require("devtools")) install.packages("devtools"); library("devtools")

# Make sure edcpR is not in use before installing
unloadNamespace("edcpR")

# Install/update course package
install_github("https://github.com/wardfont/edcpR", build_vignettes = T, force = T)

# Load package
library(edcpR)

## -------------- #

# Look at available vignettes in browser
browseVignettes(package = "edcpR") # and click HTML for vignette you want to look at
# or in Rstudio
vignette(package = "edcpR")

# Open vingette in Rstudio, get the names from the overview produced by the commands above
vignette("session-1")
vignette("assignment-1")
vignette("cheat-sheet")

# Look at available data
data(package = "edcpR")

# Load specific data, get the names from the overview produced by the commands above
data(vegdata1, package = "edcpR")
data(vegdata2, package = "edcpR")
