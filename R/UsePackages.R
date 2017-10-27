#' Load the namespace of a package (library), or install if necessary
#' @source My colleague Wil Doane
#' 
#' @param ... Bare (unquoted) package names
#' @examples
#' \dontrun{
#' UsePackages(ggplot2, tidyverse)
#' }
#' @export

UsePackages <-
  function(..., repos_ = "https://cran.revolutionanalytics.com") {
    
    # extract parameter names from ...
    required_pkgs <- sapply(substitute(list(...))[-1], deparse)
    
    missing_pkgs <- required_pkgs[!required_pkgs %in% installed.packages()]
    if (length(missing_pkgs) > 0)
      install.packages(missing_pkgs, dependencies = TRUE,
                       repos = "https://cran.revolutionanalytics.com")
    
    # use library, rather than require, because library throws an error on fail
    invisible(sapply(required_pkgs, library, character.only = TRUE) )
  }