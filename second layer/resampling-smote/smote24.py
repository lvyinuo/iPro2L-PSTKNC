import numpy as np
import pandas as pd
import xlrd
import xlwt
from imblearn.over_sampling import SMOTE

file = pd.read_excel('s500_23mer_24_p.xlsx')  #1743,sigma70为500
data = file.values
print(data)
d24y = np.ones((489, 1))  #标签
d28y = np.ones((137, 1))*2
d32y = np.ones((295, 1))*3
d38y = np.ones((226, 1))*4
d54y = np.ones((96, 1))*5
d70y = np.ones((500, 1))*6
datay = np.vstack((d24y, d28y, d32y, d38y, d54y, d70y))
print(data.shape)
print(datay.shape)

# Resample the minority class. You can change the strategy to 'auto' if you are not sure.
sm = SMOTE()

# Fit the model to generate the data.
data_resampled, datay_resampled = sm.fit_sample(data, datay)
np.savetxt('smote_23mer_24.csv', data_resampled, delimiter = ",")
np.savetxt('smote_23mer_24y.csv', datay_resampled, delimiter = ",")

