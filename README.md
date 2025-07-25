
# dendroNetwork <img src="man/figures/dendroNetwork_hexsticker.png" align="right" height="200" style="float:right; height:200px;"/>

<!-- badges: start -->

[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
[![R-CMD-check](https://github.com/ropensci/dendroNetwork/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/ropensci/dendroNetwork/actions/workflows/R-CMD-check.yaml)
[![Status at rOpenSci Software Peer
Review](https://badges.ropensci.org/627_status.svg)](https://github.com/ropensci/software-review/issues/627)
[![dendroNetwork status
badge](https://ropensci.r-universe.dev/badges/dendroNetwork)](https://ropensci.r-universe.dev)
[![CRAN
status](https://www.r-pkg.org/badges/version/dendroNetwork)](https://CRAN.R-project.org/package=dendroNetwork)
[![Total CRAN
Downloads](https://cranlogs.r-pkg.org/badges/grand-total/dendroNetwork)](https://cranlogs.r-pkg.org/badges/grand-total/dendroNetwork)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.10636310.svg)](https://zenodo.org/doi/10.5281/zenodo.10636310)

<!-- badges: end -->

dendroNetwork is a package to create dendrochronological networks for
gaining insight into provenance or other patterns based on the
statistical relations between tree ring curves. The code and the
functions are based on several published papers (Visser 2021b, 2021a;
Visser and Vorst 2022).

The package is written for dendrochronologists and have a general
knowledge on the discipline and used jargon. There is an excellent
website for the introduction of using R in dendrochronology:
<https://opendendro.org/r/>. The basics of dendrochronology can be found
in handbooks (Cook and Kariukstis 1990; Speer 2010) or on
<https://www.dendrohub.com/>. A list of R-packages for dendrochronology
can be found here: <https://ronaldvisser.github.io/Dendro_R/>.

## Installation

This package depends on
[RCy3](https://www.bioconductor.org/packages/release/bioc/html/RCy3.html),
which is part of Bioconductor. Therefore it is recommended to install
RCy3 first using:

``` r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("RCy3")
```

The functionality of RCy3 depends on the installation of Cytoscape.
Cytoscape is needed for visualising the networks. This open source
software is platform independent and provides easy visual access to
complex networks and the attributes of both nodes and edges in a network
(see the
[Cytoscape-website](https://cytoscape.org/what_is_cytoscape.html) for
more information). It is therefore recommended to install Cytoscape as
well. Please follow the download and installation instructions for your
operating system: <https://cytoscape.org/>.

You can install the latest version of dendroNetwork from
[CRAN](https://cran.r-project.org/package=dendroNetwork) or the
development version from
[R-universe](https://ropensci.r-universe.dev/dendroNetwork) by running
one of the commands below:

``` r
# CRAN
install.packages("dendroNetwork")
# R-Universe
install.packages("dendroNetwork", repos = "https://ropensci.r-universe.dev")
```

## Usage

The package aims to make the creation of dendrochronological
(provenance) networks as easy as possible. To be able to make use of all
options, it is assumed that Cytoscape (Shannon et al. 2003)is installed
(<https://cytoscape.org/>). Some data is included in this package,
namely the Roman data published by Hollstein (Hollstein 1980).

The first steps are visualized in the flowchart below, including
community detection using either (or both) the Girvan-Newman algorithm
(Girvan and Newman 2002) and Clique Percolation Method (Palla et al.
2005) for all clique sizes. Both methods are explained very well in the
papers, and on wikipedia for both
[CPM](https://en.wikipedia.org/wiki/Clique_percolation_method) and the
[Girvan-Newman
algorithm](https://en.wikipedia.org/wiki/Girvan%E2%80%93Newman_algorithm).

    #> file:///C:/Users/rvi04/AppData/Local/Temp/RtmpEhBr4Z/file359418f77d07/widget35947d3c6d5f.html screenshot completed

![](man/figures/README-flowchart_workflow-1.png)<!-- -->

``` r
library(dendroNetwork)
data(hol_rom) # 1
sim_table_hol <- sim_table(hol_rom) # 2
g_hol <- dendro_network(sim_table_hol) # 3
g_hol_gn <- gn_names(g_hol) # 4
g_hol_cpm <- clique_community_names(g_hol, k=3) # 4
hol_com_cpm_all <- find_all_cpm_com(g_hol) # 5
plot(g_hol)  # plotting the graph in R
```

![](man/figures/README-network_hollstein_1980-1.png)<!-- -->

``` r
plot(g_hol, vertex.color="deepskyblue", vertex.size=15, vertex.frame.color="gray",
     vertex.label.color="darkslategrey", vertex.label.cex=0.8, vertex.label.dist=2) # better readable version
```

![](man/figures/README-network_hollstein_1980-2.png)<!-- -->

### Visualization in Cytoscape

After creating the network in R, it is possible to visualize the network
using Cytoscape. The main advantage is that visualisation in Cytoscape
is more easy, intuitive and visual. In addition, it is very easy to
automate workflows in Cytoscape with R (using
[RCy3](https://bioconductor.org/packages/release/bioc/html/RCy3.html)).
For this purpose we need to start Cytoscape firstly. After Cytoscape has
completely loaded, the next steps can be taken.

1.  The network can now be loaded in Cytoscape for further
    visualisation:
    `cyto_create_graph(g_hol, CPM_table = hol_com_cpm_all, GN_table = g_hol_gn)`
2.  Styles for visualisation can now be generated. However, Cytoscape
    comes with a lot of default styles that can be confusing. Therefore
    it is recommended to use: `cyto_clean_styles()` once in a session.
3.  To visualize the styles for CPM with only k=3:
    `cyto_create_cpm_style(g_hol, k=3, com_k = g_hol_cpm)`
    - This can be repeated for all possible clique sizes. To find the
      maximum clique size in a network, please use:
      `igraph::clique_num(g_hol)`.
    - To automate this:
      `for (i in 3:igraph::clique_num(g_hol)) { cyto_create_cpm_style(g_hol, k=i, com_k = g_hol_cpm)}`.
4.  To visualize the styles using the Girvan-Newman algorithm (GN):
    `cyto_create_gn_style(g_hol)` This would look something like this in
    Cytoscape:

<figure>
<img src="man/figures/g_hol_GN.png"
alt="The network of Roman sitechronologies with the Girvan-Newman communities visualized." />
<figcaption aria-hidden="true">The network of Roman sitechronologies
with the Girvan-Newman communities visualized.</figcaption>
</figure>

## Usage for large datasets

When using larger datasets of tree-ring series, calculating the table
with similarities can take a lot of time, but finding communities even
more. It is therefore recommended to use of parallel computing for
Clique Percolation:
`clique_community_names_par(network, k=3, n_core = 4)`. This reduces the
amount of time significantly. For most datasets
`clique_community_names()` is sufficiently fast and for smaller datasets
`clique_community_names_par()` can even be slower due to the
parallelisation. Therefore, the function `clique_community_names()`
should be used initially and if this is very slow, start using
`clique_community_names_par()`. See the separate
[vignette](https://docs.ropensci.org/dendroNetwork/articles/large_datasets_communities.html)
for that.

## Citation

If you use this software, please cite this using:

Visser, R.M. (2025). dendroNetwork: a R-package to create
dendrochronological provenance networks (Version 0.5.5) \[Computer
software\]. <https://zenodo.org/doi/10.5281/zenodo.10636310>

## Acknowledgements

This package reuses and adapts the CliquePercolationMethod-R package
developed by Angelo Salatino (The Open University). Source code:
<https://github.com/angelosalatino/CliquePercolationMethod-R>

This package reuses and adapts the function cor.with.limit.R() developed
by Andy Bunn (Western Washington University), but the new function is
optimized and also outputs the number of overlapping rings. Source code:
<https://github.com/AndyBunn/dplR/blob/master/R/rwi.stats.running.R>.

## References

<div id="refs" class="references csl-bib-body hanging-indent"
line-spacing="2">

<div id="ref-cook1990" class="csl-entry">

Cook, ER and Kariukstis, LA. 1990. *Methods of dendrochronology.
Applications in the environmental sciences*. Dordrecht: Kluwer Academic
Publishers.

</div>

<div id="ref-girvan2002" class="csl-entry">

Girvan, M and Newman, MEJ. 2002 Community structure in social and
biological networks. *Proceedings of the National Academy of Sciences of
the United States of America* 99(12): 7821–7826. DOI:
https://doi.org/[10.1073/pnas.122653799](https://doi.org/10.1073/pnas.122653799).

</div>

<div id="ref-hollstein1980" class="csl-entry">

Hollstein, E. 1980. *Mitteleuropäische eichenchronologie. Trierer
dendrochronologische forschungen zur archäologie und kunstgeschichte.*
Trierer grabungen und forschungen 11. Mainz am Rhein: Verlag Philipp von
Zabern.

</div>

<div id="ref-palla2005" class="csl-entry">

Palla, G, Derenyi, I, Farkas, I and Vicsek, T. 2005 Uncovering the
overlapping community structure of complex networks in nature and
society. *Nature* 435(7043): 814–818. DOI:
https://doi.org/[10.1038/nature03607](https://doi.org/10.1038/nature03607).

</div>

<div id="ref-shannon2003" class="csl-entry">

Shannon, P, Markiel, A, Ozier, O, Baliga, NS, Wang, JT, Ramage, D, Amin,
N, Schwikowski, B and Ideker, T. 2003 Cytoscape: A software environment
for integrated models of biomolecular interaction networks. *Genome
Research* 13(11): 2498–2504. DOI:
https://doi.org/[10.1101/gr.1239303](https://doi.org/10.1101/gr.1239303).

</div>

<div id="ref-speer2010" class="csl-entry">

Speer, JH. 2010. *Fundamentals of tree ring research*. Tucson:
University of Arizona Press.

</div>

<div id="ref-visser2021b" class="csl-entry">

Visser, RM. 2021a Dendrochronological Provenance Patterns. Network
Analysis of Tree-Ring Material Reveals Spatial and Economic Relations of
Roman Timber in the Continental North-Western Provinces. *Journal of
Computer Applications in Archaeology* 4(1): 230253. DOI:
https://doi.org/[10.5334/jcaa.79](https://doi.org/10.5334/jcaa.79).

</div>

<div id="ref-visser2021a" class="csl-entry">

Visser, RM. 2021b On the similarity of tree-ring patterns: Assessing the
influence of semi-synchronous growth changes on the
Gleichläufigkeitskoeffizient for big tree-ring data sets. *Archaeometry*
63(1): 204–215. DOI:
https://doi.org/[10.1111/arcm.12600](https://doi.org/10.1111/arcm.12600).

</div>

<div id="ref-visser2022" class="csl-entry">

Visser, RM and Vorst, Y. 2022 Connecting Ships: Using
Dendrochronological Network Analysis to Determine the Wood Provenance of
Roman-Period River Barges Found in the Lower Rhine Region and Visualise
Wood Use Patterns. *International Journal of Wood Culture* 3(1-3):
123–151. DOI:
https://doi.org/[10.1163/27723194-bja10014](https://doi.org/10.1163/27723194-bja10014).

</div>

</div>
