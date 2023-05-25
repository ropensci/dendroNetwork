# DendroNetwork
Package to create dendrochronological networks forgaining insight provenance or other patterns based on the statistal relations between tree ring curves. The code and the functions are based on several published papers (Visser 2021a; 2021b;Visser & Vorst (2022)).

## Basic usage

The package aims to make the creation of dendrochronological (provenance) networks as easy as possible. To be able to make use of all options, it is assumed that Cytoscape is installed (https://cytoscape.org/). Some data is included in this package, namely the Roman data from Hollstein (1980).

1. Load data: `data(hol_rom)`
2. Create similarity table: `sim_table_hol <- sim_table(hol_rom)`
3. Create network using default settings: `g_hol <- dendro_network(sim_table_hol)`
    - Or create network using user-defined settings: `g_hol_r04_sgc06 <- dendro_network(sim_table_hol, r_threshold = 0.4, sgc_threshold = 0.6)`
4. Detect communities using the Girvan-Newman (2002) algorithm: `g_hol_gn <- gn_names(g_hol)` or `g_hol_r04_sgc06_gn <- gn_names(g_hol_r04_sgc06)`
5. Detect communities using the Clique Percolation Method (Palla, et al. 2005): `g_hol_cpm <- clique_community_names(g_hol, k=3)`
    - It is also possible to list all communities for al clique-sizes present in a network. In the example data with the default settings, this would result in only one community: `hol_com_cpm_all <- find_all_cpm_com(g_hol)`. With lower thresholds several communities are present: `hol_com_r04_sgc06_cpm_all <- find_all_cpm_com(g_hol_r04_sgc06)`. 
6. Start Cytoscape on your computer.
7. The network can now be loaded in Cytoscape for further visualisation: `cyto_create_graph(g_hol, CPM_table = hol_com_cpm_all, GN_table = g_hol_gn)` or `cyto_create_graph(g_hol_r04_sgc06, CPM_table = hol_com_r04_sgc06_cpm_all, GN_table = g_hol_r04_sgc06_gn)`
8. Styles for visualisation can now be generated. However, Cytoscape comes with a lot of default styles that can be confusing. Therefore it is recommended to use: `cyto_clean_styles()` once in a session.
    - To visualize the styles for CPM with only k=3: `cyto_create_cpm_style(g_hol, k=3)`
    - To create multiple styles: `cyto_create_cpm_style(g_hol_r04_sgc06, k="all")`


# References

Girvan, M and Newman, MEJ. 2002 Community structure in social and biological networks. Proceedings of the National Academy of Sciences of the United States of America 99(12): 7821–7826. DOI: https://doi.org/10.1073/pnas.122653799.


Hollstein, E. 1980. Mitteleuropäische Eichenchronologie. Trierer Dendrochronologische Forschungen zur Archäologie und Kunstgeschichte. Trierer Grabungen und Forschungen 11. Mainz am Rhein: Verlag Philipp von Zabern.

Palla, G, Derenyi, I, Farkas, I and Vicsek, T. 2005 Uncovering the overlapping community structure of complex networks in nature and society. Nature 435(7043): 814–818. DOI: https://doi.org/10.1038/nature03607.


Visser, RM. 2021a Dendrochronological Provenance Patterns. Network Analysis of Tree-Ring Material Reveals Spatial and Economic Relations of Roman Timber in the Continental North-Western Provinces. Journal of Computer Applications in Archaeology 4(1): 230–253. DOI: https://doi.org/10.5334/jcaa.79.

Visser, RM. 2021b On the similarity of tree-ring patterns: Assessing the influence of semi-synchronous growth changes on the Gleichläufigkeitskoeffizient for big tree-ring data sets. Archaeometry 63(1): 204–215. DOI: https://doi.org/10.1111/arcm.12600.

[Visser & Vorst (2022)]: Visser, RM and Vorst, Y. 2022 Connecting Ships: Using Dendrochronological Network Analysis to Determine the Wood Provenance of Roman-Period River Barges Found in the Lower Rhine Region and Visualise Wood Use Patterns. International Journal of Wood Culture 3(1–3): 123–151. DOI: https://doi.org/10.1163/27723194-bja10014.










