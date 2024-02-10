test_that("find_all_cpm_com() works", {
  expect_snapshot(find_all_cpm_com(dendro_network(sim_table(hol_rom))))
  expect_s3_class(find_all_cpm_com(dendro_network(sim_table(hol_rom))), class = "data.frame")
})
