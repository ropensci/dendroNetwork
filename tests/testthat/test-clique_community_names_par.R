test_that("clique_community_names_par results in dataframe", {
  expect_snapshot(clique_community_names_par(dendro_network(sim_table(hol_rom), r_threshold = 0.4, sgc_threshold = 0.4), k = 3, n_core = 2))
})
