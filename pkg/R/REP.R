library(dplyr)

data <- read.csv('./data/test.csv')
d2 <- data.frame('c'=  c(1,2,3))

REP <- function(data, keyset, ...) {
  res <- data %>%
    group_by(...) %>% 
    do(summarize(.,result = ddd(.,keyset))) %>%
    inner_join(data)
  return(res)
}

ddd <- function(x,y) {
  z <- x %>% inner_join(y)
  res <- nrow(z) == nrow(y)
  return(res)
}

REP(data, d2, a, b)
