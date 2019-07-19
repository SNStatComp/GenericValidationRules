library(validate)

data(FDTdat)

rules <- validator(FDT(OBS_VALUE, ft="Numeric", exceptions="NA")==TRUE)
cf <- confront(FDTdat,rules, raise="all")
out <- as.data.frame(cf)
expect_equal(out$value, c(TRUE,FALSE, TRUE, FALSE))


