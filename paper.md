---
title: "DendroNetwork: a R-package to create dendrochronological provenance networks"
authors: 
  - Name: Ronald Visser
  - orcid: 0000-0001-6966-1729
  - affiliation: 1
affiliations:
   - name: Saxion University of Applied Sciences
   - index: 1
date: "2023-12-08"
bibliography: paper.bib
output: 
  html_document:
      keep_md: yes
  pdf_document: default
tags:
- dendrochronology
- network analysis
- R
- cytoscape
- tree ring
---

# Summary

(Begin your paper with a summary of the high-level functionality of your software for a non-specialist reader. Avoid jargon in this section) check: <https://joss.readthedocs.io/en/latest/submitting.html>

# Introduction

Dendrochronological analyses are often based on the comparison of tree-ring series with other tree-ring series. These comparions are often visualised as tabular data. However, to analyse the complex system of relations between tree-ring curves other methods are necessary. The author has developed a method to analyse patterns of similarity between tree-ring series using network analysis [@visser2021; @visser2022]. The analyses of these papers was mostly based on scripts that are shared with the papers [@visser; @visser]. For others to apply the developed method with these scripts is possible, but cumbersome and various things need to be changed. In addition, to try the network approach on dendrochronological data for the first time can be overwhelming an seemingly difficult. To make this more easy and accessible a new package for R has been designed to help users to apply this method to their data. The package DendroNetwork enables researchers to create tables with the similarity using various measures and visualize these using R [@rcoreteam2022] and Cytoscape [@otasek2019; @shannon2003a].

# Statement of need

There are several packages available in R for dendrochronological research [@guiterman2020; @jevsenak2018; @campelo2012; @bunn2008; @shi2019; @vandermaaten-theunissen2015; @reynolds2021; @altman2014; @rademacher; @campelo2019]. An overview with links can be found online (<https://github.com/RonaldVisser/Dendro_R>). All these packages all fill different needs, but the nice thing is that these are all interconnected in some way in depending on each other, or that they build further into different avenues. Apart from depending on dendrochronological packages, various packages from the Tidyverse [@wickham2019] are often also needed. The various relations can easily be visualised using a network, with the edges based on the dependency of two packages on each other, and and arrow indicating the direction of the dependency.

![](paper_files/figure-html/creating a network of depending packages in R-1.png)<!-- -->

The network shows that nearly all packages depend on dplR [@bunn2008]. The newly created package DendroNetwork fits in this ecosystem of depending packages, since it depends on both dplR and the Tidyverse. In additions, it adds a whole new world by adding network analyses through igraph [@csardi2006] to the ecosystem of dendrochronological packages. The igraph library has close connections to the tidyverse, creating a full circle and filling a hole as shown in the networks below.

<img src="paper_files/figure-html/creating a network of the dependencies the DendroNetwork packages-1.png" width="50%" /><img src="paper_files/figure-html/creating a network of the dependencies the DendroNetwork packages-2.png" width="50%" />

<div style= "float:right;position: relative; right: ; top: -80px;">

```{=html}
<div class="grViz html-widget html-fill-item-overflow-hidden html-fill-item" id="htmlwidget-9185bc0bcf9ff6c0e69f" style="width:384px;height:480px;"></div>
<script type="application/json" data-for="htmlwidget-9185bc0bcf9ff6c0e69f">{"x":{"diagram":"\ndigraph {\n  # graph attributes\n  graph [overlap = true]\n  # node attributes\n  node [shape = box,\n        fontname = Helvetica,\n        color = gray]\n  # edge attributes\n  edge [color = black]\n  # node statements\n  1 [label = \"Load data\"]\n  2 [label = \"Create similarity table\"]\n  3 [label = \"Create network using default settings\"]\n  4 [label = \"Detect communities using the \n Girvan-Newman algorithm\"]\n  5 [label = \"Detect communities using the \n Clique Percolation Method\"]\n  6 [label = \"Visualization in Cytoscape\"]\n  # edge statements\n  1 ->  2\n  2 -> 3\n  3 -> 4\n  3 -> 5\n  4 -> 6\n  5 -> 6\n  }\n","config":{"engine":"dot","options":null}},"evals":[],"jsHooks":[]}</script>
```
</div>

The typical workflow when using the package would be to start with loading the dendrochronological data into R using dplR. The next step would involve calculating the similarities between each tree-ring series in the dataset. In the next step edges of the network are created based on the similarity. Each similarity between two curves above certain threshold settings will result in an edge in the network. The default settings are 0.5 for the correlation, 0.7 for the Synchronous Growth Changes or sgc [@visser2021a] with a probability of exceedence below 0.0001. The next steps will be to find communities using either the Girvan-Newman algorithm [@girvan2002] or clique percolation method [@palla2005] , or both. The next step is to visualize and explore the networks using Cytoscape. Various functions are available to create visual styles for the communities in Cytoscape from R.



# Acknowledgements

# References