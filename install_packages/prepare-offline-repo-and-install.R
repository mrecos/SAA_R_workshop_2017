


#-------------------------------------------------------------------------------
# the method below is a little sketchy for OSX and a few cutting edge pkgs

# set working directory to the location of this file
# assuming we are using RStudio
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Specify list of packages to download/install
pkgs <-
  c(
    #prereqs
    'codetools', 
    "Rcpp",
    # tidyverse
    "broom",
    "DBI",
    "dplyr",
    "FSA",
    "forcats",
    "ggplot2",
    "ggmap",
    "haven",
    "httr",
    "hms",
    "jsonlite",
    "lubridate",
    "magrittr",
    "modelr",
    "purrr",
    "readr",
    "readxl",
    "scales",
    "sf",
    "stringr",
    "sp",
    "spatstat",
    "tibble",
    "rgdal",
    "rvest",
    "tidyr",
    "xml2",
    # writing
    'devtools',
    'rmarkdown',
    'knitr',
    'bookdown',
    'git2r',
    #vis
    'viridis',
    'plotly',
    'ggforce',
    'ggpmisc',
    'ggrepel',
    'gridExtra'
  )

#------------------------------------------------------------------
# This section will download the pkgs from the internet,
# if you don't have an internet connection, skip to the next
# section

# These lines are for creating the local miniCRAN repository:
library("miniCRAN")
# Make list of package URLs
rstudio <- c(CRAN = "http://cran.rstudio.com")
os <- c("source", "mac.binary", "mac.binary.mavericks", "win.binary")

for(i in seq_along(os)) {
  
  pkgList <- pkgDep(pkgs,
                    repos = rstudio,
                    type = os[i])
  # pkgList
  # # Set location to store source files, assume we are in dir of this file
  # getwd()
  # 
  # # Make repo for source
  makeRepo(pkgList,
           path = getwd(),
           repos = rstudio,
           type = os[i])
}


#------------------------------------------------------------------
# This will install the packages listed above, using the source files in the local
# miniCRAN repo. Run these lines if you are offline
install.packages(pkgs,
                 repos = paste0("file:///", getwd()),
                 type = ifelse(Sys.info()[['sysname']] %in% c("Windows",
                                                              "Darwin"),
                               "binary", "source"))
