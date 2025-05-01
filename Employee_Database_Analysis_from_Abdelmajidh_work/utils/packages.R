# créer un environnement virtuel
if (!requireNamespace("renv", quietly = TRUE)){
  install.packages("renv")
}

# installer et charger les librairies
requirement_packages = "~/Documents/R-programming/Employee_Database_Analysis_from_Abdelmajidh_work/utils/requirements"

## installer et charger le package requirements
if (!requireNamespace("requiRements", quietly = TRUE)){
  install.packages("requiRements")
  library(requiRements)
}

## installer les autres librairies
requiRements::install(path_to_requirements = requirement_packages)

## charger les autres librairies
packages = readLines(requirement_packages)

lapply(as.list(packages), library, , character.only = TRUE)
