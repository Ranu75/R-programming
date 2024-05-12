# Charger les packages
library(tidyverse)
library(questionr)
library(labelled)
library(gtsummary)

# Charger les données 
data(hdv2003)

# Préparation des données 

## Vérification de la qualité des données
look_for(hdv2003, "sport")
look_for(hdv2003, "sexe")

mutate(hdv2003, fct_relevel(sexe = sexe, "Femme"))
hdv2003 <- hdv2003 |> 
  mutate(sexe = sexe |> fct_relevel("Femme"))
freq(hdv2003$sexe)

look_for(hdv2003, "age", "heures")

## Création de la variable tranche d'âge
hdv2003 <- hdv2003 |> 
  mutate(
    groupe_ages = age |>
      cut(
        c(18, 25, 45, 65, 99),
        right = FALSE,
        include.lowest = TRUE,
        labels = c("18-24 ans", "25-44 ans",
                   "45-64 ans", "65 ans et plus")
      )
  )

freq(hdv2003$groupe_ages)

hdv2003 <- hdv2003 |> 
  mutate(
    etudes = nivetud |> 
      fct_recode(
        "Primaire" = "N'a jamais fait d'etudes",
        "Primaire" = "A arrete ses etudes, avant la derniere annee d'etudes primaires",
        "Primaire" = "Derniere annee d'etudes primaires",
        "Secondaire" = "1er cycle",
        "Secondaire" = "2eme cycle",
        "Technique / Professionnel" = "Enseignement technique ou professionnel court",
        "Technique / Professionnel" = "Enseignement technique ou professionnel long",
        "Supérieur" = "Enseignement superieur y compris technique superieur"
      )    
  )
freq(hdv2003$etudes)
### conserver les valeurs manquantes car non négligeable
hdv2003$etudes <- fct_na_value_to_level(hdv2003$etudes, "Non documenté")

hdv2003 <- set_variable_labels(hdv2003,
    sport = "Pratique un sport ?",
    sexe = "Sexe",
    groupe_ages = "Groupe d'âges",
    etudes = "Niveau d'études",
    relig = "Rapport à la religion",
    heures.tv = "Heures de télévision / jour"
  )

# Statistiques Descriptives

hdv2003 |> 
  tbl_summary(
    by = sport,
    include = c(sexe, groupe_ages, etudes, relig, heures.tv)
  ) |>
  add_overall(last = TRUE) |> 
  add_p() |> 
  bold_labels() |> 
  modify_spanning_header(
    update = all_stat_cols() ~ "**Pratique un sport ?**"
  )

# Modélisation statistiques

mod_binomiale <- glm(
  sport ~ sexe + groupe_ages + etudes + relig + heures.tv,
  family = binomial,
  data = hdv2003
)

## Intervalle de confiance
bold_labels(tbl_regression(mod_binomiale, intercept = TRUE))

## Écart-type
mod_binomiale |> 
  tbl_regression() |> 
  add_significance_stars() |> 
  modify_column_hide(c("ci", "p.value")) |> 
  modify_column_unhide("std.error") |> 
  bold_labels()

## Visualisation graphique
ggcoef_model(mod_binomiale, exponentiate = TRUE)
ggcoef_table(mod_binomiale, exponentiate = TRUE) #avec les résultats en plus






