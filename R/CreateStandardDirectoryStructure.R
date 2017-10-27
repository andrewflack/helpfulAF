#' Function to create the necessary directories and files for an organized analysis
#'
#' @param path Path to parent folder for the analysis
#' @param dirs Directories to create
#' @examples
#' \dontrun{
#' CreateStandardDirectoryStructure()
#' }
#' @export

CreateStandardDirectoryStructure <-
  function(path = ".",
           dirs = c("assets",
                    "functions",
                    "figures",
                    "data",
                    "data_raw",
                    "reports",
                    "rmds",
                    "r_scripts")) {
    oldwd <- setwd(path)
    
    lapply(dirs,
           dir.create,
           showWarnings = FALSE,
           recursive = TRUE)
    
    # add README
    file.create("README.md")
    writeLines(paste0("# ", basename(normalizePath(path)), " README\n"), file("README.md"))
    
    # add TODO
    file.create("TODO.md")
    writeLines(paste0("# ", basename(normalizePath(path)), " TODO\n"), file("TODO.md"))
    
    # add run_all.R
    file.create("run_all.R")
    writeLines(
      paste0(
        "# Run all analysis in: ",
        basename(normalizePath(path)),
        "\n\nsource('functions/make_reports.R')
        \n# List reports below using the format: report('01-Example.Rmd', n_file = '1')"
      ),
      file("run_all.R")
    )
    
    # add make_reports function
    file.create("functions/make_reports.R")
    
    x <- c("# source: https://github.com/jomuller/empty_project/blob/master/functions/make_reports.R

# By default, don't open the report at the end of processing
default_open_file <- FALSE

knitr::opts_knit$set(root.dir = '../.')

report <- function(rmd, n_file, open_file = default_open_file,
                   report_dir = 'reports', rmds_dir = 'rmds') {
  
  if(!require(rmarkdown)) stop('Install rmarkdown package')
  
  rmd_path <- file.path(rmds_dir, rmd)
  
  # Generate the file name (without number) based on rmd file
  base_name <- sub(pattern = '.Rmd', replacement = '', x = basename(rmd_path))
  html_name <- paste0(base_name, '.html')
  
  if(!missing(n_file)){
    # Make nfiles with always 2 digits
    n_file <- ifelse(as.integer(n_file) < 10, paste0('0', n_file), n_file)
    file_name <- paste0(n_file, '-', html_name)
  } else {
    file_name <- html_name
  }
  # Produce the file. Simple wrapper of the render function
  rmarkdown::render(
    input = rmd_path,
    output_format = html_document(
      toc = TRUE,
      toc_depth = 1,
      code_folding = 'hide'
    ),
    output_file = file_name,
    output_dir = report_dir,
    envir = new.env()
  )
  
  if(open_file & Sys.info()[1] == 'Darwin') {
    result_path <- file.path(report_dir, file_name)
    system(command = paste('Open', result_path))
  }
  
}
      
    ")
    
    writeLines(x, file("functions/make_reports.R"))

    setwd(oldwd)
    
    invisible(NULL)
  }
