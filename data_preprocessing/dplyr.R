# installer des packages
install.packages('nycflights13')

# import des packages
library(tidyverse)
library(dplyr)
library(nycflights13)

# Chargement des trois tables du jeu de données
data(flights)

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

#### everything : sélectionne l'ensemble des colonnes non encore sélectionnées
select(airports, name, everything())

## relocate : réordonner toutes les variables
relocate(flights, dep_delay, arr_time, dep_time)

## rename : renommer des colonnes
rename(flights, mois = month, jour = day, 'année' = year)
rename(flights, "retard départ" = dep_delay,"retard arrivée" = arr_delay)
select(rename(flights, "retard départ" = dep_delay,"retard arrivée" = arr_delay), "retard départ", "retard arrivée")

## rename_with : renommer en utilisant une fonction
rename_with(flights, toupper)

## arrange : réordonner les lignes d'un tableau selon plusieurs colonnes
arrange(flights, dep_delay)

### arrange + fonction

#### desc : trier par ordre décroissant
arrange(flights, desc(dep_delay))

#### desc + slice
slice(arrange(flights, desc(dep_delay)), 1:3)

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

## slice_sample : choisit des lignes au hasard

slice_sample(flights, n=5) # choisit 5 lignes au hasard
slice_sample(flights, prop = .1) # tirer 10% des lignes au hasard

## distinct : filtre les lignes du tableau pour ne conserver que les lignes distinctes
flights_double <- distinct(select(flights, day, month))
distinct(flights, month, day) # conservation de la première variable
distinct(flights, month, day, .keep_all = TRUE)

## pull : accéder au contenu d'une variable
mean(pull(flights, sched_dep_time))

## group_by : définir des groupes de lignes à partir des valeurs d'une ou plusieurs colonnes
group_by(flights, month)

### group_by + autres fonctions
#### slice
slice(group_by(flights, month), 1)

#### mutate
mutate(group_by(flights, month), 
       mean_delay_month = mean(dep_delay, na.rm = TRUE))

#### filter
filter(group_by(flights, month),
       dep_delay == max(dep_delay, na.rm = TRUE))

#### arrange
arrange(group_by(flights, month), desc(dep_delay))
arrange(group_by(flights, month), desc(dep_delay), .by_group = TRUE)

## summarise : agréger les lignes du tableau en effectuant une opération "résumée" sur une ou plusieurs colonnes
summarise(flights, 
          retard_dep = mean(dep_delay, na.rm=TRUE),
          retard_arr = mean(arr_delay, na.rm=TRUE))

summarise(group_by(flights, month),
          max_delay = max(dep_delay, na.rm=TRUE),
          min_delay = min(dep_delay, na.rm=TRUE),
          mean_delay = mean(dep_delay, na.rm=TRUE)
          )

summarise(group_by(flights, dest), n=n())

## count
count(flights, dest)
