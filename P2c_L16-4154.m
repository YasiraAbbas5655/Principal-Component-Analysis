datadir='F:\5th semester\Digital Image Processing\Projects\Project6\training_data';    % directory where the data files reside
dataset={'arial','bookman_old_style','century','comic_sans_ms','courier_new',...
  'fixed_sys','georgia','microsoft_sans_serif','palatino_linotype',...
  'shruti','tahoma','times_new_roman'};
datachar='abcdefghijklmnopqrstuvwxyz';

Rows=64;    % all images are 64x64
Cols=64;
n=length(dataset)*length(datachar);  % total number of images
p=Rows*Cols;   % number of pixels

X=zeros(p,n);  % images arranged in columns of X
k=1;
for dset=dataset
for ch=datachar
  fname=sprintf('%s/%s/%s.tif',datadir,char(dset),ch);
  img=imread(fname);
  X(:,k)=reshape(img,1,Rows*Cols);
  k=k+1;
end
end

for k=1:length(dataset)
  img=reshape(X(:,26*(k-1)+1),64,64);
  figure(20); subplot(4,3,k); image(img); 
  axis('image'); colormap(gray(256)); 
  title(dataset{k},'Interpreter','none');
end



T=mean(X, 2);%column vector containing the mean of each row
for i=1: p
    for j=1 : n
        X(i,j)=X(i,j)-T(i,1);
    end
end


Z=X;
Z=Z/(sqrt(n-1));
[U, S ,V]=svd(Z,0);
[U,S]=sortem(U,S);
eVal = diag(S);
eigVecs = U;






% for k=1:12
%   figure;imagesc(img);colormap(gray);colorbar;
%   img=reshape(U(:,k),64,64);
%   figure(21); subplot(4,3,k); imagesc(img); 
%   axis('image'); colormap(gray(256));
%   %imagesc(img);colormap(gray);
% end



TransposeOfEigenvector=transpose(U);
Y=TransposeOfEigenvector*X;

figure;plot(1:10,Y(1:10,1:4));legend('a','b','c','d');ylabel('projection coefficients');xlabel('eigenvector number');







m=30;
ImageNo=1;

FirstmProjectionCoe=zeros(1,m);
for g=1 : m
    FirstmProjectionCoe(1,g)=Y(g,ImageNo);
end
FirstmProjectionCoe=transpose(FirstmProjectionCoe);

FirstmEvec=zeros(4096,m);
for k=1 : 4096
    for c=1 :m
    FirstmEvec(k,c)=U(k,c);
    end
end

final=FirstmEvec*FirstmProjectionCoe;
for s=1 : 4096
     final(s,1)=final(s,1)+T(s,1); %adding mean  
end

 %Reshaping Original Image
figure;
img=reshape(final,64,64);
imagesc(img);colormap(gray);
 
 
 
 
 
 


