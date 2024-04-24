# installer une librairie
install.packages("gtsummary")

# chargé les librairies
library(gtsummary)
library(questionr)
library(purrr)

# charger les données
data("hdv2003", package = "questionr")

# tris à plat
tbl_summary(hdv2003, include = c(age, occup))

hdv2003 |>
  tbl_summary(
    include = c(age, heures.tv),
    statistic = 
      all_continuous() ~ "Moy. : {mean} [min-max : {min} - {max}]"
  )

# données manquantes
tbl_summary(hdv2003, 
            include = c(age, heures.tv),
            missing = "always",
            missing_text = "Nombre d'observations manquantes")

# statistiques

## variable quantitative
### mean
mean(hdv2003$heures.tv, na.rm = TRUE) # na.rm pour supprimer les valeurs manquantes
### standard deviation
sd(hdv2003$heures.tv, na.rm = TRUE)
### minimum 
min(hdv2003$heures.tv, na.rm = TRUE)
### maximum
max(hdv2003$heures.tv, na.rm = TRUE)
### range
range(hdv2003$heures.tv, na.rm = TRUE)
### median
median(hdv2003$heures.tv, na.rm = TRUE)
### quantile
quantile(hdv2003$heures.tv, na.rm = TRUE) # définit par défaut
quantile(hdv2003$heures.tv, probs = c(.2, .4, .6, .8), na.rm = TRUE) # définit manuellement
### summary
summary(hdv2003$heures.tv)

## variable catégorielle (calcul d'un tri à plat)
trave <- table(hdv2003$trav.imp)
trave_2 <- xtabs(~ trav.imp, data = hdv2003) #même chose que table
trave_prop <- prop.table(trave)
freq(hdv2003$trav.imp, total = TRUE)

## intervalles de confiance
add_ci(tbl_summary(hdv2003, 
                   include = c(age, heures.tv),
                   statistic = age ~ "{mean} ({sd})"),
       method = heures.tv ~ "wilcox.test")

### personnification de la présentation de l'intervalle de confiance
add_ci(tbl_summary(hdv2003,                            
                   include = c(age, heures.tv),
                   statistic = ~ "{mean}"),
       statistic = ~ "entre {conf.low} et {conf.high}",
       conf.level = .9,
       style_fun = ~ partial(style_number, digits = 1))

### Calcul de l'intervalle de confiance d'une moyenne
t.test(hdv2003$age)
str(t.test(hdv2003$age))

### Calcul de l'intervalle de confiance d'une médiane
wilcox.test(hdv2003$age, conf.int = TRUE)
