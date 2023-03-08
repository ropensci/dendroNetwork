#' Create CPM style in Cytoscape
#'
#' Function to create a style in Cytoscape to visualise the communities in a network using clique percolation method (CPM: Palla et al., 2005). See also: find_all_cpm_com()
#' Each node is filled with the colour of the community. If a node is part of several communities a pie chart is used to show the various community colours.
#' The function uses a graph as input and the number of cliques (default = 3). The style can be specified or automatically named based on the name of the network an the number of cliques.
#'
#' @param graph_input the graph with the CPM communities
#' @param com_k CPM communities in graph_input from find_all_cpm_com()
#' @param k clique size for the visualisation
#' @param style_name name of the output style in Cytoscape. If set to "auto", the style is derived from the name of the network and value for k
#' @returns The style applied in Cytoscape, no objects in R as return.
#' @examples
#'
#'

cyto_create_cpm_style <- function(graph_input, com_k, k=3, style_name = "auto") {
  if (style_name == "auto"){
    style_name <- paste0(substitute(graph_input), "_CPM(k=", k, ")")
  }
  copyVisualStyle("GreyNodesLabel", style_name)
  com_k <- clique_community_names(graph_input, k)
  setNodeCustomPieChart(unique(com_k)$com_name,
                        colors = brewer.pal(10, "Paired"),
                        style.name = style_name)
  setVisualStyle(style_name)
}
