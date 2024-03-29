#' Community detection using the Girvan-Newman algorithm
#'
#' Function to determine the communities in a network using the Girvan-Newman algorithm. This function uses the cluster_edge_betweenness() function from the iGraph package, but creates a more user-friendly output that includes the names of the nodes.
#'
#' References
#' Girvan, M and Newman, MEJ. 2002 Community structure in social and biological networks. Proceedings of the National Academy of Sciences of the United States of America 99(12): 7821–7826. DOI: https://doi.org/10.1073/pnas.122653799.
#' Newman, MEJ and Girvan, M. 2004 Finding and evaluating community structure in networks. Physical Review E 69(2): 026113. DOI: https://doi.org/10.1103/PhysRevE.69.026113.
#'
#' @param g input graph or network that is used for community detection
#' @returns the names of the nodes in the various communities
#' @examples
#' hol_sim <- sim_table(hol_rom)
#' g_hol <- dendro_network(hol_sim)
#' gn_names(g_hol)
#'
#' @export gn_names
#'
#' @importFrom magrittr %>%

gn_names <- function(g) {
  if (!igraph::is.igraph(g)) {
    stop(paste0("Please use an igraph object as input. The current object is an ", class(g), "."))
  }
  g_GN <- igraph::cluster_edge_betweenness(g,
    weights = igraph::E(g)$weight, directed = FALSE,
    edge.betweenness = TRUE, merges = TRUE, bridges = TRUE,
    modularity = TRUE, membership = TRUE
  )
  com_all <- cbind(igraph::V(g)$name, g_GN$membership)
  colnames(com_all) <- c("node", "GN_com")
  leading_zeroes <- max(nchar(com_all[, 2]))
  com_all <- as.data.frame(com_all) %>% dplyr::mutate(com_name = paste0("GN_", formatC(as.numeric(GN_com), width = leading_zeroes, flag = "0")))
  com_all <- com_all %>% dplyr::select(node, com_name)
  com_all <- com_all %>% dplyr::select(node, com_name)
  com_all <- com_all %>% dplyr::arrange(com_name, node)
  com_all
}
