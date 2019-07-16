library(validate)

dat <- read.csv("data/VIR.csv")
rules <- validator( VIR(OBS_VALUE, Min=1) == TRUE )
cf <- confront(dat, rules)
out <- as.data.frame(cf)
expect_equal(out$value, c(FALSE, FALSE, TRUE, TRUE))


