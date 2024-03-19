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