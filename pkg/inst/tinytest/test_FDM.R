library(validate)

# Test data:
data(FDMdat)

# Example (J1) in par 4.2.3 of ESTAT doc:
rule <- validator(FDM(OBS_STATUS, mandatoryLevel="Empty") == TRUE)
cf <- confront(FDMdat, rule)
out <- as.data.frame(cf)
expect_equal(out$value, c(TRUE, FALSE))


# Example (J1) in par 4.2.3 of ESTAT doc, but than the opposite: mandatory:
rule <- validator(FDM(OBS_STATUS, mandatoryLevel="Mandatory") == TRUE)
cf <- confront(FDMdat, rule)
out <- as.data.frame(cf)
expect_equal(out$value, c(FALSE, TRUE))

