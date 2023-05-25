#' Create CPM style in Cytoscape
#'
#' Function to create a style in Cytoscape to visualise the communities in a network using clique percolation method (CPM: Palla et al., 2005). See also: find_all_cpm_com()
#' Each node is filled with the colour of the community. If a node is part of several communities a pie chart is used to show the various community colours.
#' The function uses a graph as input and the number of cliques (default = 3). The style can be specified or automatically named based on the name of the network an the number of cliques.
#' Before starting this funtion, Cytoscape must be up and running!
#'
#' @param graph_input the graph with the CPM communities
#' @param com_k CPM communities in graph_input. This is the result of find_all_cpm_com()
#' @param k clique size for the visualisation. If styles are to be generated for all possible clique sizes use "all"
#' @param style_name name of the output style in Cytoscape. If set to "auto", the style is derived from the name of the network and value for k
#' @returns The style applied in Cytoscape, no objects in R as return.
#' @examples
#' data(hol_rom)
#' sim_table_hol <- sim_table(hol_rom)
#' g_hol <- dendro_network(sim_table_hol)
#' hol_com_cpm_all <- find_all_cpm_com(g_hol)
#' cyto_create_cpm_style(g_hol, hol_com_cpm_all, k=3)
#' cyto_create_cpm_style(g_hol, hol_com_cpm_all, k="all")
#'
#' @export cyto_create_cpm_style

cyto_create_cpm_style <- function(graph_input, com_k, k=3, style_name = "auto") {
  if (k=="all"){
    for (i in 3:clique_num(graph_input)) {
      if (style_name == "auto"){
        style_name <- paste0(substitute(graph_input), "_CPM(k=", i, ")")
      }
      copyVisualStyle("GreyNodesLabel", style_name)
      com_k <- clique_community_names(graph_input, i)
      setNodeCustomPieChart(unique(com_k)$com_name,
                            colors = brewer.pal(10, "Paired"),
                            style.name = style_name)
      setVisualStyle(style_name)
      }
  } else {
    if(is.numeric(k)){
      if (style_name == "auto"){
        style_name <- paste0(substitute(graph_input), "_CPM(k=", k, ")")
      }
      copyVisualStyle("GreyNodesLabel", style_name)
      com_k <- clique_community_names(graph_input, k)
      setNodeCustomPieChart(unique(com_k)$com_name,
                            colors = brewer.pal(10, "Paired"),
                            style.name = style_name)
      setVisualStyle(style_name)
    } else {
    message("k can only be a number or 'all' if all styles are to be generated")
    stop()
    }
  }
}
