function parameter=random_forest(data,datap,datan)
M=size(data,1); %data为特征矩阵
N=70; %树的数量,可调
label=[ones(size(datap,1),1);zeros(size(datan,1),1)]; %标签
%% 5-fold
indices = crossvalind('Kfold',label,5); %5为交叉验证折数
cp = classperf(label);
for i = 1:5
%   获取编号
    test = (indices == i);  %获得test集元素在数据集中对应的单元编号
    train = ~test;  %train集元素的编号为非test元素的编号
%   数据集
    train_data=data(train,:);   %从数据集中划分出train样本的数据
    train_label=label(train,:);   %获得样本集的测试目标，在本例中是实际分类情况
    m=size(train_data,1);
%   测试集
    test_data=data(test,:); %test样本集
    test_label=label(test,:);
%   预测
    P=rf(N,m,M,train_data,train_label,test_data);  
    classperf(cp,P,test);
end
[Sn,Sp,Acc,MCC]=perf( cp );
parameter=[Sn,Sp,Acc,MCC];
end
