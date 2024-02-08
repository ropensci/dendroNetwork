# `dendro_network(sim_table(hol_rom))` results in the expected similarity table

    Code
      igraph::as_graphnel(dendro_network(sim_table(hol_rom)))
    Condition
      Warning:
      `graph.data.frame()` was deprecated in igraph 2.0.0.
      i Please use `graph_from_data_frame()` instead.
    Output
      A graphNEL graph with undirected edges
      Number of Nodes = 13 
      Number of Edges = 10 

