# Exercise 1
sumcum = 0
for (i in 1:10){
  print(i)
  sumcum = sumcum + i
}

# Define the number of row and column
nb_lignes <- 10
nb_colonnes <- 10

# Generate random matrix
matAlea <- matrix(sample(1:10, nb_lignes * nb_colonnes, replace = TRUE), 
                  nrow = nb_lignes)

sum_matAlea <- sum(matAlea)
