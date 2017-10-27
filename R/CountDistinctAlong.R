#' Compute number of distinct values encountered along an ordered vector
#' @source https://stackoverflow.com/questions/25553099/r-dplyr-cumulative-version-of-n-distinct
#'
#' @param var Vector of values.
#' @examples
#' df <- data.frame(time = 1:20,
#'   grp = sort(rep(1:5,4)),
#'   var1 = rep(c('A','B'),10)
#' )
#' CountDistinctAlong(df$grp)
#' @export

CountDistinctAlong <- function(var) sapply(seq_along(var), function(x) length(unique(head(var, x))))
