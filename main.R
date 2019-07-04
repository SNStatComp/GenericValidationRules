# load the validate and validatereport packages:
library(validate)
source("genericValidationRules.R")

# load test data:
dat <- read.csv('data/FDL.csv')

# specify rule:
rules <- validator(FDL("PARTNER", min=2, max=4))

# Confront data with rule:
validation <- confront(dat, rules)

#View data and results±
View(dat)
summary(validation)
#barplot(validation[1:7], main='Task2 validation results')


# Generate a  report:
#library(validatereport)
# export_ess_validation_report(validation, rules, file="Task2_Report.json")