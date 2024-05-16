# installer les packages
install.packages("srvyr")

# charger les packages
library(srvyr) # extension du package "dplyr" aux plans d'échantillonnage complexe
library(dplyr)

# charger les données
data("iris")
data("Titanic")
data("api", package = "survey")

# nettoyage des données
titanic <- as_tibble(Titanic)
t_titanic <- as_survey_design(titanic, weights = n)

# échantillonnage
## échantillonnage aléatoire simple
t_iris <- as_survey_design(iris)
class(t_iris)

## échantillon stratifié
t_strates <- as_survey_design(apistrat,
                              strata = stype,
                              weights = pw)

## échantillon en grappes
### échantillon en grappes à 1 degré
t_grappes <- as_survey_design(apiclus1,
                              id = dnum,
                              weights = pw)

### échantillon en grappes à 2 degré``
t_grappes2 <- as_survey_design(apiclus2,
                               id = c(dnum, snum),
                               fpc = c(fpc1, fpc2))





















