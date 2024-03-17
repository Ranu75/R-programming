# Exercise 1 : cosinus function, count the number of character

## Cosinus function
cosinus <- function(x){
  return(cos(x))
}

## Print the result of cosinus 75, 25 et 90
print(cosinus(75))
print(cosinus(25))
print(cosinus(90))

## Count the number of character
sentence <- "un bon bioinformaticien ne peut pas travailler sans connaitre le
            langage R"

cat(toupper(sentence)) # Print in capital letter

count_character <- nchar(sentence) # Count the number of character

print(count_character)

# Exercise 2 : find the decimal value
round(4850/26,3) # return the decimal of 4850/26 with 3 decimal
                 # 186.538

# Exercise 3 : π
print(pi) # print the value π
print(round(pi,3)) 
print(round(pi,5))
pi <- 9 # assign 9 to pi
print(pi) # pi is now 9 not π
pi <- 20 # assign 20 to pi
print(pi) # pi is now 20 not 9

# Exercise 4 : vector
## Natural number
vec <- c(1:12) # vector with the entire number 1 to 12
print(vec)
vec <- c(vec,16,17,18)
print(vec)

## Sequence
vec2 <- seq(from=0, to=5, by=0.5) 
vec3 <- c(1:25)*2 # vector with all pair number between 1 and 50
vec4 <- rep(0:9, each=3)
vec5 <- sapply(c(1:26), function(i) rep(LETTERS[i],i))
length(vec5)
vec6 <- sapply(c(1:100), function(i) paste("individu",i))
vec6bis <- paste0("individu",1:100)

## Matrix
matIdentite <- diag(10) # matrice identité d'ordre 10
matAleatoire <- matrix(rnorm(100,0,5), nrow = 10, ncol = 10)

## Date
Today <- Sys.Date()
m1 <- 3
m2 <- "promotions assistent au cours de R du"
paste(m1,m2,Today)

## Vector
vecX <- c(1:20) # vector contains 1,2,...,20
five_first_elements_vecX <- vecX[1:5] # five first elements
print(five_first_elements_vecX^2) # squared
sum(vecX) # sum of all elements of vector vecX
sinusX <- sapply(vecX, function(x) sin(x)) # transform each value by sinus function

neg_index <- function(l){ # function returns the index of negative value
  n <- length(l)
  neg <- vector("numeric")
  for (i in 1:n){
    if (l[i] < 0){
      neg <- c(neg,i)
    }
  }
  return(neg)
}

neg_vecX_index <- neg_index(sinusX) # the index of the negative elements
length(neg_vecX_index) # number of negative value

neg_to_zero <- function(l){ # function replaces negative value by 0
  n <- length(l)
  for (i in 1:n){
    if (l[i] < 0){
      l[i] = 0
    }
  }
  return(l)
}

new_sinusX <- neg_to_zero(sinusX) # create new vector with 0 instead of negative value

## Create vectors xEven and xOdd
xEven <- sinusX[seq(2, length(sinusX), by = 2)] # index even
xOdd <- sinusX[seq(1, length(sinusX), by = 2)] # index odd
matCombine <- cbind(xEven, xOdd)

## Random variable 
x1 <- rnorm(100, 0, 1)
x2 <- runif(100, 0, 10)

matrice1 <- cbind(x1[1:10],x2[91:100])
matrice2 <- cbind(c(x1[16], x1[51], x1[79], x1[31], x1[27]), c(x2[30], x2[70], x2[12], x2[49], x2[45]))
m12 <- rbind(matrice1, matrice2)
dim(m12) # 15 rows et 2 columns

# Exercise 4 : data
data(precip)
str(precip)
head(precip)
summary(precip)
precip$city

