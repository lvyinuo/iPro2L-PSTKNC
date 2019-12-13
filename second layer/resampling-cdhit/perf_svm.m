%% 求其他参数
function [Sn,Sp,MCC,Acc]=perf_svm(pre_label,label)
length=size(label,1);
TP=0;
FP=0;
TN=0;
FN=0;
for i=1:length
    if(label(i)==1)
        if(pre_label(i)==1)
            TP=TP+1;
        else
            FN=FN+1;
        end
        
    else if(label(i)==0)
            if(pre_label(i)==0)
                TN=TN+1;
            else
                FP=FP+1;
            end
        end
    end
end
P=TP+FN;
N=TN+FP;
Acc=(TP+TN)/(N+P);
Sn=TP/P;
Sp=TN/N;
MCC=(TP*TN-FP*FN)/sqrt((TP+FP)*(TP+FN)*(TN+FP)*(TN+FN));
end