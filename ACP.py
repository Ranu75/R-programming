import numpy as np
import random
import pandas as pd

def ACP(X:np.array):
    mean_X = np.mean(X) # mean
    X_centered = X - mean_X # centered
    cov_matrix = np.cov(X_centered, rowvar=False) # covariance matrix

    eigenvalue, eigenvector = np.linalg.eig(cov_matrix) # compute eigenvector and eigenvalue of covariance matrix
    sorted_index = np.argsort(eigenvalue)[::-1] # sort index of eigenvalue
    eigenvalue = eigenvalue[sorted_index]
    eigenvector = eigenvector[:, sorted_index]

    principal_components = np.dot(X_centered, eigenvector)

    acp_results = pd.DataFrame(principal_components, columns=['Composante' + str(i+1) for i in range(X.shape[1])])

    return acp_results, eigenvalue, eigenvector


# Définir les dimensions de la matrice
nb_lignes = 5
nb_colonnes = 5

# Générer une matrice aléatoire de dimensions 5x5 avec des valeurs entre 0 et 9
matrice_aleatoire = np.random.randint(10, size=(nb_lignes, nb_colonnes))

print(ACP(matrice_aleatoire))


