# DendroNetwork
Package to create dendrochronological networks forgaining insight provenance or other patterns based on the statistal relations between tree ring curves. The code and the functions are based on several published papers (Visser 2021a; 2021b;Visser & Vorst (2022)).

## Basic usage

The package aims to make the creation of dendrochronological (provenance) networks as easy as possible. To be able to make use of all options, it is assumed that Cytoscape is installed (https://cytoscape.org/). Some data is included in this package, namely the Roman data from Hollstein (1980).

1. Load data: `data(hol_rom)`
2. Create similarity table: 'sim_table_hol <- sim_table(hol_rom)' 


#' data(hol_rom)
#' sim_table_hol <- sim_table(hol_rom)
#' dendro_network(sim_table_hol)
#' dendro_network(sim_table_hol, r_threshold = 0.4, sgc_threshold = 0.6)



# References

Hollstein, E. 1980. Mitteleuropäische Eichenchronologie. Trierer Dendrochronologische Forschungen zur Archäologie und Kunstgeschichte. Trierer Grabungen und Forschungen 11. Mainz am Rhein: Verlag Philipp von Zabern.

Visser, RM. 2021a Dendrochronological Provenance Patterns. Network Analysis of Tree-Ring Material Reveals Spatial and Economic Relations of Roman Timber in the Continental North-Western Provinces. Journal of Computer Applications in Archaeology 4(1): 230–253. DOI: https://doi.org/10.5334/jcaa.79.

Visser, RM. 2021b On the similarity of tree-ring patterns: Assessing the influence of semi-synchronous growth changes on the Gleichläufigkeitskoeffizient for big tree-ring data sets. Archaeometry 63(1): 204–215. DOI: https://doi.org/10.1111/arcm.12600.

[Visser & Vorst (2022)]: Visser, RM and Vorst, Y. 2022 Connecting Ships: Using Dendrochronological Network Analysis to Determine the Wood Provenance of Roman-Period River Barges Found in the Lower Rhine Region and Visualise Wood Use Patterns. International Journal of Wood Culture 3(1–3): 123–151. DOI: https://doi.org/10.1163/27723194-bja10014.










