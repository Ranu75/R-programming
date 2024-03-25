import numpy as np

def matrice_nan(mat):
    '''
    This function impute missing value by the mean or the median of each column
    
    Attributs
    ---------
    mat : matrice de tailles quelconques avec NA ou non
        array
        
    Return
    ------
    mat : matrice de tailles quelconques imputés
        array
    '''
    moyenne = np.nanmean(mat, axis=0) # mean of each column
    mediane = np.nanmedian(mat, axis=0) # median of each column
    
    for i in range(mat.shape[1]):
        nan = np.isnan(mat[:,i])
        if np.any(nan):
            if moyenne[i] > mediane[i]:
                mat[nan,i] = moyenne[i] # missing value is the mean of the column
            else:
                mat[nan,i] = mediane[i] # missing value is the median of the column
    
    return mat # return the matrice without missing value

matrice = np.array([[1,2,np.nan], [np.nan, 6,7], [5, np.nan, 9]])
print(matrice_nan(matrice))