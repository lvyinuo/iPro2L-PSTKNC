function indices=create_indices()
%% 5�۷ְ�����һ������ʱִ�У��˺���ִ�У���֤5�۵Ļ���һ�¡���
p=2633;
n=5266-p;
plabel=ones(p,1);
nlabel=zeros(n,1);
label=[plabel;nlabel];
% 5�۷ְ�
indices = crossvalind('Kfold',label,5); %5Ϊ������֤����
save('indices.mat','indices'); %��indices������indices.mat�ļ���
%�˺�����ʵ���ʹ�ñ������ɵ�indices.mat�ļ�
end