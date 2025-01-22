# library
library(stringr)

textes = c("Je suis Ranujan", "Je suis un Data Scientist", "Le foot c'est la vie", "je mange du poulet")

## Output : TRUE TRUE FALSE TRUE
## ignore_case implique de ne pas différencié les majuscules et minuscules
str_detect(textes, regex("Je", ignore_case = TRUE))
## Output : TRUE TRUE TRUE FALSE
str_detect(textes, "Je|vie")
## Output : TRUE TRUE FALSE FALSE
str_detect(textes, "^Je")
## Output : FALSE FALSE FALSE TRUE
str_detect(textes, "poulet$")

## Output : FALSE TRUE FALSE
str_detect(c("Politesse", "Poulet", "Praline"), "Po[lu]l")
## Output : TRUE TRUE
str_detect(c("Textes", "Tableau"), "[e]")

## Output : FALSE FALSE TRUE FALSE
str_detect(c("*$!", "OK", "Ok coco 13", "13"), "[aeiou]")
## Output : FALSE FALSE TRUE TRUE
str_detect(c("*$!", "OK", "Ok coco 13", "13"), "[0-9]")
## Output : FALSE TRUE TRUE FALSE
str_detect(c("*$!", "OK", "Ok coco 13", "13"), "[A-Z]")
## Output : FALSE TRUE TRUE FALSE TRUE
str_detect(c("*$!", "OK", "Ok coco 13", "13", "Data Science"), "[A-Za-z]")
## Output : FALSE TRUE TRUE TRUE TRUE
str_detect(c("*$!", "OK", "Ok coco 13", "13", "Data Science"), "[A-Za-z0-9]")
## Output : TRUE FALSE TRUE FALSE
str_detect(c("*$!", "OK", "Ok coco 13", "13"), "[^A-Za-z0-9]")

## Output : TRUE TRUE FALSE
str_detect(c("[toto] de", "[ mais non", "911"), "[\\[\\]]")
## Output : FALSE TRUE TRUE
str_detect(c("[toto] de", "[ mais-non", "911a"), "[-a]")



