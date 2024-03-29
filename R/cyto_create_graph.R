#' Create networks in Cytoscape
#'
#' Function to create a network in cytoscape (https://cytoscape.org/)
#' Cytoscape must be running before executing this function
#'
#' @param graph_input igraph network used to create network in Cytoscape
#' @param network_name name of the network in Cytoscape, defaults to the name of variable that is the network in R
#' @param collection_name name of the collection in Cytoscape (default = default)
#' @param style_name name of the style in Cytoscape (default = default)
#' @param CPM_table table with the name of the nodes in the first column and the CPM-communities in other columns. This is the result of find_all_cpm_com()
#' @param GN_table two column table with the name of the nodes in the first column and the Girvan-Newman-communities in other columns
#'
#' @returns a graph in Cytoscape
#' @examples
#' \dontrun{
#' data(hol_rom)
#' sim_table_hol <- sim_table(hol_rom)
#' g_hol <- dendro_network(sim_table_hol)
#' hol_com_cpm_all <- find_all_cpm_com(g_hol)
#' g_hol_gn <- gn_names(g_hol)
#' cyto_create_graph(g_hol, CPM_table = hol_com_cpm_all, GN_table = g_hol_gn)
#' }
#'
#' @export cyto_create_graph

cyto_create_graph <- function(graph_input,
                              network_name = substitute(graph_input),
                              collection_name = "default",
                              style_name = "default",
                              CPM_table = NULL,
                              GN_table = NULL) { # nocov start
  if (length(RCy3::cytoscapeVersionInfo()) != 2) {
    message("Cytoscape is not running, please start Cytoscape first")
    stop()
  }
  if (!igraph::is.igraph(graph_input)) {
    stop(paste0("Please use an igraph object as input. The current object is an ", class(graph_input), "."))
  }
  varnames <- all.vars(match.call())
  for (v in varnames) {
    if (!exists(v)) {
      stop(paste0("Not all input parameters exist. ", v, " is missing or incorrectlty spelled."))
    }
  }

  # due to errors on first creation tryCatch added that does remove and create network again
  tryCatch(
    {
      RCy3::createNetworkFromIgraph(graph_input, network_name, collection = collection_name, style.name = style_name)
    },
    error = function(cond) {
      RCy3::deleteNetwork()
      RCy3::createNetworkFromIgraph(graph_input, network_name, collection = collection_name, style.name = style_name)
    }
  )
  RCy3::setVisualStyle(style_name)
  if (!is.null(CPM_table)) {
    RCy3::loadTableData(CPM_table, data.key.column = "node")
  }
  if (!is.null(GN_table)) {
    RCy3::loadTableData(GN_table, data.key.column = "node")
  }
  RCy3::layoutNetwork(layout.name = "kamada-kawai")
  RCy3::setNodeLabelMapping("id", style.name = style_name)
} # nocov end
