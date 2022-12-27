# function to normalize according to Hollsteins transformation to Wuchswerte
# wuchswerte Hollstein(1980, 14-15) Y(i)=100 ln (b(i)/b(i-1))
# eLog(w(n)/w(n+1)) 
# author: Ronald M. Visser
# to convert rwl to wuchwerte use: as.rwl(apply(treering_rwl, 2, wuchswerte))
wuchswerte <- function(x) {
  x2 <- c(NA,x[-length(x)])
  wuchswerte <- 100*log(x/x2)
  wuchswerte
}