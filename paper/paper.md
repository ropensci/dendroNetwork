---
title: 'dendroNetwork: a R-package to create networks of dendrochronological data'
tags:
  - R
  - dendrochronology
  - network analysis
  - cytoscape
  - tree ring
  - archaeology
authors:
  - name: Ronald M. Visser 
    orcidlink: 0000-0001-6966-1729
    affiliation: 1
affiliations:
  - name: Saxion University of Applied Sciences, Deventer
    index: 1
citation_author: Visser
date: "26 April 2024"
year: 2024
bibliography: paper.bib
output: rticles::joss_article
csl: apa.csl
journal: JOSS
---

# Summary

The R-package dendroNetwork aims to make network analyses of dendrochronological data accessible for researchers. dendroNetwork enables researchers to easily construct a network of dendrochronological series based on the statistical similarity and subsequently analyse patterns of matching tree-ring material. The detection of patterns is assisted by the easy application of community detection and subsequent (automated) visualization using Cytoscape. This enables dendrochronologists and other researchers to apply networks analyses to understand patterns of similarity between tree-ring series, for example to determine the provenance of archaeological wood.

# Introduction

Dendrochronological analyses are often based on the comparison of tree-ring series with other tree-ring series. These comparisons are often visualised as tabular data. However, to analyse the complex system of relations between tree-ring curves other methods are necessary. The author has developed a method to analyse patterns of similarity between tree-ring series using network analysis [@visser2021; @visser2022]. The analyses of these papers was mostly based on scripts that are shared with the papers [@visservorst, @visser]. For others to apply the developed method with these scripts is possible, but cumbersome and various things need to be changed. In addition, to try the network approach on dendrochronological data for the first time can be overwhelming an seemingly difficult. To make this more easy and accessible a new package for R has been designed to help users to apply this method to their data. The package dendroNetwork enables researchers to create tables with the similarity using various measures and visualize these using R [@rcoreteam2022] and Cytoscape [@otasek2019; @shannon2003a]. Cytoscape is an open source and platform independent tool for network analysis and visualization. The software provides easy visual access to complex networks and the attributes of both nodes and edges in a network. The dendroNetwork package has been reviewed on ROpenSci (<https://github.com/ropensci/dendroNetwork> and <https://docs.ropensci.org/dendroNetwork/>).

# Statement of need

There are several packages available in R for dendrochronological research [@guiterman2020; @jevsenak2018; @campelo2012; @bunn2008; @shi2019; @vandermaaten-theunissen2015; @reynolds2021; @altman2014; @malevich2018; @rademacher; @campelo2019; @haneca2023; @alday2018]. An overview with links to these packages can be found online (<https://ronaldvisser.github.io/Dendro_R/>). Some packages are specifically creates to obtain measurements [@campelo2019; @shi2019], while others are written for crossdating [@reynolds2021]. There are also various for analysing tree-ring data [@alday2018; @alday2018; @altman2014; @bunn2008; @campelo2012; @zang2015; @guiterman2020]. These R-packages in dendrochronology all fill different needs, but the nice thing is that these are all interconnected in some way in depending on each other, or that they build further into different avenues. Apart from depending on dendrochronological packages, various packages from the Tidyverse [@wickham2019] are often also needed. The various relations can easily be visualised using a network, with the edges based on the dependency of two packages on each other, and and arrow indicating the direction of the dependency. Some R-package for dendrochronology or tree-ring studies have no relation with others, but fill specific needs [@peters2018; @lara2018; @campelo2016; @aryal2020]. These are left out of the network (see Figure \@ref(fig:packages-network)).

\begin{figure}
\includegraphics[width=0.5\linewidth]{paper_files/figure-latex/packages-network-1} \caption{The interdependent relations between existing R-packages related to dendrochronology}\label{fig:packages-network}
\end{figure}

The network shows that nearly all packages depend on dplR [@bunn2008]. The newly created package dendroNetwork fits in this ecosystem of depending packages, since it depends on both dplR and the Tidyverse. In addition, it adds a whole new world by adding network analyses through igraph [@csardi2006] to the ecosystem of dendrochronological packages. The igraph library has close connections to the tidyverse, creating a full circle and filling a gap as shown in the networks below (see Figure \@ref(fig:dendroNetwork-packages)).

\begin{figure}
\includegraphics[width=0.5\linewidth]{paper_files/figure-latex/dendroNetwork-packages-1} \includegraphics[width=0.5\linewidth]{paper_files/figure-latex/dendroNetwork-packages-2} \caption{The interdependent relations between R-packages including dendroNetwork. On the left only the dependencies for dendroNetwork, on the right all dendrochronological R-packages, including dendroNetwork}\label{fig:dendroNetwork-packages}
\end{figure}

# Workflow using dendroNetwork

The typical workflow when using the package consists of a number of successive steps (see Figure \@ref(fig:workflow)). The result of each step is input for the next step.

![The typcial workflow when using dendroNetwork to visualise a network](paper_files/figure-latex/workflow-1.pdf) 

This first step is to load the package and subsequently the dendrochronological data into the R environment using dplR:


```r
library(dendroNetwork)
data(hol_rom)
```

The next step would involve calculating the similarities between each tree-ring series in the dataset.


```r
sim_table_hol <- sim_table(hol_rom)
```

In the next step edges of the network are created based on the similarity. Each similarity between two curves above certain threshold settings will result in an edge in the network. The default settings are 0.5 for the correlation, 0.7 for the Synchronous Growth Changes or sgc [@visser2021a] with a probability of exceedence below 0.0001.


```r
g_hol <- dendro_network(sim_table_hol)
```

The next steps will be to find communities using either the Girvan-Newman algorithm [@girvan2002] or clique percolation method [@palla2005] , or both.


```r
g_hol_gn <- gn_names(g_hol)
g_hol_cpm <- clique_community_names(g_hol, k=3)
hol_com_cpm_all <- find_all_cpm_com(g_hol)
```

The next step is to visualize and explore the networks using Cytoscape or using R (see Figure \@ref(fig:network-holrom)). Various functions are available to create visual styles for the communities in Cytoscape from R.

![Network of the dendrochronological site chronologies in hol_rom](paper_files/figure-latex/network-holrom-1.pdf) 

The main advantage is that visualisation in Cytoscape is more easy, intuitive and visual. In addition, it is very easy to automate workflows in Cytoscape with R (using [RCy3](https://bioconductor.org/packages/release/bioc/html/RCy3.html)). For this purpose we need to start Cytoscape firstly. After Cytoscape has completely loaded, the next steps can be taken.

1.  The network can now be loaded in Cytoscape for further visualisation: `cyto_create_graph(g_hol, CPM_table = hol_com_cpm_all, GN_table = g_hol_gn)`
2.  Styles for visualisation can now be generated. However, Cytoscape comes with a lot of default styles that can be confusing. Therefore it is recommended to use: `cyto_clean_styles()` once in a session.
3.  To visualize the styles for CPM with only k=3: `cyto_create_cpm_style(g_hol, k=3, com_k = g_hol_cpm)`
    -   This can be repeated for all possible clique sizes. To find the maximum clique size in a network, please use: `igraph::clique_num(g_hol)`.
    -   To automate this: `for (i in 3:igraph::clique_num(g_hol)) { cyto_create_cpm_style(g_hol, k=i, com_k = g_hol_cpm)}`.
4.  To visualize the styles using the Girvan-Newman algorithm (GN): This would look something like this in Cytoscape (see Figure \@ref(fig:cytoscape-network)).

\begin{figure}
\includegraphics[width=0.75\linewidth]{g_hol_GN} \caption{The network of Roman sitechronologies with the Girvan-Newman communities visualized using Cytoscape.}\label{fig:cytoscape-network}
\end{figure}

# Conclusion

The new R package dendroNetwork has been developed based on earlier research by the author. To enable other researchers to use network analyses on dendrochronological data this new package fills a gap that exists in the current network of R-packages related to dendrochronology by also connecting igraph to the existing packages in the discipline. The creation of networks in R is made easy with various functions and the visualization in Cytoscape is automated in R, enabling the researcher to quickly visualise and analyse the resulting networks in an intuitive manner. The package is easy to use and enables reproducible network analyses within dendrochronology.

# Acknowledgements

This package was mostly created in my spare time and I'd like to thank my family for bearing with me. I want to thank Angelino Salentino for creating the orginal function for clique_community_names() and lique_community_names_par(), which I adapted for use in this package (source: <https://github.com/angelosalatino/CliquePercolationMethod-R>. I want to thank Andy Bunn for the function cor.with.limit.R() which I adapted for use in this package as cor_mat_overlap() (source: <https://github.com/AndyBunn/dplR/blob/master/R/rwi.stats.running.R>). The software and documentation were improved after peer-review at ROpenSci, thanks to reviewers Kaija Gahm and Zachary Gajewski.

# References
