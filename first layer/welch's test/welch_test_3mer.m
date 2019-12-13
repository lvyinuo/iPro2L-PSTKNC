function welch_test_3mer
data=read_data('all.txt');
datap=data(1:2633,:);     %正样本(改)
datan=data(2634:5266,:);    %负样本(改)
np=[];
nn=[];
for i=1:2633
    sp=char(datap(i,1));  %序列
    fp=zeros(1,64);
    fn=zeros(1,64);
    for j=1:79
        dip=sp(j:j+2);  %3mer
        tp=sw_3mer(dip);  %行数
        fp(1,tp)=fp(1,tp)+1;
    end
    np=[np;fp];
end
for i=1:2633
    sn=char(datan(i,1));  %序列
    fp=zeros(1,64);
    fn=zeros(1,64);
    for j=1:79
        din=sn(j:j+2);  %2mer
        tn=sw_3mer(din);  %行数
        fn(1,tn)=fn(1,tn)+1;
    end
    nn=[nn;fn];
end
pvalue=[];
for i=1:64
    [h,pvalue_i]=ttest2(np(:,i),nn(:,i),'Alpha',0.01,'Vartype','unequal');
    pvalue=[pvalue;pvalue_i];
end
avep=zeros(64,1);
aven=zeros(64,1);
for i=1:64
    avep(i,1)=sum(np(:,i))/208007;
end
for i=1:64
    aven(i,1)=sum(nn(:,i))/208007;
end
ave=[avep,aven];

figure;  %1
xl=1:1:16;
[AX,Bar,Line]=plotyy(xl,ave(1:16,:),xl,pvalue(1:16,1),'bar','plot');
set(Line,'Marker','o');
xlim([0,17]);
ylim(AX(1),[0,0.05]);
ylim(AX(2),[0,1]);
set(AX,'xtick',[1:1:16]);
set(AX(1),'ytick',[0:0.01:0.05]);
set(AX(2),'ytick',[0:0.1:1]);
xlabel('tri-nucleotides');
ylabel(AX(1),'composition');
ylabel(AX(2),'p-value');
set(AX,'FontSize',8);
set(AX,'XTickLabel',{'AAA','AAC','AAG','AAT','ACA','ACC','ACG','ACT','AGA','AGC','AGG','AGT','ATA','ATC','ATG','ATT'});
legend('positive','negative','p-value');

figure;  %2
xl=1:1:16;
[AX,Bar,Line]=plotyy(xl,ave(17:32,:),xl,pvalue(17:32,1),'bar','plot');
set(Line,'Marker','o');
xlim([0,17]);
ylim(AX(1),[0,0.05]);
ylim(AX(2),[0,1]);
set(AX,'xtick',[1:1:16]);
set(AX(1),'ytick',[0:0.01:0.05]);
set(AX(2),'ytick',[0:0.1:1]);
xlabel('tri-nucleotides');
ylabel(AX(1),'composition');
ylabel(AX(2),'p-value');
set(AX,'FontSize',8);
set(AX,'XTickLabel',{'CAA','CAC','CAG','CAT','CCA','CCC','CCG','CCT','CGA','CGC','CGG','CGT','CTA','CTC','CTG','CTT'});
legend('positive','negative','p-value');

figure;  %3
xl=1:1:16;
[AX,Bar,Line]=plotyy(xl,ave(33:48,:),xl,pvalue(33:48,1),'bar','plot');
set(Line,'Marker','o');
xlim([0,17]);
ylim(AX(1),[0,0.05]);
ylim(AX(2),[0,1]);
set(AX,'xtick',[1:1:16]);
set(AX(1),'ytick',[0:0.01:0.05]);
set(AX(2),'ytick',[0:0.1:1]);
xlabel('tri-nucleotides');
ylabel(AX(1),'composition');
ylabel(AX(2),'p-value');
set(AX,'FontSize',8);
set(AX,'XTickLabel',{'GAA','GAC','GAG','GAT','GCA','GCC','GCG','GCT','GGA','GGC','GGG','GGT','GTA','GTC','GTG','GTT'});
legend('positive','negative','p-value');

figure;  %4
xl=1:1:16;
[AX,Bar,Line]=plotyy(xl,ave(49:64,:),xl,pvalue(49:64,1),'bar','plot');
set(Line,'Marker','o');
xlim([0,17]);
ylim(AX(1),[0,0.05]);
ylim(AX(2),[0,1]);
set(AX,'xtick',[1:1:16]);
set(AX(1),'ytick',[0:0.01:0.05]);
set(AX(2),'ytick',[0:0.1:1]);
xlabel('tri-nucleotides');
ylabel(AX(1),'composition');
ylabel(AX(2),'p-value');
set(AX,'FontSize',8);
set(AX,'XTickLabel',{'TAA','TAC','TAG','TAT','TCA','TCC','TCG','TCT','TGA','TGC','TGG','TGT','TTA','TTC','TTG','TTT'});
legend('positive','negative','p-value');
end