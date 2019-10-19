#!/usr/bin/env python
# coding: utf-8

# In[39]:


import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

# Importing the dataset
dataset = pd.read_csv('C:/Users/Hitesh Kumar/Videos/iris.csv')
X = dataset.iloc[:, :-1].values
y = dataset.iloc[:, 4].values
#print(X)

from sklearn.preprocessing import LabelEncoder, OneHotEncoder

labelencoder_y = LabelEncoder()
y = labelencoder_y.fit_transform(y)

#print(y)


from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.2, random_state = 0)

#print(X_train)
from sklearn.linear_model import LinearRegression
regressor = LinearRegression()
regressor.fit(X_train, y_train)

# Predicting the Test set results
y_pred = regressor.predict(X_test)

#print(y_pred)
#print(y_train)
print("Mean squared error: %.2f" % np.mean((regressor.predict(X_test) - y_test) ** 2))

print('Variance score: %.2f' % regressor.score(X_test, y_test))




# In[38]:


import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from scipy.linalg import svd
from sklearn import decomposition
from sklearn import datasets


# Importing the dataset
dataset = pd.read_csv('C:/Users/Hitesh Kumar/Videos/iris.csv')
k = dataset.iloc[:, :-1].values
y = dataset.iloc[:, 4].values
#print(X)
pca = decomposition.PCA(n_components=1)
pca.fit(k)
X = pca.transform(k)
#print(X)


from sklearn.preprocessing import LabelEncoder, OneHotEncoder

labelencoder_y = LabelEncoder()
y = labelencoder_y.fit_transform(y)

#print(y)


from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.2, random_state = 0)

#print(X_train)
from sklearn.linear_model import LinearRegression
regressor = LinearRegression()
regressor.fit(X_train, y_train)

# Predicting the Test set results
y_pred = regressor.predict(X_test)



print("Mean squared error: %.2f" % np.mean((regressor.predict(X_test) - y_test) ** 2))

print('Variance score: %.2f' % regressor.score(X_test, y_test))



# In[ ]:




