library(validate)

# Test data:
data(COVdat)

# Example in par 4.2.4 of ESTAT doc:
rule <- validator(COV(DIRECTION, codelistTable="data/COV_CL_DIRECTION.csv") == TRUE)
cf <- confront(COVdat, rule, raise="all")
out <- as.data.frame(cf)

expect_equal(out$value, c(TRUE,FALSE, TRUE, TRUE))

# Test case for case 2:
rule <- validator(COV(DIRECTION, codelist=c("IN", "OUT")) == TRUE)
cf <- confront(COVdat, rule, raise="all")
out <- as.data.frame(cf)

expect_equal(out$value, c(TRUE,FALSE, TRUE, TRUE))
