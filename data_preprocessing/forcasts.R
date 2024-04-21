# installer le package
install.packages("questionr")

# charger les packages
library(tidyverse)
library(questionr)

# charger les données
data("hdv2003", package = "questionr")

# Modalités pour la variable qualif
## liste
levels(hdv2003$qualif)

## fréquence
freq(hdv2003$qualif)

### inverser l'odre des modalités
freq(fct_rev(hdv2003$qualif))

### indiquer l'ordre souhaité pour les modalités
freq(fct_relevel(hdv2003$qualif, "Cadre", "Autre", "Technicien","Employe"))

### ordonner les modalités en fonction de la fréquence
freq(fct_infreq(hdv2003$qualif))
freq(fct_infreq(fct_rev(hdv2003$qualif)))

### ordonner par ordre d'apparition dans le jeu de données
freq(fct_inorder(hdv2003$qualif))

## trier les modalités en fonction d'une autre variable
hdv2003$qualif_tri_age <- fct_reorder(hdv2003$qualif, hdv2003$age, .fun = mean)
summarise(group_by(hdv2003, qualif_tri_age), age_moyen = mean(age)) # trie les qualif en fonction de l'âge moyen

## modifier les modalités avec fct_recode
hdv2003$sexe <- fct_recode(hdv2003$sexe, f = "Femme", m = "Homme")
freq(hdv2003$sexe)

### possibilité d'attribuer le même à plusieurs modalités
levels(hdv2003$nivetud) 
hdv2003$nivetud <- fct_recode(hdv2003$nivetud,
                              "primaire" = "N'a jamais fait d'etudes",
                              "primaire" = "A arrete ses etudes, avant la derniere annee d'etudes primaires",
                              "primaire" = "Derniere annee d'etudes primaires",
                              "secondaire" = "1er cycle",
                              "secondaire" = "2eme cycle",
                              "technique/professionnel" = "Enseignement technique ou professionnel court",
                              "technique/professionnel" = "Enseignement technique ou professionnel long",
                              "superieur" = "Enseignement superieur y compris technique superieur")
freq(hdv2003$nivetud)

#### variante en utilisant fct_collapse
hdv2003$instruction <- fct_collapse(
  hdv2003$nivetud,
  "primaire" = c("N'a jamais fait d'etudes",
                 "A arrete ses etudes, avant la derniere annee d'etudes primaires",
                 "Derniere annee d'etudes primaires"),
  "secondaire" = c("1er cycle",
                   "2eme cycle"),
  "technique/professionnel" = c("Enseignement technique ou professionnel court",
                                "Enseignement technique ou professionnel long"),
  "supérieur" = "Enseignement superieur y compris technique superieur"
)

freq(hdv2003$instruction)

### Garder les modalités
freq(fct_other(hdv2003$qualif, keep = c("Technicien", "Cadre", "Employe")))

### Regrouper les modalités
freq(fct_lump_n(hdv2003$qualif, n=4, other_level = "Autres"))

### Sélectionner celles qui ont une minimum d'observations avec "fct_lump_min"
freq(fct_lump_min(hdv2003$qualif, min = 200, other_level = "Autres"))

## Découper une variable numérique en classes

### Couper en 5 classes par défaut
hdv2003 <- mutate(hdv2003, groupe_ages = cut(age, 5))
freq(hdv2003$groupe_ages)
### Couper en 5 classes en spécifiant manuellement
hdv2003 <- mutate(hdv2003, groupe_ages = cut(age, c(18, 20, 40, 60, 80, 97))) #18 exclue dans notre échelle
freq(hdv2003$groupe_ages)
hdv2003 <- mutate(            #18 inclus dans notre échelle
  hdv2003,
  groupe_ages = cut(
    age,
    c(18,20,40,60,80,97),
    include.lowest = TRUE
  )
)
freq(hdv2003$groupe_ages)
hdv2003 <- mutate(            #la borne inférieur est incluse à la place de la borne supérieure
  hdv2003,
  groupe_ages = cut(
    age,
    c(18,20,40,60,80,97),
    include.lowest = TRUE,
    right = FALSE,
  )
)
freq(hdv2003$groupe_ages)




