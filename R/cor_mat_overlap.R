# pearson correlation with overlap
# comparing rwl objects with same date range
# about  2-3 times faster than cor.with.limit.R
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