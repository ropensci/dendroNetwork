# dendroNetwork: news {#dendroNetwork}

## dendroNetwork 0.5.5

### New features

### Minor improvements

-   dendronetwork: it is now possible to choose which correlation to use for creating network(s): using the correlation after the Hollstein(1980) transformation r_hol or the correlation without any transformation (r). The default is now r_hol.

### Bug Fixes

### Deprecated and defunct

-   moved folder with paper to separate repository: <https://github.com/RonaldVisser/dendroNetwork_paper>

### Documentation fixes

-   improved the documentation of the CPM en GN functions

-   corrected minor typos in the documentation.

### Continuous integration

# dendroNetwork: news

## dendroNetwork 0.5.4

### New features

-   replaced magrittr-pipe %\>% by native R pipe \|\>

    -   dependency of magrittr was removed

    -   dependency on R-version changed to \>= 4.1.0

-   transferred to ROpenSci: <https://github.com/ropensci/dendroNetwork>

### Minor improvements

-   Tested with latest version of Cytoscape: 3.10.2 (<https://cytoscape.org/download.html>) and all works fine

### Bug Fixes

-   added global variables to prevent notes

-   added various files to build ignore

### Deprecated and defunct

### Documentation fixes

-   updated all links to <https://github.com/ropensci/dendroNetwork> or <https://docs.ropensci.org/dendroNetwork/>
-   updated installation instruction
-   minor language corrections
-   description corrections
-   corrected links
-   updated DESCRIPTION file for CRAN
-   `donttest{}` was added to RING_Visser_2021.R because testing takes to long for CRAN.

### Continuous integration

-   removed pkgdown deployment, and now relying on ROpenSci: <https://devguide.ropensci.org/pkg_ci.html>

## dendroNetwork 0.5.3 (05-04-2024)

### New features

### Minor improvements

### Bug Fixes

### Deprecated and defunct

### Documentation fixes

-   added descriptions of Cytoscape in the readme and vignettes
-   added vignette: dendrochronological_data which describes the data to be used.
-   minor corrections

### Continuous integration

## dendroNetwork 0.5.2 (29-03-2024)

### New features

### Minor improvements

-   added a CONTRIBUTING.md file for contribution guidelines
-   added check to determine if input graph is an igraph object for all functions that need an igraph as input
-   added check to determine if input tree-ring dataset is rwl object for `sim_table`

### Bug Fixes

-   corrected bug in `cyto_clean_styles()`
-   corrected error in `wuchwerte()`. It is not using the `anos1` dataset from dplR anymore
-   corrected error in `cyto_create_gn_style` and `cyto_create_cpm_style`
-   updated `cyto_create_cpm_style` because it was not working properly.

### Deprecated and defunct

-   dev-folder removed, since this was not needed (created by `biocthis`)

### Documentation fixes

-   update acknowledgements in readme and paper
-   corrected text of documentation in cor_mat_overlap()
-   added pkgdown site: <https://ronaldvisser.github.io/dendroNetwork/>
-   moved some images to man/figures
-   added Vignette on Cytoscape use
-   moved information for using big dataset to separate vignette
-   updated README: added more installation instructions
-   corrected examples in `cyto_create_gn_style` and `cyto_create_cpm_style`

### Continuous integration

## dendroNetwork 0.5.1 (10-02-2024)

### New features

### Minor improvements

-   replaced igraph::graph.data.frame() with igraph::graph_from_data_frame(), since the former is deprecated in igraph 2.0.0
-   replaced `igraph::is.simple` with `igraph::is_simple`
-   replaced `igraph::decompose.graph` with `igraph::decompose`
-   correction to calls to functions `grDevices::colorRampPalette` and `stats::pnorm`

### Bug Fixes

### Deprecated and defunct

### Documentation fixes

-   minor corrections to README
-   added codemeta.json using codemetar::write_codemeta()
-   added .github/CONTRIBUTING.md using usethis::use_tidy_contributing()
-   DESCRIPTION: added URL and BugReports to DESCRIPTION + package checks
-   correction in clique_community_names(\_par) functions, due to [k] seen as link
-   added \dontrun{} to cytoscape functions

### Continuous integration

-   added GitHub Action for BiocMananager (<https://lcolladotor.github.io/biocthis/index.html>)
-   added more tests
-   excluded Cytoscape-functions from testing

## dendroNetwork 0.5.0 (08-02-2024)

### New features

First public release

### Minor improvements

### Bug Fixes

### Deprecated and defunct

### Documentation fixes

### Continuous integration
