function data=read_data(filename)
data=importdata(filename);
data=data(2:2:end,:); %��ȡ���ݼ��е�����
end

