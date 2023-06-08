#' Finding all CPM communities in a network/graph
#'
#' Function to determine all CPM-communities in a network (or graph)
#'
#' @param graph_input the graph for find all CPM communities in
#' @param n_core this defaults to 0, if a number larger than 1 is given the community detection is performed using parallel computing
#' @returns data frame with at least two columns. The first column are the node names and the further columns represent the CPM-communities, with 1 denoting the membership in a community.
#' @examples
#' data(hol_rom)
#' sim_table_hol <- sim_table(hol_rom)
#' g_hol <- dendro_network(sim_table_hol)
#' hol_com_cpm_all <- find_all_cpm_com(g_hol)
#'
#' @export find_all_cpm_com
#'
#' @importFrom magrittr %>%


find_all_cpm_com <- function(graph_input, n_core = 0){
  if (n_core > 1) {
    for (i in 3:igraph::clique_num(graph_input)) {
      com_cpm <- clique_community_names_par(graph_input,i, n_core)
      if (i==3) {
        com_cpm_all <- com_cpm}
      else {
        com_cpm_all <- rbind(com_cpm_all,com_cpm)
      }
    }
  } else{
    for (i in 3:igraph::clique_num(graph_input)) {
      com_cpm <- clique_community_names(graph_input,i)
      if (i==3) {
        com_cpm_all <- com_cpm}
      else {
        com_cpm_all <- rbind(com_cpm_all,com_cpm)
      }
    }
  }
  com_cpm_all <- com_cpm_all %>% dplyr::count(node, com_name) %>% tidyr::spread(com_name, n)
  com_cpm_all
}
