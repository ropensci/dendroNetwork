#' Create networks in Cytoscape
#'
#' Function to create a network in cytoscape
#'
#' @param graph_input igraph network used to create network in Cytoscape
#' @param network_name name of the network in Cytoscape, defaults to the name of variable that is the network in R
#' @param collection_name name of the collection in Cytoscape (default = default)
#' @param style_name name of the style in Cytoscape (default = default)
#' @param CPM_table table with the name of the nodes in the first column and the CPM-communities in other columns
#' @param GN_table two column table with the name of the nodes in the first column and the Girvan-Newman-communities in other columns
#'
#' @returns
#' @examples
#'
#'

cyto_create_graph <- function(graph_input,
                              network_name = substitute(graph_input),
                              collection_name = "default",
                              style_name="default",
                              CPM_table = NULL,
                              GN_table = NULL) {
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
