library(validate)
library(stringr)
source("R/FDL.R")

# Example of good and bad data on par 4.2.2 of ESTAT 
dat <- read.csv('data/FDL.csv')

rule <- validator(FDL(PARTNER, min=2, max=4) == TRUE)

cf <- confront(dat, rule)

summary(cf)
as.data.frame(cf)
