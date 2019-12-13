function S=pstknc_3mer()
data0=read_data('all.txt');
datap=data0(1:489,:);  %24
datan=data0(490:2633,:);  %24
%datap=data0(490:626,:);  %28
%datan=[data0(1:489,:);data0(627:2633,:)];  %28
%datap=data0(627:921,:);  %32
%datan=[data0(1:626,:);data0(922:2633,:)];    %32
%datap=data0(922:1147,:);  %38
%datan=[data0(1:921,:);data0(1148:2633,:)];    %38
%datap=data0(1148:1243,:)  %54
%datan=[data0(1:1147,:);data0(1244:2633,:)];    %54
%datap=data0(1244:2633,:);     %70
%datan=data0(1:1243,:);    %70
data=[datap;datan];  %正在前！！
F1=zeros(64,length(char(datap(1,1)))-2);  %[64，len-2]
F0=zeros(64,length(char(datan(1,1)))-2);
for i=1:size(datap,1)  %每一行序列
    for j=1:(length(char(datap(i,1)))-2)  %1：len-2
        q1=char(datap(i,1));
        sq1=q1(j:j+2);    %正F的3mer
        t1=sw_3mer(sq1);  %3mer对应的行数
        F1(t1,j)=F1(t1,j)+1;
    end
end
F1=F1./size(datap,1);
F11=log(F1);
for i=1:size(F11,1)
    for j=1:size(F11,2)
        if F11(i,j)==-inf
            F11(i,j)=-10;
        end
        if F11(i,j)==inf
            F11(i,j)=10;
        end
    end
end

for i=1:size(datan,1)
    for j=1:(length(char(datan(i,1)))-2)
        q0=char(datan(i,1));
        sq0=q0(j:j+2);    %负F的3mer
        t0=sw_3mer(sq0);
        F0(t0,j)=F0(t0,j)+1;
    end
end
F0=F0./size(datan,1);
F00=log(F0);
for i=1:size(F00,1)
    for j=1:size(F00,2)
        if F00(i,j)==-inf
            F00(i,j)=-10;
        end
        if F00(i,j)==inf
            F00(i,j)=10;
        end
    end
end

Z=F1.*F11-F0.*F00;
S=zeros(size(data,1),(length(char(data(1,1)))-2));  %[总序列行数，len-2]（改）
for i=1:size(data,1)
    for j=1:(length(char(data(i,1)))-2)
        q=char(data(i,1));  %每行逐个碱基
        sq=q(j:j+2);  %3mer
        t=sw_3mer(sq);
        S(i,j)=Z(t,j);
    end
end
end