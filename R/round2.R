#' Round half away from zero. R uses "round to nearest even" by default.
#' @source https://stackoverflow.com/questions/12688717/round-up-from-5-in-r
#'
#' @param x A number.
#' @param n Number of decimal places to be used.
#' @return \code{x} rounded to \code{n} digits.
#' @examples
#' round2(24.5)
#' round2(-24.5, 0)
#' @export

round2 <- function(x, n = 0) {
  posneg <- sign(x)
  z <- abs(x)*10^n
  z <- z + 0.5
  z <- trunc(z)
  z <- z/10^n
  z*posneg
}
