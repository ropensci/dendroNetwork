#' Pearson correlation matrix
#'
#' Function that creates a Pearson correlation matrix of two rwl objects compared. If the same rwl-object is passed to the function, the correlation between all series is calculated. In addition, the number of overlapping tree-rings is part of the output. The results can be used to calculate the Students' t value
#'
#' The function is an adaptation of the function cor.with.limit.R() from https://github.com/AndyBunn/dplR/blob/master/R/rwi.stats.running.R, but it is faster and also gives the overlap.
#'
#' @param x rwl object of tree-ring series
#' @param y rwl object of tree-ring series
#' @param minoverlap the correlation will only be calculated if the number of overlapping tree-rings is equal or larger than this value
#'
#' @returns a list with two matrices: one with the correlation values and one with the number of overlapping tree rings for each correlation value. The matrices have row names and column names of the compared tree-ring curves
#' @examples
#' cor_mat_overlap(rwl_object1, rwl_object2, 50)
#' cor_mat_overlap(rwl_object1, rwl_object1, 50)
#'
#' @export cor_mat_overlap
#'
#' @author Andy Bunn
#' @author Ronald Visser

cor_mat_overlap <- function(x, y, minoverlap) {
  nx <- ncol(x) # count series in x
  ny <- ncol(y) # count series in x
  rmat <- matrix(NA_real_, nx, ny)
  nmat <- matrix(NA, nx, ny)
  for (i in 1:nx) {
    cur_x <- x[,i]
    cur_x_notna <- !is.na(cur_x)
    for (j in 1:ny) {
      cur_y <- y[,j]
      L <- (cur_x_notna) + (!is.na(cur_y))==2 # common overlap
      overlap <- sum(L==TRUE)
      if (overlap >= minoverlap) {
        x2 <- cur_x[L]
        y2 <- cur_y[L]
        meanx <- mean(x2)
        meany <- mean(y2)
        dx <- x2 - meanx
        dy <- y2 - meany
        rmat[i, j] <- (sum(dx*dy)) / (sqrt( sum(dx^2)* sum(dy^2)))
        nmat[i, j] <- overlap
      }
    }
  }
  rownames(nmat) <- rownames(rmat) <- colnames(x)
  colnames(nmat) <- colnames(rmat) <- colnames(y)
  list(rmat, nmat)
}
