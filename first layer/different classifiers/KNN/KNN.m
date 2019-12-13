function parameter=KNN()
X1=importdata('all.mat');
X2=importdata('all_2mer.mat');
data=[X1,X2];
save('all_2+3mer.mat','data');
num=size(data,1);
label=[ones(num/2,1);zeros(num/2,1)];
save('label.mat','label');
K=11;   % 两个类，K取奇数才能够区分测试数据属于那个类 近邻数量可变
%% 5-fold
% 输入五折分包系数
load('indices.mat');
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
    P=knn_whole(K,train_data,train_label,test_data);
    [Sn_i,Sp_i,MCC_i,Acc_i]=perf(P,test_label);
    Acc(1,i)=Acc_i;
    Sn(1,i)=Sn_i;
    Sp(1,i)=Sp_i;
    MCC(1,i)=MCC_i;
    
end
Acc=sum(Acc)/5;
MCC=sum(MCC)/5;
Sn=sum(Sn)/5;
Sp=sum(Sp)/5;
parameter=[Sn,Sp,Acc,MCC];
end


