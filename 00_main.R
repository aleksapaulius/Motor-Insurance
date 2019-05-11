
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


### input
mdata.input <- read.csv2(file = "input/Data.csv", sep = ",", check.names = F, dec = '.')
mdata <- mdata.input


### Descriptive statistics
ls.str(mdata)
hist(mdata$claim_count, breaks = 50) 
mean(mdata$claim_count) 
var(mdata$claim_count) 
table(mdata$claim_count) 


### Data preparation/cleaning

# Remove 'policy_desc' column
mdata <- mdata[,!(names(mdata) %in% c('policy_desc'))]

# Renaming variables
names(mdata)[names(mdata) == "cat_areacode"] <- "areacode"
names(mdata)[names(mdata) == "num_vehicleAge"] <- "vehicle_age"
names(mdata)[names(mdata) == "num_noClaimDiscountPercent"] <- "discount"
names(mdata)[names(mdata) == "cat_carBrand"] <- "car_brand"
names(mdata)[names(mdata) == "num_populationDensitykmsq"] <- "population_density"
names(mdata)[names(mdata) == "cat_Region"] <- "region"
names(mdata)[names(mdata) == "ord_vehicleHP"] <- "vehicle_hp"
names(mdata)[names(mdata) == "num_exposure"] <- "exposure"
names(mdata)[names(mdata) == "cat_fuelType"] <- "fuel_type"
names(mdata)[names(mdata) == "num_driverAge"] <- "driver_age"

# Change type of variable 'exposure'
mdata$exposure <- suppressWarnings(as.numeric(as.character(mdata$exposure)))

# Remove rows with missing values
any(!complete.cases(mdata))
mdata <- mdata[complete.cases(mdata), ]

# Remove rows where variable 'fuel_type' is NULL
mdata <- mdata[-which(mdata[,'fuel_type'] == 'NULL'), ]


### Correlation
source("01_correlation.R")


### Model
source("02_model.R")



