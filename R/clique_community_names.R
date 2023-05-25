#' Clique Percolation Method (with node names)
#'
#' Function to determine communities in a network using clique percolation method (Palla et al., 2005). Communities are created based on cliques. Cliques are subsets of a network that can be considered complete (sub)networks. The size of the cliques to be used to community detection is part of the input of the function.
#'
#' @param g network object (igraph)
#' @param k clique size to be used, default set to smallest possible size (3)
#'
#' @returns a dataframe with node names and community name (CPM_K[k]_number_of_community)
#'
#' @examples
#' hol_sim <- sim_table(hol_rom)
#' g_hol <- dendro_network(hol_sim)
#' clique_community_names(g_hol, k=3)
#'
#' @references
#' Palla, G., Derényi, I., Farkas, I., & Vicsek, T. (2005). Uncovering the overlapping community structure of complex networks in nature and society. Nature, 435(7043), 814-818.
#' Code adapted from source: https://github.com/angelosalatino/CliquePercolationMethod-R
#'
#' @export clique_community_names
#'
#' @importFrom magrittr %>%

clique_community_names <- function(g, k=3) {
  if (k > igraph::clique_num(g)){
    stop(paste0("The maximum clique size in the network is ", igraph::clique_num(g), ". Therefore k cannot exceed this number"))
  }
  clq <- igraph::cliques(g, min=k, max=k) %>% lapply(as.vector)
  # get node names
  node <- (igraph::V(g)$name)
  node <- as.data.frame(node)
  node <- node %>% dplyr::mutate(id = dplyr::row_number())
  #find edges
  edges <- c()
  for (i in seq_along(clq)) {
    for (j in seq_along(clq)) {
      if ( length(unique(c(clq[[i]], clq[[j]]))) == k+1 ) {
        edges[[length(edges)+1]] <- c(i,j)
      }
    }
  }
  #Create an empty graph and then adding edges
  clq.graph <- igraph::make_empty_graph(n = length(clq)) %>% igraph::add_edges(unlist(edges))
  if (!igraph::is.simple(clq.graph)) {
    clq.graph <- igraph::simplify(clq.graph)
  }
  igraph::V(clq.graph)$name <- seq_len(igraph::vcount(clq.graph))
  comps <- igraph::decompose.graph(clq.graph)
  comps <- lapply(comps, function(x) {
    unique(unlist(clq[igraph::V(x)$name ]))
  })
  # create dataframe with node names and community name (CPM_K[k]_number)
  comp_n <- unlist(lapply(comps, function(x) length(x)))
  comp_nr <- seq(1:length(comp_n))
  comp_nrs <- rep(comp_nr, comp_n)
  comp_list <- unlist(comps)
  commu <- cbind(comp_nrs,comp_list)
  colnames(commu) <- c("com","id")
  com_all <- merge(commu,node, by="id")
  leading_zeroes <- nchar(length(comp_n))
  com_all <- com_all  %>% dplyr::mutate(com_name = paste0("CPM_K", k, "_", formatC(com, width=leading_zeroes, flag="0")))
  com_all <- com_all %>% dplyr::select(node, com_name)
  com_all <- com_all %>% dplyr::arrange(com_name, node)
  com_all
}
