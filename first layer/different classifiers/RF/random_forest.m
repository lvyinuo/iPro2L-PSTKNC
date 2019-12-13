function parameter=random_forest(data,datap,datan)
M=size(data,1); %dataΪ��������
N=70; %��������,�ɵ�
label=[ones(size(datap,1),1);zeros(size(datan,1),1)]; %��ǩ
%% 5-fold
indices = crossvalind('Kfold',label,5); %5Ϊ������֤����
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
    P=rf(N,m,M,train_data,train_label,test_data);  
    classperf(cp,P,test);
end
[Sn,Sp,Acc,MCC]=perf( cp );
parameter=[Sn,Sp,Acc,MCC];
end
