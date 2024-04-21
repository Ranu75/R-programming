# facteurs

## Déterminer les facteurs
x <- c("north", "south", "south", "east", "east", "east")
f <- factor(x)

## Ordonner les niveaux
factor(x, levels = c("north", "south"))

### Message de "warning"
readr::parse_factor(x, levels = c("north", "south"))

## Accès à la liste des étiquettes avec levels()
levels(f)

## Ordonner les niveaux de manière hiérarchique
scolaire <- c("supérieur", "primaire", "secondaire", "primaire", "supérieur")
ordered(scolaire, levels = c("primaire", "secondaire", "supérieur"))

## Comment sont ordonnées les listes ?
class(f) # classe de f
typeof(f)
as.integer(f) # valeur des éléments suivant leur ordre dans l'attribut levels
as.character(f)