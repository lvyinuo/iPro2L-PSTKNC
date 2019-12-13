function parameter=KNN()
X1=importdata('all.mat');
X2=importdata('all_2mer.mat');
data=[X1,X2];
save('all_2+3mer.mat','data');
num=size(data,1);
label=[ones(num/2,1);zeros(num/2,1)];
save('label.mat','label');
K=11;   % �����࣬Kȡ�������ܹ����ֲ������������Ǹ��� ���������ɱ�
%% 5-fold
% �������۷ְ�ϵ��
load('indices.mat');
cp = classperf(label);
for i = 1:5
    %   ��ȡ���
    test = (indices == i);  %���test��Ԫ�������ݼ��ж�Ӧ�ĵ�Ԫ���
    train = ~test;  %train��Ԫ�صı��Ϊ��testԪ�صı��
    %   ���ݼ�
    train_data=data(train,:);   %�����ݼ��л��ֳ�train����������
    train_label=label(train,:);   %����������Ĳ���Ŀ�꣬�ڱ�������ʵ�ʷ������
    m=size(train_data,1);
    %   ���Լ�
    test_data=data(test,:); %test������
    test_label=label(test,:);
    %   Ԥ��
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


