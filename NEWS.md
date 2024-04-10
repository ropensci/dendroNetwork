# dendroNetwork: news {#dendroNetwork}

## dendroNetwork 0.5.4 (development)

### New features

### Minor improvements

### Bug Fixes

### Deprecated and defunct

### Documentation fixes

### Continous integration

## dendroNetwork 0.5.3 (05-04-2024)

### New features

### Minor improvements

### Bug Fixes

### Deprecated and defunct

### Documentation fixes

-   added descriptions of Cytoscape in the readme and vignettes
-   added vignette: dendrochronological_data which describes the data to be used.
-   minor corrections

### Continous integration

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
-   moved information for using big datasett to seperate vignette
-   updated README: added more installion instructions
-   corrected examples in `cyto_create_gn_style` and `cyto_create_cpm_style`

### Continous integration

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

### Continous integration

-   added GitHub Action for BiocMananager (<https://lcolladotor.github.io/biocthis/index.html>)
-   added more tests
-   excluded Cytoscape-functions from testing

## dendroNetwork 0.5.0 (08-02-2024)

### New features

-   First public release \### Minor improvements \### Bug Fixes \### Deprecated and defunct \### Documentation fixes \### Continous integration