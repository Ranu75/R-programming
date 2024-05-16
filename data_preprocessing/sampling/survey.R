# installer un package
install.packages("survey")

# charger un package
library(survey)
library(labelled)
library(dplyr)

# charger les données
data("iris")
data("Titanic")
data("api", package = "survey")

# nettoyage des données
titanic <- as_tibble(Titanic)
look_for(titanic)

# échantillonnage
## aléatoire simple
p_iris <- svydesign(
  ids = ~ 1,
  data = iris
)
## simplement pondéré
p_titanic <- svydesign(
  ids = ~ 1,
  data = titanic,
  weights = ~ n
)

## échantillon stratifié
p_strates <- survey::svydesign(
  id = ~ 1, 
  strata = ~ stype, 
  weights = ~ pw, 
  data = apistrat
)

## enquête en grappes à 1 degré (identifiant des grappes est indiqué par la variable dnum)
p_grappes <- svydesign(
  id = ~ dnum,
  weights = ~ pw,
  data = apiclus1
)

## enquête en grappes à 2 degrés (les 2 niveaux sont donnés par les variables dnum et snum)
p_grappes2 <- svydesign(
  id = ~ dnum + snum,
  fpc = ~ fpc1 + fpc2,
  data = apiclus2
)

weights(p_grappes2)

















