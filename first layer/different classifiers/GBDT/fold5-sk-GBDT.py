##基于Scikit-learn接口的GBDT分类
import scipy.io as scio
from matplotlib import pyplot as plt
from sklearn.ensemble import GradientBoostingClassifier
import numpy as np
import pandas as pd
from sklearn.externals import joblib

datafile = pd.read_excel('all_2+3.xlsx',header=None)
X = datafile.values
print(X.shape)
labelfile = pd.read_excel('label.xlsx',header=None)
y = labelfile.values
print(y.shape)
indicesfile = pd.read_excel('indices.xlsx',header=None)
indices = indicesfile.values
print(indices.shape)

Sn=[];Sp=[];Acc=[];MCC=[];

for k in range(1,6):
    # 五折
    X_train=[];X_test=[];y_train=[];y_test=[];
    for i in range(len(indices)):
        if indices[i]==1:
            y_test.append(y[i])
            X_test.append(X[i])
        if indices[i]!=1:
            y_train.append(y[i])
            X_train.append(X[i])
    X_train=np.array(X_train);  X_test=np.array(X_test)
    y_train=np.array(y_train);  y_test=np.array(y_test)
    # 训练模型
    gb = GradientBoostingClassifier(learning_rate=0.1, n_estimators=90,
                max_depth=9,min_samples_split =100,min_samples_leaf =10, subsample=0.7)
    
    gb.fit(X_train,y_train)
    ans = gb.predict(X_test)
    joblib.dump(gb,'GBDT-pstnp.model')

    # 评价
    TP=0;FN=0;FP=0;TN=0
    for i in range(len(y_test)):
        if ans[i]==1 and y_test[i]==1:
            TP+=1
        if ans[i]==0 and y_test[i]==1:
            FN+=1
        if ans[i]==1 and y_test[i]==0:
            FP+=1
        if ans[i]==0 and y_test[i]==0:
            TN+=1
    Sn.append(TP/(TP+FN))
    Sp.append(TN/(TN+FP))
    Acc.append((TP+TN)/(TP+TN+FP+FN))
    MCC.append((TP*TN-FP*FN)/(((TP+FP)*(TP+FN)*(TN+FP)*(TN+FN)))**0.5)
    
total=np.row_stack((Sn,Sp,Acc,MCC))
print(total.mean(axis=1))
