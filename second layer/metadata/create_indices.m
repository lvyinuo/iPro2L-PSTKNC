function indices=create_indices(p)
%% 5�۷ְ�����һ������ʱִ�У��˺���ִ�У���֤5�۵Ļ���һ�¡���
n=2633-p;
plabel=ones(p,1);
nlabel=zeros(n,1);
label=[plabel;nlabel];
% 5�۷ְ�
indices = crossvalind('Kfold',label,5); %5Ϊ������֤����
save('indices.mat','indices'); %��indices������indices.mat�ļ���
%�˺�����ʵ���ʹ�ñ������ɵ�indices.mat�ļ�
end