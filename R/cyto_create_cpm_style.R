#' Create CPM style in Cytoscape
#'
#' Function to
#'
#' @param
#' @returns
#' @examples
#'
#'

cyto_create_cpm_style <- function(graph_input, k=3, style_name = "auto") {
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
