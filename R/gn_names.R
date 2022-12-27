gn_names <- function(g) {
  g_GN <- cluster_edge_betweenness(g, weights = E(g)$weight, directed = FALSE,
                                  edge.betweenness = TRUE, merges = TRUE, bridges = TRUE,
                                  modularity = TRUE, membership = TRUE)
  com_all <- cbind(V(g)$name,g_GN$membership)
  colnames(com_all) <- c("node","com_id")
  com_all <- as.data.frame(com_all)  %>% mutate(com_name = paste0("GN_", formatC(com_id, width=2, flag="0")))
  com_all <- com_all %>% select(node, com_name)  
  com_all <- com_all %>% select(node, com_name)  
  com_all <- com_all %>% arrange(com_name, node)  
  
}
