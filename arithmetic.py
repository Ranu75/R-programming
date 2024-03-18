import random

# Exercise : arithmetic
def product_list(L): 
    lon = len(L)
    if lon in [0,1,2]:
        return False
    for i in range(lon):
        for j in range(i+1, lon):
            for k in range(j+1, lon):
                if L[i]*L[j]*L[k] == 30:
                    return True
    return False

print(product_list([1,2,3,4,5,5,6,7,3,10,3,5]))

def product_tab(T):
    nb_row = len(T)
    nb_col = len(T[0])
    if len(T) == 0:
        return False
    for i in range(nb_col):
        for j in range(nb_row):
            for k in range(j+1, nb_row):
                for l in range(k+1, nb_row):
                    if T[i][j]*T[i][k]*T[i][l] == 30:
                        return True
    return False

# Define the size of the list 
size_list = 10
plage_entiers = (1, 100)  # Natural number between 1 and 100

# Generate random value
liste_aleatoire = [random.randint(plage_entiers[0], plage_entiers[1]) for _ in range(size_list)]
print(product_tab(liste_aleatoire))