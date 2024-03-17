# import libraries
import math

# Exercise : implement formula
def area_cone(r,h):
    return (1/3)*(r**2)*h*math.pi

print(area_cone(2,5))

# Exercise : TTC
tva = 20 # Fix TVA value

prix_tth = input("Entrez le prix HT :") # Ask user to give the price

while prix_tth != "ok":
    prix_tth = float(prix_tth)
    prix_ttc = prix_tth*(1+(tva/100))
    print("Le prix TTC est :", prix_ttc)
    prix_tth = input("Entrez le prix HT (entrez 'ok' pour terminer) : ")

# Exercice : suite
suite = input("Entrez une suite:")
total_value = 0
while suite != "ok":
    suite_str = str(suite)
    suite_list = [int(num) for num in suite_str]
    n = len(suite)
    total_value +=n
    suite = input("Entrez une suite:")
print(f"Total value : {total_value}")

# Exercise : parity
def parity(n):
    if n % 2 == 0:
        return "Nombre pair"
    else:
        return "Nombre impair"

print(parity(567439)) # test 1
print(parity(5674)) # test 2

# Exercise : divisible
def divisible(n):
    liste_diviseur = []
    for k in range(2,n):
        if n % k == 0:
            liste_diviseur.append(k)
    if len(liste_diviseur) != 0:
        print(f"Diviseurs propres sans répétition de {n} : {liste_diviseur}")
    else:
        print(f"Diviseurs propres sans répétition de {n} : aucun ! Il est premier")

print(divisible(456)) # test 1
print(divisible(13)) # test 2