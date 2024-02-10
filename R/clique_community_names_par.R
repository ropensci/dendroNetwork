#' Clique Percolation Method (with node names)
#'
#' Function to determine communities in a network using clique percolation method (Palla et al., 2005). Communities are created based on cliques. Cliques are subsets of a network that can be considered complete (sub)networks. The size of the cliques to be used to community detection is part of the input of the function.
#' This function uses parallelisation and should be used for larger networks.
#'
#' @param g network object (igraph)
#' @param k clique size to be used, default set to smallest possible size (3)
#' @param n_core number of cores to be used for parrallisation, defaults to 4
#'
#' @returns a dataframe with node names and community name. The community is named as CPM_Kk_number_of_community with k replaced by the value of k.
#'
#' @examples
#' \donttest{
#' hol_sim <- sim_table(hol_rom)
#' g_hol <- dendro_network(hol_sim, r_threshold = 0.4, sgc_threshold = 0.4)
#' clique_community_names_par(g_hol, k = 3, n_core = 2)
#' }
#'
#' @references
#' Palla, G., Derényi, I., Farkas, I., & Vicsek, T. (2005). Uncovering the overlapping community structure of complex networks in nature and society. Nature, 435(7043), 814-818.
#'
#' Code adapted from source: https://github.com/angelosalatino/CliquePercolationMethod-R/blob/master/clique.community.opt.par.R
#'
#' @author Angelo Salatino
#' @author Ronald Visser
#'
#' @export clique_community_names_par
#'
#' @importFrom magrittr %>%
#' @importFrom foreach %dopar%

clique_community_names_par <- function(g, k = 3, n_core = 4) {
  doParallel::registerDoParallel(cores = n_core)
  if (k > igraph::clique_num(g)) {
    stop(paste0("The maximum clique size in the network is ", igraph::clique_num(g), ". Therefore k cannot exceed this number"))
  }
  # find cliques
  clq <- igraph::cliques(g, min = k, max = k) %>% lapply(as.vector)
  if(length(clq)<2) {
    stop(paste0("The network has only ", length(clq), " cliques and this function is for larger networks. Please use the clique_community_names() function"))

  }
  # get node names
  node <- (igraph::V(g)$name)
  node <- as.data.frame(node)
  node <- node %>% dplyr::mutate(id = dplyr::row_number())
  # find edges
  # find edges between cliques
  edges <- c()
  edges <- foreach::foreach(i = 1:(length(clq) - 1), .combine = c) %dopar% {
    tmp_edg <- list()
    for (j in (i + 1):length(clq)) {
      if (length(unique(c(clq[[i]], clq[[j]]))) == k + 1) {
        tmp_edg[[length(tmp_edg) + 1]] <- c(i, j)
      }
    }
    return(tmp_edg)
  }

  # Create an empty graph and then adding edges
  clq.graph <- igraph::make_empty_graph(n = length(clq)) %>% igraph::add_edges(unlist(edges))
  if (!igraph::is_simple(clq.graph)) {
    clq.graph <- igraph::simplify(clq.graph)
  }
  igraph::V(clq.graph)$name <- seq_len(igraph::vcount(clq.graph))
  comps <- igraph::decompose(clq.graph)
  comps <- lapply(comps, function(x) {
    unique(unlist(clq[igraph::V(x)$name]))
  })
  # create dataframe with node names and community name (CPM_K[k]_number)
  comp_n <- unlist(lapply(comps, function(x) length(x)))
  comp_nr <- seq(1:length(comp_n))
  comp_nrs <- rep(comp_nr, comp_n)
  comp_list <- unlist(comps)
  commu <- cbind(comp_nrs, comp_list)
  colnames(commu) <- c("com", "id")
  com_all <- merge(commu, node, by = "id")
  leading_zeroes <- nchar(length(comp_n))
  com_all <- com_all %>% dplyr::mutate(com_name = paste0("CPM_K", k, "_", formatC(com, width = leading_zeroes, flag = "0")))
  com_all <- com_all %>% dplyr::select(node, com_name)
  com_all <- com_all %>% dplyr::arrange(com_name, node)
  com_all
}
