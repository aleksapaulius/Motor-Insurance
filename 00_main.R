
# Loading Packages
library("stats")
library("arm")
library("jtools")
library("broom")
library("ggstance")
library("magrittr")
library("reshape2")
library("ggplot2")
library("ggcorrplot")


# input
mdata <- read.csv2(file = "input/Data.csv", sep = ",", dec = '.')


# Descriptive statistics
ls.str(mdata)
hist(mdata$claim_count, breaks = 50) 
mean(mdata$claim_count) 
var(mdata$claim_count) 
table(mdata$claim_count) 


# Data preparation/cleaning
# Change type of variables
mdata$num_exposure <- suppressWarnings(as.numeric(as.character(mdata$num_exposure)))
# remove NULL values


# Correlation
source("01_correlation.R")

# Model
source("02_model.R")



