##https://blog.csdn.net/juzexia/article/details/77743812
import pandas as pd
import numpy as np
from sklearn.ensemble import GradientBoostingClassifier
from sklearn.model_selection import GridSearchCV
import matplotlib.pylab as plt
import scipy.io as scio

datafile = pd.read_excel('all_2+3.xlsx',header=None)
X = datafile.values
print(X.shape)
labelfile = pd.read_excel('label.xlsx',header=None)
y = labelfile.values
print(y.shape)
indicesfile = pd.read_excel('indices.xlsx',header=None)
indices = indicesfile.values
print(indices.shape)

X_train=[];X_test=[];y_train=[];y_test=[];
# 五折
for i in range(len(indices)):
    if indices[i]==1:
        y_test.append(y[i])
        X_test.append(X[i])
    if indices[i]!=1:
        y_train.append(y[i])
        X_train.append(X[i])
X_train=np.array(X_train);  X_test=np.array(X_test)
y_train=np.array(y_train);  y_test=np.array(y_test)

##{'n_estimators':range(100,1001,100)}
##{'max_depth':range(1,15,2),'min_samples_split':range(100,801,200)}
##{'min_samples_leaf':range(10,101,10), 'subsample':[0.6,0.7,0.8,0.9]}
##{'learning_rate': [0.01,0.05, 0.1,0.2,0.5,1]}

param_test = {'n_estimators': range(10,401,20)}
# param_test = {'max_depth':range(1,15,2),'min_samples_split':range(100,801,200)}
# param_test = {'min_samples_leaf':range(10,101,10), 'subsample':[0.6,0.7,0.8,0.9]}
# param_test = {'learning_rate': [0.01,0.05, 0.1,0.2,0.5,1]}
gsearch = GridSearchCV(estimator = GradientBoostingClassifier(learning_rate=0.1, n_estimators=90,
                max_depth=9,min_samples_split =100,min_samples_leaf =10, subsample=0.7),
               param_grid = param_test, scoring='accuracy',iid=False, cv=5)
gsearch.fit(X,y)
    
print('每轮迭代运行结果:{0}'.format(gsearch.cv_results_))
print('参数的最佳取值：{0}'.format(gsearch.best_params_))
print('最佳模型得分:{0}'.format(gsearch.best_score_))

