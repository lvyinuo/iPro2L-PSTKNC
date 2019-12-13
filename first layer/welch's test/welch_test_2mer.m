function welch_test_2mer
data=read_data('all.txt');
datap=data(1:2633,:);     %正样本(改)
datan=data(2634:5266,:);    %负样本(改)
np=[];
nn=[];
for i=1:2633
    sp=char(datap(i,1));  %序列
    fp=zeros(1,16);
    fn=zeros(1,16);
    for j=1:80
        dip=sp(j:j+1);  %2mer
        tp=sw_2mer(dip);  %行数
        fp(1,tp)=fp(1,tp)+1;
    end
    np=[np;fp];
end
for i=1:2633
    sn=char(datan(i,1));  %序列
    fp=zeros(1,16);
    fn=zeros(1,16);
    for j=1:80
        din=sn(j:j+1);  %2mer
        tn=sw_2mer(din);  %行数
        fn(1,tn)=fn(1,tn)+1;
    end
    nn=[nn;fn];
end
pvalue=[];
for i=1:16
    [h,pvalue_i]=ttest2(np(:,i),nn(:,i),'Alpha',0.01,'Vartype','unequal');
    pvalue=[pvalue;pvalue_i];
end
avep=zeros(16,1);
aven=zeros(16,1);
for i=1:16
    avep(i,1)=sum(np(:,i))/210640;
end
for i=1:16
    aven(i,1)=sum(nn(:,i))/210640;
end
ave=[avep,aven];
xl=1:1:16;
[AX,Bar,Line]=plotyy(xl,ave,xl,pvalue,'bar','plot');
set(Line,'Marker','o');
xlim([0,17]);
ylim(AX(1),[0,0.15]);
ylim(AX(2),[0,0.6]);
set(AX,'xtick',[1:1:16]);
set(AX(1),'ytick',[0:0.05:0.15]);
set(AX(2),'ytick',[0:0.1:0.6]);
xlabel('di-nucleotides');
ylabel(AX(1),'composition');
ylabel(AX(2),'p-value');
set(AX,'XTickLabel',{'AA','AC','AG','AT','CA','CC','CG','CT','GA','GC','GG','GT','TA','TC','TG','TT'});
legend('positive','negative','p-value');
end