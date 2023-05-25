#' Similarity table of tree-ring curves for the creation of a network
#'
#' Function to calculate various similarity measures for the creation of dendrochronological networks as described by Visser (2021a). The function results in a list of all similarities of all comparisons between the tree-ring series in trs1 (or between trs1 and trs2). The resulting list includes the overlap, correlation (both with and without Hollstein-transformation), the t-value based on these correlations, Synchronous Growth Changes (SGC), Semi Synchronous Growth Changes (SSGC), and the related probability of exceedence (p).The last three (SGC, SSGC and p) are explained in Visser (2021b).
#'
#' @usage
#' sim_table(trs1,
#'           trs2=NULL,
#'           min_overlap=50,
#'           last_digit_radius=FALSE)
#'
#' @param trs1 Rwl object with first tree-ring series to be compared with trs2
#' @param trs2 Optional second rwl object with second tree-ring series to be compared with trs1. Use this is you have to datasets that you want to compare.
#' @param min_overlap If the overlap of the compared series is longer or equal than this minimal value, the similarities will be calculated for the comparison
#' @param last_digit_radius Set this to TRUE if the last digit of a series name is the radius of the tree-ring series
#' @returns The resulting list includes the names of the compared series, overlap, correlation (both with and without Hollstein-transformation), t-value based on these correlations, SGC, SSGC and the related probability of exceedence.
#'
#' @references
#' Visser, RM. 2021a Dendrochronological Provenance Patterns. Network Analysis of Tree-Ring Material Reveals Spatial and Economic Relations of Roman Timber in the Continental North-Western Provinces. Journal of Computer Applications in Archaeology 4(1): 230–253. DOI: https://doi.org/10.5334/jcaa.79.
#'
#' Visser, RM. 2021b On the similarity of tree-ring patterns: Assessing the influence of semi-synchronous growth changes on the Gleichläufigkeitskoeffizient for big tree-ring data sets. Archaeometry 63(1): 204–215. DOI: https://doi.org/10.1111/arcm.12600.
#'
#'
#' @examples
#' data(hol_rom)
#' sim_table(hol_rom)
#' sim_table(hol_rom, last_digit_radius = TRUE)
#' sim_table(hol_rom, min_overlap = 25)
#' sim_table(hol_rom, min_overlap = 100, last_digit_radius = TRUE)
#'
#' @export sim_table

sim_table <- function(trs1,
                      trs2=NULL,
                      min_overlap=50,
                      last_digit_radius=FALSE) {
  # nr of series in tree-ring series
  n1 <- dim(trs1)[2]
  if (is.null(trs2)) {trs2_null = TRUE} else {trs2_null = FALSE}
  if (!is.null(trs2)){
    n2 <- dim(trs2)[2]
    # make date range similar of the two tree-ring data sets
    # first determine min and max years
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
    trs2_nw <- matrix(NA_real_, nrow = length(daterange), ncol = n2)
    trs2_nw <- as.rwl(trs2_nw)
    rownames(trs2_nw) <- daterange
    trs2_nw[(min_yr_2-min_12+1):(length(daterange) - (max_12 - max_yr_2)),] <- trs2
    colnames(trs2_nw) <- colnames(trs2)
    trs2 <- trs2_nw
  } else if (is.null(trs2)) {
    trs2 <- trs1
    n2 <- n1
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
  if (trs2_null == TRUE) {
    total <- total[!(total$Var1 == total$Var2),] # remove self-comparisons
  }

  # remove infinite good comparisons
  total <- total[!is.infinite(total$t),]

  if (last_digit_radius==TRUE){
    # renaming of series; last character is radius, split name and radius letter/number
    total <- cbind(str_sub(total[,1], 0, -2), str_sub(total[,1], -1),str_sub(total[,2], 0, -2), str_sub(total[,2], -1),total[,3:10])
    colnames(total) <- c("series_a","radius_a","series_b","radius_b","overlap","r","r_hol","t","t_hol","sgc","ssgc","p")
  }
    else {
      colnames(total) <- c("series_a","series_b","overlap","r","r_hol","t","t_hol","sgc","ssgc","p")
    }
  return(total)
}
