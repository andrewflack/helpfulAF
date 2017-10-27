#' Calculate the midpoints of bins created using cut function
#' @source https://mcfromnz.wordpress.com/2014/05/23/finding-the-midpoint-when-creating-intervals/
#'
#' @param x Vector of bins returned from cut().
#' @param dp Number of decimal points to round.
#' @return numeric vector of bin midpoints
#' @examples
#' \dontrun{
#' x <- c(1, 2, 5, 10, 15, 21, 30, 50, 51, 52, 60)
#' FindBinMidpoints(cut(x, quantile(x), include.lowest = T))
#' }
#' @export

FindBinMidpoints <- function(x, dp = 2) {
  lower <- as.numeric(gsub(",.*", "", gsub("\\(|\\[|\\)|\\]", "", x)))
  upper <- as.numeric(gsub(".*,", "", gsub("\\(|\\[|\\)|\\]", "", x)))
  return(round(lower + (upper - lower) / 2, dp))
}