function parameter=AdaBoost()
X=importdata('all_2+3mer.mat');  %数据集
datap=X(1:2633,:);     %正样本
datan=X(2634:5266,:);    %负样本
Y=[ones(size(datap,1),1);zeros(size(datan,1),1)]; %标签

indices=create_indices();  %p
cp = classperf(Y);
for i = 1:5
%   获取编号
    test = (indices == i);  %获得test集元素在数据集中对应的单元编号
    train = ~test;  %train集元素的编号为非test元素的编号
%   数据集
    train_data=X(train,:);   %从数据集中划分出train样本的数据
    train_label=Y(train,:);   %获得样本集的测试目标，在本例中是实际分类情况
%   测试集
    test_data=X(test,:); %test样本集
    test_label=Y(test,:);
%   预测
    Ensemble_factor=fitensemble(train_data,train_label,'AdaBoostM1',500,'Tree');
    predict_label=predict(Ensemble_factor,test_data);
    classperf(cp,predict_label,test);
end
[Sn,Sp,Acc,MCC]=perf( cp )
parameter=[Sn,Sp,Acc,MCC];
end