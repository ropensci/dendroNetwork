#' Wuchswerte (Hollstein 1980)
#'
#' Function to normalize tree-ring values according to Hollsteins transformation to Wuchswerte (Hollstein 1980, 14-15).
#'
#' @references
#'
#' Hollstein, E. 1980. Mitteleuropäische Eichenchronologie. Trierer Dendrochronologische Forschungen zur Archäologie und Kunstgeschichte. Trierer Grabungen und Forschungen 11. Mainz am Rhein: Verlag Philipp von Zabern.
#'
#' @param x tree-ring series
#' @returns tree-ring series normalized according to Hollstein (1980, 14-15)
#' @examples
#' data(hol_rom)
#' wuchswerte(hol_rom)
#' # to convert a rwl object into wuchwerte use:
#' dplR::as.rwl(apply(hol_rom, 2, wuchswerte))
#'
#' @export wuchswerte

wuchswerte <- function(x) {
  x2 <- c(NA,x[-length(x)])
  wuchswerte <- 100*log(x/x2)
  wuchswerte
}
