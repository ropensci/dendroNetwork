#' Create networks in Cytoscape
#'
#' Function to create a network in cytoscape (https://cytoscape.org/)
#' Cytoscape must be running before executing this function
#'
#' @param graph_input igraph network used to create network in Cytoscape
#' @param network_name name of the network in Cytoscape, defaults to the name of variable that is the network in R
#' @param collection_name name of the collection in Cytoscape (default = default)
#' @param style_name name of the style in Cytoscape (default = default)
#' @param CPM_table table with the name of the nodes in the first column and the CPM-communities in other columns
#' @param GN_table two column table with the name of the nodes in the first column and the Girvan-Newman-communities in other columns
#'
#' @returns a graph in Cytoscape
#' @examples
#' data(hol_rom)
#' sim_table_hol <- sim_table(hol_rom)
#' g_hol <- dendro_network(sim_table_hol)
#' hol_com_cpm_all <- find_all_cpm_com(g_hol)
#' g_hol_gn <- gn_names(g_hol)
#' cyto_create_graph(g_hol, CPM_table = hol_com_cpm_all, GN_table = g_hol_gn)
#'
#' @export cyto_create_graph

cyto_create_graph <- function(graph_input,
                              network_name = substitute(graph_input),
                              collection_name = "default",
                              style_name="default",
                              CPM_table = NULL,
                              GN_table = NULL) {
  if (length(cytoscapeVersionInfo())!=2){
    message("Cytoscape is not running, please start Cytoscape first")
    stop()
  }
  # due to errors on first creation tryCatch added that does remove and create network again
  tryCatch({createNetworkFromIgraph(graph_input, network_name, collection = collection_name, style.name=style_name)},
           error=function(cond){
             deleteNetwork()
             createNetworkFromIgraph(graph_input, network_name, collection = collection_name, style.name=style_name)
           })
  setVisualStyle(style_name)
  if (!is.null(CPM_table)){
    loadTableData(CPM_table,data.key.column="node")
  }
  if (!is.null(GN_table)){
    loadTableData(GN_table,data.key.column="node")
  }
  layoutNetwork(layout.name="kamada-kawai")
  setNodeLabelMapping("id", style.name=style_name)
}
