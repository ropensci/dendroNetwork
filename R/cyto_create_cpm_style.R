#' Create CPM style in Cytoscape
#'
#' Function to create a style in Cytoscape to visualise the communities in a network using clique percolation method (CPM: Palla et al., 2005). See also: find_all_cpm_com()
#' Each node is filled with the colour of the community. If a node is part of several communities a pie chart is used to show the various community colours.
#' The function uses a graph as input and the number of cliques (default = 3). The style can be specified or automatically named based on the name of the network an the number of cliques.
#' Before starting this function, Cytoscape must be up and running!
#'
#' @param graph_input the graph with the CPM communities
#' @param k clique size for the visualisation. This should be an integer with the value 3 or higher
#' @param com_k data_frame with the communities for the specific clique size (two columns: node and com_name). This is the result of clique_community_names_par() or clique_community_names()
#' @param style_name name of the output style in Cytoscape. If set to "auto", the style is derived from the name of the network and value for k
#' @returns The style applied in Cytoscape, no objects in R as return.
#' @examples
#' \dontrun{
#' data(hol_rom)
#' sim_table_hol <- sim_table(hol_rom)
#' g_hol <- dendro_network(sim_table_hol)
#' hol_com_cpm_k3 <- clique_community_names(g_hol, k = 3)
#' cyto_create_graph(g_hol)
#' cyto_create_cpm_style(g_hol, k = 3, com_k = hol_com_cpm_k3)
#' }
#'
#' @export cyto_create_cpm_style

cyto_create_cpm_style <- function(graph_input, k = 3, com_k = NULL, style_name = "auto") { # nocov start
  if (length(RCy3::cytoscapeVersionInfo()) != 2) {
    message("Cytoscape is not running, please start Cytoscape first")
    stop()
  }
  if ("GreyNodesLabel" %in% RCy3::getVisualStyleNames() == FALSE) {
    RCy3::importVisualStyles(filename = system.file("extdata", "NetworkStyles.xml", package = "dendroNetwork"))
  }
  if (!igraph::is_igraph(graph_input)) {
    stop(paste0("Please use an igraph object as input. The current object is an ", class(graph_input), "."))
  }
  if (is.null(com_k)) {
    stop("Please present a data frame with the communities for the given clique size")
  }
  if (is.numeric(k)) {
    if (style_name == "auto") {
      style_name <- paste0(substitute(graph_input), "_CPM(k=", k, ")")
    }
    if (style_name %in% RCy3::getVisualStyleNames()) {
      RCy3::deleteVisualStyle(style_name)
    }
    RCy3::copyVisualStyle("WhiteNodesLabel", style_name)
    # com_k <- clique_community_names(graph_input, k)
    com_count <- length(unique(com_k$com_name))
    com_k_spread <- com_k |>
      dplyr::count(node, com_name) |>
      tidyr::spread(com_name, n)
    RCy3::loadTableData(com_k_spread, data.key.column = "node")
    if (com_count == 1) {
      # RCy3::setNodeCustomPieChart does not work with a single column and therefore the nodes are coloured based on the single community
      RCy3::setNodeColorMapping(unique(com_k$com_name),
        table.column.values = 1,
        colors = RColorBrewer::brewer.pal(12, "Paired")[1],
        mapping.type = "d",
        style.name = style_name
      )
    } else {
      RCy3::setNodeCustomPieChart(unique(com_k$com_name),
        colors = RColorBrewer::brewer.pal(com_count, "Paired"),
        style.name = style_name
      )
    }
    RCy3::setVisualStyle(style_name)
  } else {
    message("k can only be a number")
    stop()
  }
} # nocov end
