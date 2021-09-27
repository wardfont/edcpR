# Package you need to install a github package
library(devtools)

# Make sure edcpR is not in use before installing
unloadNamespace("edcpR")

# Install course package
install_github("https://github.com/wardfont/edcpR", build_vignettes = T)

# Load library
library(edcpR)

# Look at available vignettes
browseVignettes(package = "edcpR") # and click HTML for vignette you want to look at
# or in Rstudio
vignette(package = "edcpR")

# Open vingette in Rstudio
vignette("session-1")
vignette("assignment-1")

# Look at available data
data(package = "edcpR")

# Load specific data
data(vegdata1, vegdata2)
