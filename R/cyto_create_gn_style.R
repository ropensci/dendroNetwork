#' Create Girvan-Newman communities style in Cytoscape
#'
#' Function to create a style in Cytoscape to visualise the communities in a network using the Girvan-Newman method for community detection.
#' Each node is filled with a separate colour for each community.
#' Before starting this function, Cytoscape must be up and running!
#'
#' @param graph_input the graph with the CPM communities
#' @param gn_coms GN communities in graph_input. This is the result of gn_names(). If this is not given this will be calculated in the function
#' @param style_name name of the output style in Cytoscape. If set to "auto", the style is derived from the name of the network and value for k
#' @returns The style applied in Cytoscape, no objects in R as return.
#' @examples
#' \dontrun{
#' data(hol_rom)
#' sim_table_hol <- sim_table(hol_rom)
#' g_hol <- dendro_network(sim_table_hol)
#' g_hol_gn <- gn_names(g_hol)
#' cyto_create_graph(g_hol)
#' cyto_create_gn_style(g_hol, gn_coms = g_hol_gn)
#' }
#'
#' @export cyto_create_gn_style

cyto_create_gn_style <- function(graph_input, gn_coms = NULL, style_name = "auto") { # nocov start
  if (length(RCy3::cytoscapeVersionInfo()) != 2) {
    message("Cytoscape is not running, please start Cytoscape first")
    stop()
  }
  if ("GreyNodesLabel" %in% RCy3::getVisualStyleNames() == FALSE) {
    RCy3::importVisualStyles(filename = system.file("extdata", "NetworkStyles.xml", package = "dendroNetwork"))
  }
  if (style_name == "auto") {
    style_name <- paste0(substitute(graph_input), "_GN")
  }
  RCy3::copyVisualStyle("WhiteNodesLabel", style_name)
  if (is.null(gn_coms)) {
    gn_coms <- gn_names(graph_input)
  }
  com_count <- length(unique(gn_coms$com_name))
  getPalette <- grDevices::colorRampPalette(RColorBrewer::brewer.pal(12, "Paired"))
  RCy3::setNodeColorMapping(
    table.column = "com_name",
    table.column.values = unique(gn_coms$com_name),
    colors = getPalette(com_count),
    mapping.type = "d",
    style.name = style_name
  )
  RCy3::setVisualStyle(style_name)
} # nocov end
