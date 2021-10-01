# Install needed package
if(!require("devtools")) install.packages("devtools"); library("devtools")
if(!require("rmarkdown")) install.packages("rmarkdown"); library("rmarkdown")

# If you have a Windows computer, download and install Rtools: 
# https://cran.r-project.org/bin/windows/Rtools/
# Restart R and continue (you can do this by clicking 'Session>Restart R' in Rstudio)

#### 1. Sign up at GitHub.com ################################################

## If you do not have a GitHub account, sign up here:
## https://github.com/join

# ----------------------------------------------------------------------------

#### 2. Install git ##########################################################

## If you do not have git installed, please do so: 
## Windows ->  https://git-scm.com/download/win
## Mac     ->  https://git-scm.com/download/mac
## Linux   ->  https://git-scm.com/download/linux
##             or: $ sudo dnf install git-all

# Restart Rstudio after the installation to make sure RStudio knows where to search for git

# ----------------------------------------------------------------------------

### 3. Configure git with Rstudio ############################################

## set your user name and email, edit the following command and run:
usethis::use_git_config(user.name = "yourname", user.email = "name.surname@email.com")
## create a personal access token for authentication:
usethis::create_github_token()
## Copy the created access token

## set personal access token:
credentials::set_github_pat("xxxyyyzzz")

## and store it manually in '.Renviron':
usethis::edit_r_environ()
## store your personal access token with: GITHUB_PAT=xxxyyyzzz
## and make sure '.Renviron' ends with a newline
## Save '.Renviron'

# ----------------------------------------------------------------------------

#### 4. Restart R! ###########################################################

# ----------------------------------------------------------------------------

#### 5. Verify settings ######################################################

usethis::git_sitrep()

## Your username and email should be stated correctly in the output. 
## Also, the report shoud contain something like:
## 'Personal access token: '<found in env var>''

# ----------------------------------------------------------------------------

#### 6. Test installing the course package ###################################

# Install needed package
if(!require("devtools")) install.packages("devtools"); library("devtools")
if(!require("rmarkdown")) install.packages("rmarkdown"); library("rmarkdown")

# Make sure edcpR is not in use before installing
unloadNamespace("edcpR")

# Install/update course package
# The first line of the output should now say "Using github PAT from envvar GITHUB_PAT"
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
