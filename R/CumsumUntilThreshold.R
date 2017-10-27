#' Group rows based on cumulative sum with reset after reaching threshold
#' @source https://gist.github.com/jgilfillan/23336d0f5bcfffe6a71d0bdd634d023e
#'
#' @param x A vector of numbers.
#' @param threshold Threshold for resetting cumsum.
#' @return Vector of groupings such that threshold is never exceeded.
#' @examples
#' testvector <- c(.5, .1, .2, .9, .9, .2, .5)
#' CumsumUntilThreshold(testvector, 1)
#' @export

CumsumUntilThreshold <- function(x, threshold) {
  cumsum <- 0
  group <- 1
  result <- numeric()

  for (i in 1:length(x)) {
    cumsum <- cumsum + x[i]

    if (cumsum > threshold) {
      group <- group + 1
      cumsum <- x[i]
    }

    result = c(result, group)

  }

  return (result)
}
