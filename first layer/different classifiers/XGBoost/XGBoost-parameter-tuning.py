##XGBoost分类调参https://blog.csdn.net/sinat_35512245/article/details/79700029
import xgboost as xgb
from matplotlib import pyplot as plt
from sklearn.model_selection import GridSearchCV
import scipy.io as scio
import numpy as np
import pandas as pd

# read in the data
datafile = pd.read_excel('all_2+3.xlsx',header=None)
X = datafile.values
print(X.shape)
labelfile = pd.read_excel('label.xlsx',header=None)
y = labelfile.values
print(y.shape)
indicesfile = pd.read_excel('indices.xlsx',header=None)
indices = indicesfile.values
print(indices.shape)

X_train = [];
X_test = [];
y_train = [];
y_test = [];
for i in range(len(indices)):
    if indices[i] == 1:
        y_test.append(y[i])
        X_test.append(X[i])
    if indices[i] != 1:
        y_train.append(y[i])
        X_train.append(X[i])
X_train = np.array(X_train);
X_test = np.array(X_test)
y_train = np.array(y_train);
y_test = np.array(y_test)

# model
##{'n_estimators': [100,200,300,400,500,600,700,800,900]}
##{'max_depth': [1,2,3,4,5,6,7,8,9,10],'min_child_weight': [1,2,3,4,5,6,7,8,9,10]}
##{'gamma': [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]}
##{'subsample': [0.6, 0.7, 0.8, 0.9], 'colsample_bytree': [0.6, 0.7, 0.8, 0.9]}
##{'reg_alpha': [0.05, 0.1,0.5, 1, 2, 3], 'reg_lambda': [0.05, 0.1,0.5, 1, 2, 3]}
##'learning_rate': [0.01,0.05,0.07,0.1,0.2,0.5,1]

if __name__ == '__main__':
    cv_params ={'n_estimators': range(500,1501,10)}
    # cv_params = {'max_depth': [1,2,3,4,5,6,7,8,9,10],'min_child_weight': range(5,20,1)}
    # cv_params ={'gamma': [0.01, 0.03, 0.06, 0.08, 0.1, 0.2, 0.4, 0.8, 0.9, 1.0]}
    # cv_params ={'subsample': [0.05, 0.1, 0.2, 0.4], 'colsample_bytree': [0.2, 0.4, 0.6, 0.8]}
    # cv_params ={'reg_alpha': [0.005, 0.01,0.05, 0.1, 0.2, 0.3], 'reg_lambda': [0.0001, 0.0003,0.001, 0.003, 0.01, 0.03]}
    # cv_params = {'learning_rate': [0.0001, 0.0004, 0.0008, 0.001, 0.0014]}
    other_params = {'learning_rate': 0.0008, 'n_estimators': 1480, 'max_depth': 7,
                    'min_child_weight': 5,'seed': 0, 'subsample': 0.4,
                    'colsample_bytree': 0.2, 'gamma': 0.01,'reg_alpha': 0.05, 'reg_lambda': 0.0001}

    model = xgb.XGBClassifier(**other_params)
    optimized_GBM = GridSearchCV(estimator=model, param_grid=cv_params, scoring='accuracy', cv=5, verbose=1, n_jobs=4)
    optimized_GBM.fit(X_train, y_train)
    evalute_result = optimized_GBM.cv_results_

    print('每轮迭代运行结果:{0}'.format(evalute_result))
    print('参数的最佳取值：{0}'.format(optimized_GBM.best_params_))
    print('最佳模型得分:{0}'.format(optimized_GBM.best_score_))
