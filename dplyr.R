# installer des packages
install.packages('nycflights13')

# import des packages
library(tidyverse)
library(dplyr)
library(nycflights13)

# Chargement des trois tables du jeu de données
data(flights)
data(airports)
data(airlines)

# Utilisation des fonctions du packages

## slice : sélection des lignes dans la table
slice(flights, 345) # sélection de la 345ème ligne
slice(flights, 1:5) # sélection des 5 premières lignes

## filter : sélection des lignes sous conditions
filter(flights, month == 1) # sélection des vols pour le mois de Janvier
filter(flights, dep_delay >= 10 & dep_delay <= 15) # sélection des vols avec un retard compris entre 10 et 15 min
filter(flights, distance == max(distance)) # sélection des vols avec la plus grande distance

## select : sélection des colonnes
select(flights, dep_time, dep_delay) # sélection des deux colonnes
select(flights, -month, -day) # suppression des deux colonnes
select(flights, year:day) # sélection des colonnes de year à day

### select + condition sur les noms des variables

#### starts_with : débute par tel mot, lettre
select(flights, starts_with("dep_"))

#### contains : contient tel séquence
select(flights, contains("time"))

#### ends_with : termine par tel séquence
select(flights, ends_with("time"))

#### all_of + any_of : fournir une liste de variables à extraire sous forme de vecteur textuel
select(flights, all_of(c("year", "month", "day")))
select(flights, all_of(c("century", "year", "month", "day"))) # renvoie une erreur si la variable n'est pas trouvée
select(flights, any_of(c("century", "year", "month", "day"))) 

#### where : selection des colonnes à partir d'une fonction
select(flights, where(is.character)) # sélection des variables qualitatives

## relocate : réordonner toutes les variables
relocate(flights, dep_delay, arr_time, dep_time)

## rename : renommer des colonnes
rename(flights, mois = month, jour = day, 'année' = year)
rename(flights, "retard départ" = dep_delay,"retard arrivée" = arr_delay)

## arrange : réordonner les lignes d'un tableau selon plusieurs colonnes
arrange(flights, dep_delay)

### arrange + fonction

#### desc : trier par ordre décroissant
arrange(flights, desc(dep_delay))

## mutate : création d'une nouvelle colonne à partir des variables existantes
### création de nouvelles variables par calcul
select(mutate(flights, 
              distance_km = distance / 0.62137, 
              vitesse = distance_km / air_time * 60), 
       distance, distance_km, vitesse)

### création de catégories
flights <- mutate(flights, 
                  type_retard = case_when(
                    dep_delay > 0 & arr_delay > 0 ~ "Retard départ et arrivée",
                    dep_delay > 0 & arr_delay <= 0 ~ "Retard départ",
                    dep_delay <= 0 & arr_delay > 0 ~ "Retard arrivée",
                    TRUE ~ "Aucun retard"))
select(flights, type_retard)

### création d'un pipeline pour recoder les mois
flights$month_name <- recode_factor(flights$month,
                                    "1" = "Jan",
                                    "2" = "Feb",
                                    "3" = "Mar",
                                    "4" = "Apr",
                                    "5" = "May",
                                    "6" = "Jun",
                                    "7" = "Jul",
                                    "8" = "Aug",
                                    "9" = "Sep",
                                    "10" = "Oct",
                                    "11" = "Nov",
                                    "12" = "Dec"
)

select(flights, month_name)

