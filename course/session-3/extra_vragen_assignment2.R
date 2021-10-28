#######################################################################
####################     Converting dates in R     ####################
#######################################################################

# Load in the data
library(edcpR)
data(vegdata_a2,  package = "edcpR")
dates <- vegdata_a2$Date

# Look at what we have
dates

# Some numeric dates counting days from an origin
as.numeric(dates) # Only gives dates that can be converted to a number, the rest is NA
format_1 <- as.Date(as.numeric(dates), origin = "1899-12-30")

# Some character dates in two formats
# see for symbols: https://devhints.io/datetime
format_2 <- as.Date(dates, format = "%e.%m.%Y") # Only gives dates that fit format, rest is NA
format_3 <- as.Date(dates, format = "%e/%m/%Y")

# Populate a new vector with all non-NA values of the three formats
conv_dates <- format_1
conv_dates[is.na(conv_dates)] <- format_2[is.na(conv_dates)]
conv_dates[is.na(conv_dates)] <- format_3[is.na(conv_dates)]
conv_dates # all in the same format

# Under the hood, R stores the dates as numeric values, but with origin "1970-01-01"
as.numeric(conv_dates)
as.Date(as.numeric(conv_dates), origin = "1970-01-01")

vegdata_a2$Date <- conv_dates

##############################################################################
####################    Finding the exact place of NA     ####################
##############################################################################
library(edcpR)
data(vegdata_a2,  package = "edcpR")

na.position <- which(is.na(vegdata_a2), arr.ind = TRUE)
na.position
