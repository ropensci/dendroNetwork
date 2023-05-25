#' Cleaning nearly all styles in cytoscape session and import simple styles
#'
#' @returns Cytoscape cleaned of styles and only styles with white and grey nodes.
#' @examples
#' cyto_clean_styles()
#'
#' @export cyto_clean_styles

cyto_clean_styles <- function(){
  if (length(RCy3::cytoscapeVersionInfo())!=2){
    message("Cytoscape is not running, please start Cytoscape first")
    stop()
  }
  # delete default styles
  RCy3::deleteVisualStyle("Big Labels")
  RCy3::deleteVisualStyle("BioPAX")
  RCy3::deleteVisualStyle("BioPAX_SIF")
  RCy3::deleteVisualStyle("Curved")
  RCy3::deleteVisualStyle("default black")
  RCy3::deleteVisualStyle("Directed")
  RCy3::deleteVisualStyle("Gradient1")
  RCy3::deleteVisualStyle("Marquee")
  RCy3::deleteVisualStyle("Minimal")
  RCy3::deleteVisualStyle("Nested Network Style")
  RCy3::deleteVisualStyle("Ripple")
  RCy3::deleteVisualStyle("Sample1")
  RCy3::deleteVisualStyle("Sample2")
  RCy3::deleteVisualStyle("Sample3")
  RCy3::deleteVisualStyle("Solid")
  RCy3::deleteVisualStyle("Universe")
  RCy3::deleteVisualStyle("size_rank")
  # import style with grey nodes
  if ("GreyNodesLabel" %in% RCy3::getVisualStyleNames() == FALSE) {
    RCy3::importVisualStyles(filename = "cytoscape/NetworkStyles.xml")
  }
  message("All defauls styles are removed and some new ones are added")

}

