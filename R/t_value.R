#' Function to determine the Students' t-value using the correlation and the number of compare values (tree-rings)
#'
#' @param r correlation value.
#' @param n number over overlapping tree-rings/compared values.
#' @returns Students' t value as a numeric.
#' @examples
#' t_value(0.5, 100)

t_value <- function(r, n) {
  t_value <- (r * sqrt(n - 1)) / sqrt(1 - r^2)
}
