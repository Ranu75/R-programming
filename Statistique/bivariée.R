# Initier les paramètres en "fr"
theme_gtsummary_language("fr")

# charger les packages
library(gtsummary)
library(questionr)
library(ggplot2)
library(scales)

# charger les données
data("trial")

# trie croisée
tbl_summary(trial, include = stage, by = grade)

add_overall(tbl_summary(trial,                         # données sur les pourcentages
                        include = c(stage, trt),
                        by = grade,
                        statistic = ~ "{p}% ({n}/{N})",
                        percent = "row"),
            last = TRUE)

tbl_cross(trial,
          row = stage,
          col = grade,
          percent = "row")

# répresentations graphiques 
ggplot(trial) +
  aes(x = stage, fill = grade) + 
  geom_bar() +
  labs(x = "T stage", fill = "Grade", y = "Effectifs")

ggplot(trial) +                                       # autres manières
  aes(x = stage, fill = grade) + 
  geom_bar(position = "dodge") +
  labs(x = "T stage", fill = "Grade", y = "Effectifs")

# test de corrélation

## test du chi-deux
tab <- xtabs(~ stage + grade, data = trial)
chisq.test(tab)

add_p(tbl_summary(trial, include = stage, by = grade))

## test de fisher
fisher.test(tab)

add_p(tbl_summary(trial, include = stage, by = grade), test = all_categorical() ~ "fisher.test")


