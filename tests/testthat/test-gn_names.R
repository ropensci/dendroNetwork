test_that("gn_names results in correct output", {
  expect_snapshot(gn_names(dendro_network(sim_table(hol_rom))))
  expect_s3_class(gn_names(dendro_network(sim_table(hol_rom))), class = "data.frame")
})
