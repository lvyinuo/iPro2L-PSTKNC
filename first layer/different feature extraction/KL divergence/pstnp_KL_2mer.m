function S=pstnp_KL_2mer()
data0=read_data('all.txt');
datap=data0(1:2633,:);     %������(��)
datan=data0(2634:5266,:);    %������(��)
data=[datap;datan];  %����ǰ����
F1=zeros(16,length(char(datap(1,1)))-1);  %[16��len-1]
F0=zeros(16,length(char(datan(1,1)))-1);
for i=1:size(datap,1)  %ÿһ������
    for j=1:(length(char(datap(i,1)))-1)  %1��len-1
        q1=char(datap(i,1));
        sq1=q1(j:j+1);    %��F��2mer
        t1=sw_2mer(sq1);  %2mer��Ӧ������
        F1(t1,j)=F1(t1,j)+1;
    end
end
F1=F1./size(datap,1);
F2=log(F1);
for i=1:size(F2,1)
    for j=1:size(F2,2)
        if F2(i,j)==-inf
            F2(i,j)=-10;
        end
        if F2(i,j)==inf
            F2(i,j)=10;
        end
    end
end

for i=1:size(datan,1)
    for j=1:(length(char(datan(i,1)))-1)
        q0=char(datan(i,1));
        sq0=q0(j:j+1);    %��F��2mer
        t0=sw_2mer(sq0);
        F0(t0,j)=F0(t0,j)+1;
    end
end
F0=F0./size(datan,1);
F0=log(F0);
for i=1:size(F0,1)
    for j=1:size(F0,2)
        if F0(i,j)==-inf
            F0(i,j)=-10;
        end
        if F0(i,j)==inf
            F0(i,j)=10;
        end
    end
end

Z=F1.*(F2-F0);
S=zeros(size(data,1),(length(char(data(1,1)))-1));  %[������������len-1]���ģ�
for i=1:size(data,1)
    for j=1:(length(char(data(i,1)))-1)
        q=char(data(i,1));  %ÿ��������
        sq=q(j:j+1);  %2mer
        t=sw_2mer(sq);
        S(i,j)=Z(t,j);
    end
end
end
