# library
library(stringr)

## Detection
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

## Output : FALSE FALSE TRUE TRUE
str_detect(c("-!", "Cocorico", "Cocorico 75-0-1", "75-0-10"), "[[:digit:]]")
## Output : TRUE TRUE TRUE FALSE
str_detect(c("-!", "Cocorico", "Cocorico 75-0-1", "75010"), "[^[:digit:]]")
## Output : FALSE TRUE TRUE TRUE
str_detect(c("-!", "Cocorico", "Cocorico 75-0-1", "75010"), "[[:alnum:]]")
## Output : FALSE TRUE TRUE TRUE
str_detect(c("-!", "Cocorico", "Cocorico 75-0-1", "75010"), "[^[:punct:]]")
## Output : TRUE TRUE TRUE TRUE
str_detect(c("-!", "Cocorico", "Cocorico 75-0-1", "75010"), "[^[:blank:]]")


textes2 = c("Toto écrit un livre", "Toto un livre")
## Output : TRUE TRUE
str_detect(textes2, "Toto (écrit )?un livre")

textes3 = c("Oulala Sonia", "Oula oula Sonia", "Sonia", "Catherine")
## Output : TRUE TRUE FALSE FALSE
str_detect(textes3, "(Oula)* Sonia")

textes4 = c("Bonjour Lola", "ah Lola", "ahah Lola")
## Output : FALSE TRUE TRUE 
str_detect(textes4, "(ah)+ Lola")


## Extraction
adresses = c("ranu.data@gmail.com",
              "mega.science@yahoo.fr",
              "vijaytv.net")
motif = "^[[:alnum:].-]+@[[:alnum:].-]+$"
str_extract(adresses, motif) #The first two elements were output
adresses2 = c("ranu.data@gmail.com",
             "mega.science@yahoo.fr minim.physics@outlook.com",
             "vijaytv.net")
str_extract_all(adresses2, c("[[:alnum:].-]+@[[:alpha:]]{1,}"))


## Localisation
color = c("purple",
             "red",
            "blue",
          "darkgreen",
          "orange")
str_locate(color, "e")
str_locate(color, c("p", "o", "b", "a", "o"))
str_locate_all(color, "e")
str_locate_all(color, c("p", "o", "b", "a", "o"))


## Replacement
telephones = c("02/23/23/35/45", 
                "02.23.23.35.45", 
                "02 23 23 35 45")

str_replace(telephones, "[/ \\.]", "_")
str_replace_all(telephones, "[/ \\.]", "_")


## Split
textes_split = c("manger du poulet tika massala",
                 "considèrons l'humain comme un être sensible",
                 "exceptionnelle",
                 "Robert")

str_split(textes_split, " ", n = 5)






