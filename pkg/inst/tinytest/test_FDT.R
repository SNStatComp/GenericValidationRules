library(validate)
voptions(raise="all")

dat <- read.csv("data/FDT.csv", na.strings="")

rules <- validator(FDT(OBS_VALUE, ft="Numeric", exceptions="NA")==TRUE)
cf <- confront(dat,rules)
out <- as.data.frame(cf)
expect_equal(out$value, c(TRUE,FALSE, TRUE, FALSE))



