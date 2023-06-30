test_that("`dendro_network(sim_table(hol_rom))` results in the expected similarity table", {
  local_edition(3)
  # test graph edges and nodes
  expect_snapshot(igraph::as_graphnel(dendro_network(sim_table(hol_rom))))
  # test data class
  expect_s3_class(dendro_network(sim_table(hol_rom)), class = "igraph")
})
