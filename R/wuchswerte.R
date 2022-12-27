#' Wuchswerte (Hollstein 1980)
#'
#' Function to normalize tree-ring values according to Hollsteins transformation to Wuchswerte
#'
#' Published on pages 14-15 in Hollstein, E. 1980. Mitteleuropäische Eichenchronologie. Trierer Dendrochronologische Forschungen zur Archäologie und Kunstgeschichte. Trierer Grabungen und Forschungen 11. Mainz am Rhein: Verlag Philipp von Zabern.
#'
#' @param x tree-ring series
#' @returns tree-ring series normalized according to Hollstein (1980, 14-15)
#' @examples
#' wuchswerte(trs)
#' to convert rwl to wuchwerte use: as.rwl(apply(treering_rwl, 2, wuchswerte))

wuchswerte <- function(x) {
  x2 <- c(NA,x[-length(x)])
  wuchswerte <- 100*log(x/x2)
  wuchswerte
}
