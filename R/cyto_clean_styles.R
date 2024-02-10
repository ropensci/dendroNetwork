#' Cleaning nearly all styles in cytoscape session and import simple styles
#'
#' @returns Cytoscape cleaned of styles and only styles with white and grey nodes.
#' @examples
#' \dontrun{
#' cyto_clean_styles()
#' }
#'
#' @export cyto_clean_styles
#'
#' @importFrom magrittr %>%

cyto_clean_styles <- function() {
  if (length(RCy3::cytoscapeVersionInfo()) != 2) {
    message("Cytoscape is not running, please start Cytoscape first")
    stop()
  }
  # delete default styles
  if ("Big Labels" %in% RCy3::getVisualStyleNames()) {
    RCy3::deleteVisualStyle("Big Labels")
  }
  if ("BioPAX" %in% RCy3::getVisualStyleNames()) {
    RCy3::deleteVisualStyle("BioPAX")
  }
  if ("BioPAX_SIF" %in% RCy3::getVisualStyleNames()) {
    RCy3::deleteVisualStyle("BioPAX_SIF")
  }
  if ("Curved" %in% RCy3::getVisualStyleNames()) {
    RCy3::deleteVisualStyle("Curved")
  }
  if ("default black" %in% RCy3::getVisualStyleNames()) {
    RCy3::deleteVisualStyle("default black")
  }
  if ("Directed" %in% RCy3::getVisualStyleNames()) {
    RCy3::deleteVisualStyle("Directed")
  }
  if ("Gradient1" %in% RCy3::getVisualStyleNames()) {
    RCy3::deleteVisualStyle("Gradient1")
  }
  if ("Marquee" %in% RCy3::getVisualStyleNames()) {
    RCy3::deleteVisualStyle("Marquee")
  }
  if ("Minimal" %in% RCy3::getVisualStyleNames()) {
    RCy3::deleteVisualStyle("Minimal")
  }
  if ("Nested Network Style" %in% RCy3::getVisualStyleNames()) {
    RCy3::deleteVisualStyle("Nested Network Style")
  }
  if ("Ripple" %in% RCy3::getVisualStyleNames()) {
    RCy3::deleteVisualStyle("Ripple")
  }
  if ("Sample1" %in% RCy3::getVisualStyleNames()) {
    RCy3::deleteVisualStyle("Sample1")
  }
  if ("Sample2" %in% RCy3::getVisualStyleNames()) {
    RCy3::deleteVisualStyle("Sample2")
  }
  if ("Sample3" %in% RCy3::getVisualStyleNames()) {
    RCy3::deleteVisualStyle("Sample3")
  }
  if ("Solid" %in% RCy3::getVisualStyleNames()) {
    RCy3::deleteVisualStyle("Solid")
  }
  if ("Universe" %in% RCy3::getVisualStyleNames()) {
    RCy3::deleteVisualStyle("Universe")
  }
  if ("size_rank" %in% RCy3::getVisualStyleNames()) {
    RCy3::deleteVisualStyle("size_rank")
  }

  # import style with grey nodes
  if ("GreyNodesLabel" %in% RCy3::getVisualStyleNames() == FALSE) {
    RCy3::importVisualStyles(filename = system.file("extdata", "NetworkStyles.xml", package = "DendroNetwork"))
  }
  message("All default styles are removed and some new ones are added")
}
