# charger des packages
library(tidyverse)
library(ggplot2)
library(questionr)

# charger les données
data(rp2018) # jeu de données issu du recensement de la population de 2018 inclus dans l'extension
data("economics") 

# Filtrage du jeu de données rp
rp <- filter( 
  rp2018,
  departement %in% c("Oise", "Essone", "Yveline", "Paris", "Val-de-Marne")
)

# visualisation des données

## histogramme
ggplot(rp) +
  geom_histogram(aes(x = cadres))

## nuage de points
ggplot(rp) +
  geom_point(
    aes(x=dipl_sup, y=cadres),
    color = "darkgreen", size = 3, alpha = 0.3
    )

## boxplot
ggplot(rp) +
  geom_boxplot(
    aes(x = departement, y = maison),
    fill = "wheat", color = "tomato4", varwidth = TRUE
    )

## diagramme en violon
ggplot(rp) +
  geom_violin(
    aes(x = departement, y = maison),
    fill = "skyblue",
    bw = 2
  )

## diagramme en barre
ggplot(rp) + 
  geom_bar(aes(x = departement))

ggplot(rp) + 
  geom_bar(aes(y = departement))

## diagramme de texte
ggplot(rp) +
  geom_text(
    aes(x = dipl_sup, y = cadres, label = commune),
    color = "darkred", size = 2
  )

ggplot(rp) +
  geom_label(
    aes(x = dipl_sup, y = cadres, label = commune),
    size = 2
    )

ggplot(rp) +
  geom_density(aes(x = cadres), bw = 1) # bw permet de régler la 'finesse' de l'estimation de densité

## graphique linéaire
ggplot(economics) + 
  geom_line(
    aes(x = date, y = unemploy),
    color = "darkgreen")

## grille
ggplot(rp2018) + 
  geom_bin2d(aes(x = cadres, y = dipl_sup))

ggplot(rp2018) +
  geom_hex(
    aes(x = cadres, y = dipl_sup),
    bins = 40
  )

## mappages 

### colorier en fonction d'une variable
ggplot(rp) + 
  geom_point(
    aes(x = dipl_sup, y = cadres, color = departement)
  )

### taille
ggplot(rp) + 
  geom_point(
    aes(x = dipl_sup, y = cadres, size = pop_tot)
  )

### transparence
ggplot(rp) +
  geom_point(
    aes(x = dipl_sup, y = cadres, alpha = maison)
  )

### geom_bar et position
ggplot(rp) + # pour les empiler
  geom_bar(aes(x = departement, fill = pop_cl))

ggplot(rp) + # pour les mettre côte à côte
  geom_bar(
    aes(x = departement, fill = pop_cl),
    position = "dodge"
    )

ggplot(rp) + # pour représenter les proportions
  geom_bar(
    aes(x = departement, fill = pop_cl),
    position = "fill"
  )

## Représentation de plusieurs geom

### boxplot + point
ggplot(rp) +
  geom_boxplot(aes(x = departement, y = maison)) +
  geom_point(
    aes(x = departement, y = maison),
    col = "red", alpha = 0.2
  )

### boxplot + jitter
ggplot(rp) +
  geom_boxplot(aes(x = departement, y = maison)) +
  geom_jitter(
    aes(x = departement, y = maison),
    col = "red", alpha = 0.2
  )

## Régression linéaire
ggplot(rp, aes(x = dipl_sup, y = cadres)) +
  geom_point(alpha = 0.2) +
  geom_smooth(method = "lm")

ggplot(rp, aes(x = dipl_sup, y = cadres)) +
  geom_point(alpha = 0.2) +
  geom_density2d(color = "red") +
  geom_smooth(method = "lm")

## Faceting : réaliser plusieurs fois le même graphiques selon les valeurs d'une ou plusieurs variables qualitatves
ggplot(data = rp) +
  geom_histogram(aes(x = cadres)) +
  facet_wrap(vars(departement))

ggplot(data = rp) +
  geom_histogram(aes(x = cadres)) +
  facet_grid(rows = vars(departement))

ggplot(data = rp) +
  geom_histogram(aes(x = cadres)) +
  facet_grid(
    rows = vars(departement), cols = vars(pop_cl)
  )
