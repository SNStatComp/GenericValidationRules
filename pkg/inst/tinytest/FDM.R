library(validate)
source("R/FDM.R")

# Test data:
dat <- read.csv('data/FDM.csv')

# Example (J1) in par 4.2.3 of ESTAT doc:
rule <- validator(FDM(OBS_STATUS, mandatoryLevel="Empty") == TRUE)
cf <- confront(dat, rule)
summary(cf)
as.data.frame(cf)

# Example (J1) in par 4.2.3 of ESTAT doc, but than the opposite: mandatory:
rule <- validator(FDM(OBS_STATUS, mandatoryLevel="Mandatory") == TRUE)
cf <- confront(dat, rule)
summary(cf)
as.data.frame(cf)
