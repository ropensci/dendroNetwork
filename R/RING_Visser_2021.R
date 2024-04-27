#' Roman tree-ring site chronologies
#'
#' Dendrochronological site chronologies published by Visser (2021, 2022). These (pre) Roman site chronologies date between 520 BC and AD 663 and are based on the material of RING (full references to the source data can be found in the supplementary data of Visser 2021)
#' The series are named based on their location, species and type of standardisation
#' For example: ABC_Q1M or ABC_Q1C consist of the same material from the site ABC (Abcoude), species Q(uercus), chronology 1 and standardisation C(ofecha) and M(eans). See Visser(2021) for more explanation.
#'
#'
#' @docType data
#'
#' @usage data(RING_Visser_2021)
#'
#' @format An object of class \code{"rwl"}.
#'
#' @keywords datasets dendrochronology
#'
#' @references
#' Visser, RM. 2021 Dendrochronological Provenance Patterns. Network Analysis of Tree-Ring Material Reveals Spatial and Economic Relations of Roman Timber in the Continental North-Western Provinces. Journal of Computer Applications in Archaeology 4(1): 230–253. DOI: https://doi.org/10.5334/jcaa.79.
#'
#' Visser, RM. 2022 Dendrochronological Provenance Patterns. Code and Data of Network Analysis of Tree-Ring Material. DOI: https://doi.org/10.5281/zenodo.7157744.
#'
#'
#' @examples
#' \dontrun{
#' data(RING_Visser_2021)
#' sim_table(RING_Visser_2021, last_digit_radius = TRUE)
#' }
#'
"RING_Visser_2021"
