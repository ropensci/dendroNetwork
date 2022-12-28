#' Similarity table of tree-ring curves for the creation of a network
#'
#' Function to calculate various similarity measures for the creation of dendrochronological networks as described by Visser (2022)....
#'
#' @param trs1
#' @param trs2
#' @param min_overlap
#' @returns
#' @examples
#'
#'

sim_table <- function(trs1, trs2, min_overlap=50) {
  # nr of series in tree-ring series
  n1 <- dim(trs1)[2]
  n2 <- dim(trs2)[2]

  # if two different tree ring data sets, make daterange similar
  if (treeringfile != treeringfile2) {
    # determine min and max years
    min_yr_1 <- min(as.numeric(rownames(trs1)))
    max_yr_1 <- max(as.numeric(rownames(trs1)))
    min_yr_2 <- min(as.numeric(rownames(trs2)))
    max_yr_2 <- max(as.numeric(rownames(trs2)))
    min_12 <- min(min_yr_1,min_yr_2)
    max_12 <- max(max_yr_1,max_yr_2)
    daterange <- min_12:max_12
    # make daterange of both matrices similar
    trs1_nw <- matrix(NA_real_, nrow = length(daterange), ncol = n1)
    trs1_nw <- as.rwl(trs1_nw)
    rownames(trs1_nw) <- daterange
    trs1_nw[(min_yr_1-min_12+1):(length(daterange) - (max_12 - max_yr_1)),] <- trs1
    colnames(trs1_nw) <- colnames(trs1)
    trs1 <- trs1_nw
    rm(trs1_nw)
    trs2_nw <- matrix(NA_real_, nrow = length(daterange), ncol = n2)
    trs2_nw <- as.rwl(trs2_nw)
    rownames(trs2_nw) <- daterange
    trs2_nw[(min_yr_2-min_12+1):(length(daterange) - (max_12 - max_yr_2)),] <- trs2
    colnames(trs2_nw) <- colnames(trs2)
    trs2 <- trs2_nw
    rm(trs2_nw)
    rm(min_yr_1,min_yr_2,max_yr_1,max_yr_2,min_12,max_12,daterange)
  }
  # pre allocate matrices SGC, SSGC, Overlap
  SGC_mat <- matrix(NA_real_, nrow = n1, ncol = n2)
  rownames(SGC_mat) <- names(trs1)
  colnames(SGC_mat) <- names(trs2)
  SSGC_mat <- SGC_mat
  SGC_ol_mat <- SGC_mat
  # Calcluate SGC & SSGC
  treering_sign_1 <- apply(trs1, 2, diff)
  treering_sign_1 <- sign(treering_sign_1)
  treering_sign_2 <- apply(trs2, 2, diff)
  treering_sign_2 <- sign(treering_sign_2)
  for (i in 1:n1) {
    treering_GC <- abs(treering_sign_1[,i]-treering_sign_2)
    # overlap is the number of overlapping growth changes
    treering_GCol <- colSums(!is.na(treering_GC))
    treering_GCol[treering_GCol==0] <- NA
    treering_GCol[treering_GCol<min_overlap] <- NA
    # semi synchronous growth changes
    treering_GC1 <- colSums(treering_GC==1,na.rm=TRUE)
    # synchronous growth changes
    treering_GC0 <- colSums(treering_GC==0,na.rm=TRUE)
    SGC_values <- treering_GC0 / treering_GCol
    SSGC_values <- treering_GC1 / treering_GCol
    SGC_mat[i,] <- SGC_values
    SSGC_mat[i,] <- SSGC_values
    SGC_ol_mat[i,] <- treering_GCol
  }
  # calculate p-value
  size_ol <- dim(SGC_ol_mat)
  s_mat= 1 /(2*sqrt(SGC_ol_mat))
  z_mat=(SGC_mat-0.5)/s_mat
  p_mat=2*(1-pnorm(z_mat,0,1))

  # correlation and T
  trs1_wuchs <- as.rwl(apply(trs1, 2, wuchswerte))
  trs2_wuchs <- as.rwl(apply(trs2, 2, wuchswerte))
  #r_list <- cor.with.limit(overlap,trs1,trs2,"pearson")
  r_list <- cor_mat_overlap(trs1,trs2,min_overlap)
  r_mat <- r_list[[1]]
  r_ol_mat <- r_list[[2]]
  rm(r_list)
  rhol_list <- cor_mat_overlap(trs1_wuchs,trs2_wuchs,min_overlap)
  rhol_mat <- rhol_list[[1]]
  rhol_ol_mat <- rhol_list[[2]]
  rm(rhol_list)
  # students t
  t_mat <- t_value(r_mat,r_ol_mat)
  thol_mat <- t_value(rhol_mat,rhol_ol_mat)

  #listing data
  list_overlap <- subset(melt(SGC_ol_mat,value.name = "overlap"))
  list_SGC <- subset(melt(SGC_mat), value.name = "SGC")
  list_SSGC <- subset(melt(SSGC_mat), value.name = "SSGC")
  list_p<- subset(melt(p_mat,value.name = "p"))
  list_r <- subset(melt(r_mat,value.name = "r"))
  list_r_ol <- subset(melt(r_ol_mat,value.name = "r_ol"))
  list_rhol <- subset(melt(rhol_mat,value.name = "r_hol"))
  list_t <- subset(melt(t_mat,value.name = "t"))
  list_thol <- subset(melt(thol_mat,value.name = "t_hol"))

  total <- merge(list_r_ol,list_r,by=c("Var1","Var2"))
  total <- merge(total,list_rhol,by=c("Var1","Var2"))
  total <- merge(total,list_t,by=c("Var1","Var2"))
  total <- merge(total,list_thol,by=c("Var1","Var2"))
  total <- merge(total,list_SGC,by=c("Var1","Var2"))
  total <- merge(total,list_SSGC,by=c("Var1","Var2"))
  total <- merge(total,list_p,by=c("Var1","Var2"))
  total <- total[!(rowSums(is.na(total))==8),]
  if (treeringfile == treeringfile2) {
    total <- total[!(total$Var1 == total$Var2),] # remove self-comparisons
  }

  # remove infinite good comparisons
  total <- total[!is.infinite(total$t),]

  # naming of series; last character is radius, split name and radius letter/number
  total <- cbind(str_sub(total[,1], 0, -2), str_sub(total[,1], -1),str_sub(total[,2], 0, -2), str_sub(total[,2], -1),total[,3:10])
  colnames(total) <- c("series_a","radius_a","series_b","radius_b","overlap","r","r_hol","t","t_hol","sgc","ssgc","p")





}
