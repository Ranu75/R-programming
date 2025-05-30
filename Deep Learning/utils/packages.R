# source the directory
setwd("~/Documents/R-programming/Deep Learning")

# import all packages needed
packages = readLines("utils/requirement.txt")

# load packages
for (package in packages){
  if (!require(package, character.only = TRUE)) {
    install.packages(package)
    library(package, character.only = TRUE)
  }
}

