test_that("clique_community_names results in dataframe", {
  expect_snapshot(clique_community_names(dendro_network(sim_table(hol_rom)), k = 3))
})
