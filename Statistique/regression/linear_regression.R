# charger les packages
library(tidyverse)
library(gtsummary)
library(ggstats)

# charger les données
data("mtcars")

# Résumé des données
str(mtcars)
head(mtcars)
summary(mtcars$mpg)

# visualisation graphique
ggplot(mtcars) +
  aes(x = wt, y = mpg) +
  geom_point(colour = "blue", alpha = .25) +
  geom_smooth(method = "lm") +
  labs(x = "Poids de la voiture", y = "Consommation du carburant") +
  theme_light()

# régression linéaire 
mod <- lm(mpg ~ wt, data = mtcars)

ggplot(mtcars) +
  aes(x = wt, y = mpg) +
  geom_point(colour = "blue", alpha = .25) +
  geom_abline(
    intercept = mod$coefficients[1],
    slope = mod$coefficients[2],
    linewidth = 1,
    colour = "red"
  ) +
  geom_vline(xintercept = 0, linewidth = 1, linetype = "dotted") +
  labs(x = "Poids de la voiture", y = "Consommation du carburant") +
  theme_light()

tbl_regression(mod, intercept = TRUE)

# régression linéaire avec plusieurs variables explicatives
mod2 <- lm(mpg ~ carb + gear + cyl + disp + hp + drat + qsec, data = mtcars)
tbl_regression(mod2, intercept = TRUE)

# importance des variables
ggcoef_model(mod2)







