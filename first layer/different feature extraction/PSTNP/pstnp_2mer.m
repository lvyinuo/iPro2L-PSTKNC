function S=pstnp_2mer()
data=read_data('all.txt');
datap=data(1:2633,:);     %正样本(改)
datan=data(2634:5266,:);    %负样本(改)
F1=zeros(16,length(char(datap(1,1)))-1);  %[16，len-1]
F0=zeros(16,length(char(datan(1,1)))-1);
for i=1:size(datap,1)  %每一行序列
    for j=1:(length(char(datap(i,1)))-1)  %1：len-1
        q1=char(datap(i,1));
        sq1=q1(j:j+1);    %正F的2mer
        t1=sw_2mer(sq1);  %2mer对应的行数
        F1(t1,j)=F1(t1,j)+1;
    end
end
F1=F1./size(datap,1);
for i=1:size(datan,1)
    for j=1:(length(char(datan(i,1)))-1)
        q0=char(datan(i,1));
        sq0=q0(j:j+1);    %负F的2mer
        t0=sw_2mer(sq0);
        F0(t0,j)=F0(t0,j)+1;
    end
end
F0=F0./size(datan,1)
Z=F1-F0;
S=zeros(size(data,1),(length(char(data(1,1)))-1));  %[总序列行数，len-1]（改）
for i=1:size(data,1)
    for j=1:(length(char(data(i,1)))-1)
        q=char(data(i,1));  %每行逐个碱基
        sq=q(j:j+1);  %2mer
        t=sw_2mer(sq);
        S(i,j)=Z(t,j);
    end
end
end

