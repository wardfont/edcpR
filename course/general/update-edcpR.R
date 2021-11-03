## Run this part to update the package -------------- #

# Install and load needed packages
if(!require("devtools")) install.packages("devtools"); library("devtools")
if(!require("rmarkdown")) install.packages("rmarkdown"); library("rmarkdown")

# Make sure edcpR is not in use before installing
unloadNamespace("edcpR")

# Install/update course package
install_github("https://github.com/wardfont/edcpR", build_vignettes = T, force = T)

# Load package
library(edcpR)

## -------------- #

## This part explains how to access the vignettes and data -------------- #
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
