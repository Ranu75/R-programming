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
