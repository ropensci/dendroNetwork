#' Create dendrochronologial networks
#'
#' Function to create dendrochronological networks based on the similarity. The input for this function is a similarity table created with the sim_table() function. The thresholds are set to the defaults (Visser 2021).
#'
#' @param sim_table a table of similarities created by the sim_table() function
#' @param r_threshold all correlations equal or above this value are taken into account for the creation of edges. If you want all positive correlations included set this to 0.
#' @param sgc_threshold all sgc-values equal or above this value are taken into account for the creation of edges.
#' @param p_threshold all probabilities of exceedence equal or below this value are taken into account for the creation of edges.
#' @param corr_type choose between the correlation based on wuchswerte (r_hol: Hollstein 1980) or the correlation without extra transformation (r)
#'
#' @returns A simplified network of tree-ring material with the edges defined by the similarity.
#' @examples
#' data(hol_rom)
#' sim_table_hol <- sim_table(hol_rom)
#' g_hol <- dendro_network(sim_table_hol)
#' plot(g_hol)
#' g_hol_r_low <- dendro_network(sim_table_hol, r_threshold = 0.3, sgc_threshold = 0.6, corr_type = "r")
#' plot(g_hol_r_low)
#'
#' @references
#' Visser, RM. 2021a Dendrochronological Provenance Patterns. Network Analysis of Tree-Ring Material Reveals Spatial and Economic Relations of Roman Timber in the Continental North-Western Provinces. Journal of Computer Applications in Archaeology 4(1): 230–253. DOI: https://doi.org/10.5334/jcaa.79.
#'
#'
#' @export dendro_network
#'
#'
dendro_network <- function(sim_table,
                           r_threshold = 0.5,
                           sgc_threshold = 0.7,
                           p_threshold = 0.0001,
                           corr_type = "r_hol") {
  if (corr_type == "r_hol") {
    netw_data <- sim_table |>
      dplyr::filter(r_hol >= r_threshold, sgc >= sgc_threshold, p <= p_threshold) |>
      dplyr::select(series_a, series_b)
  } else if (corr_type == "r") {
    netw_data <- sim_table |>
      dplyr::filter(r >= r_threshold, sgc >= sgc_threshold, p <= p_threshold) |>
      dplyr::select(series_a, series_b)
  } else {
    stop("The corr_type should be either r_hol or r.")
  }
  netw_data <- unique(netw_data)
  graph_dendro <- igraph::graph_from_data_frame(netw_data, directed = FALSE)
  graph_dendro <- igraph::simplify(graph_dendro)
  graph_dendro
}
