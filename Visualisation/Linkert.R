# installer un package
install.packages('remotes')
install.packages("ggstats")
remotes::install_github("MSKCC-Epi-Bio/bstfun")

# charger les packages
library(tidyverse)
library(labelled)
library(gtsummary)
library(bstfun)
library(ggstats)

# Implanter les graines
set.seed(42)

# Création de la variable à utiliser pour l'échelle de Linkert
niveaux <- c(
  "Pas du tout d'accord",
  "Plutôt pas d'accord",
  "Ni d'accord, ni pas d'accord",
  "Plutôt d'accord",
  "Tout à fait d'accord"
)

# Création d'un dataframe labelisé
df <- tibble(
  groupe = sample(c("A", "B"), 150, replace = TRUE),
  q1 = sample(niveaux, 150, replace = TRUE),
  q2 = sample(niveaux, 150, replace = TRUE, prob = 1:5),
  q3 = sample(niveaux, 150, replace = TRUE, prob = 1:5),
  q4 = sample(niveaux, 150, replace = TRUE, prob = 1:5),
  q5 = sample(c(niveaux, NA), 150, replace = TRUE),
  q6 = sample(niveaux, 150, replace = TRUE, prob = c(1, 0, 1, 0, 0))
)

df <- mutate(df, across(q1:q6, ~ factor(.x, levels = niveaux)))

df_labelled <- set_variable_labels(df,
                                    q1 = "Première question",
                                    q2 = "Seconde question",
                                    q3 = "Troisième question",
                                    q4 = "Quatrième question",
                                    q5 = "Cinquième question",
                                    q6 = "Sixième question"
                                    )

# Analyse du dataframe
## Résumé statistiques
tbl_summary(df_labelled, include = q1:q6)
## Tableau Linkert
tbl_likert(
    df_labelled,
    include = q1:q6
  )
## Tableau Linkert + effectif totaux
tbl_likert <- tbl_likert(
  df_labelled,
  include = q1:q6,
  statistic = ~ "{p}%"
)

add_continuous_stat(add_n(tbl_likert), 
  score_values = -2:2)

## Création d'un graphique : un diagramme en barre centré sur la modalité centrale
gglikert(df_labelled, include = q1:q6, sort = "ascending")+
  guides(fill = guide_legend(nrow = 2))
### Création des sous-groupes
gglikert(
    df_labelled,
    include = q1:q6,
    facet_cols = vars(groupe)
  )+
  guides(fill = guide_legend(nrow = 2)) # selon les groupes d'individus

gglikert(
    df_labelled,
    include = q1:q6,
    y = "groupe",
    facet_rows = vars(.question),
    facet_label_wrap = 15
  )+
  guides(fill = guide_legend(nrow = 2)) # selon les questions






