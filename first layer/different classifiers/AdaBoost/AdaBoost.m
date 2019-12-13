function parameter=AdaBoost()
X=importdata('all_2+3mer.mat');  %���ݼ�
datap=X(1:2633,:);     %������
datan=X(2634:5266,:);    %������
Y=[ones(size(datap,1),1);zeros(size(datan,1),1)]; %��ǩ

indices=create_indices();  %p
cp = classperf(Y);
for i = 1:5
%   ��ȡ���
    test = (indices == i);  %���test��Ԫ�������ݼ��ж�Ӧ�ĵ�Ԫ���
    train = ~test;  %train��Ԫ�صı��Ϊ��testԪ�صı��
%   ���ݼ�
    train_data=X(train,:);   %�����ݼ��л��ֳ�train����������
    train_label=Y(train,:);   %����������Ĳ���Ŀ�꣬�ڱ�������ʵ�ʷ������
%   ���Լ�
    test_data=X(test,:); %test������
    test_label=Y(test,:);
%   Ԥ��
    Ensemble_factor=fitensemble(train_data,train_label,'AdaBoostM1',500,'Tree');
    predict_label=predict(Ensemble_factor,test_data);
    classperf(cp,predict_label,test);
end
[Sn,Sp,Acc,MCC]=perf( cp )
parameter=[Sn,Sp,Acc,MCC];
end