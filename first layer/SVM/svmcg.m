%% svmcg����
function [bestc, bestAcc, bestMCC, bestSn, bestSp] = svmcg(data,datap,datan,cstep,cmin,cmax,c0,acc0)
% ���ɱ�ǩ
label=[ones(size(datap,1),1);zeros(size(datan,1),1)];
% ��������
[X,Y] = meshgrid(cmin:cstep:cmax);
[m,n] = size(X);
% ��ʼֵ,���ڱȽ�
bestc = c0;
bestAcc = acc0;
basenum = 2;
bestSn=0;
bestSp=0;
bestMCC=0;
% �������۷ְ�ϵ��
indices=create_indices(); 
for x = 1:m
    cmd = [' -t ', num2str(0),' -c ',num2str( basenum^X(1,x))];
    for i = 1:5
        %   ��ȡ���
        test = (indices == i);  %���test��Ԫ�������ݼ��ж�Ӧ�ĵ�Ԫ���
        train = ~test;  %train��Ԫ�صı��Ϊ��testԪ�صı��
        %   ���ݼ�
        train_data=data(train,:);   %�����ݼ��л��ֳ�train����������
        train_label=label(train,:);   %����������Ĳ���Ŀ�꣬�ڱ�������ʵ�ʷ������
        %   ���Լ�
        test_data=data(test,:); %test������
        test_label=label(test,:);
        %   Ԥ��
        model = svmtrain( train_label, train_data, cmd );
%         [predict_label, accuracy, dec_values] = svmpredict(test_label, test_data,model);
        [predict_label] = svmpredict(test_label, test_data,model);
        [Sn_i,Sp_i,MCC_i,Acc_i]=perf_svm(predict_label,test_label);
        Acc(1,i)=Acc_i;
        Sn(1,i)=Sn_i;
        Sp(1,i)=Sp_i;
        MCC(1,i)=MCC_i;
        %[A,B,THRE,AUC] = perfcurve(test_label,dec_values(:,1),'1');
        %auc(1,i)=AUC;
    end
    tem_Acc=sum(Acc)/5;
    tem_Sn=sum(Sn)/5;
    tem_Sp=sum(Sp)/5;
    tem_MCC=sum(MCC)/5;
    if tem_Acc > bestAcc
        bestAcc = tem_Acc;
        bestSn=tem_Sn;
        bestSp=tem_Sp;
        bestMCC=tem_MCC;
        bestc = basenum^X(x,1);
    end
    if ( tem_Acc == bestAcc && bestc > basenum^X(x,1) )
        bestAcc = tem_Acc;
        bestSn=tem_Sn;
        bestSp=tem_SP;
        bestMCC=tem_MCC;
        bestc = basenum^X(x,1);
    end
    
end