library(validate)

data(VSAdat)

rules <- validator(
  VSA(data=., idvars = c("TABLE","FREQ","REPORTING","PARTNER","DIRECTION","AGE")) == TRUE
)
cf <- confront(VSAdat, rules,raise="all")

out <- as.data.frame(cf)
expect_equal(out$value, rep(c(TRUE, FALSE), each=8))

