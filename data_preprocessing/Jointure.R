# charger les librairies
library(tidyverse)

# Créationd de dataframes

## dataframe "personne"
personnes <- tibble(
  nom = c("Sylvie", "Sylvie", "Monique", "Gunter", "Rayan", "Rayan"),
  voiture = c("Twingo", "Ferrari", "Scenic", "Lada", "Twingo", "Clio")
)

## dataframe "voiture"
voitures <- tibble(
  voiture = c("Twingo", "Ferrari", "Clio", "Lada", "208"),
  vitesse = c("140", "280", "160", "85", "160")
)

# Jointure

## Left join
left_join(personnes, voitures, by = "voiture") # jointure par la clé "voiture"

## Right join
right_join(personnes, voitures, by = "voiture")

## Inner join
inner_join(personnes, voitures, by = "voiture")

## Full join
full_join(personnes, voitures, by = "voiture")

## Semi join
semi_join(personnes, voitures, by = "voiture")

## Anti join
anti_join(personnes, voitures, by = "voiture")

## Merge
merge(personnes, voitures, by = "voiture")






