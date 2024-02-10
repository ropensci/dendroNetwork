test_that("`sim_table(hol_rom)` results in the expected similarity table", {
  local_edition(3)
  expect_snapshot(sim_table(hol_rom))
  expect_snapshot(sim_table(hol_rom, hol_rom))
  expect_s3_class(sim_table(hol_rom), class = "data.frame")
})
