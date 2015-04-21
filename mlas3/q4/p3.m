i  = 689;
arrayzero = {'0000','000','00','0'};
total = zeros(361,361);
df = floor(log(i)/log(10))+1;
if i==1000
    df = 4;
end
zerovalue = arrayzero{df};
filename = strcat('q5_data/face',zerovalue,int2str(i),'.pgm');
B = double(reshape(uint32(imread(filename)),361,1));

A = zeros(361,1);
for i=1:50
    U = Ut(:,i);
    Bt = B*B';
    A = A + (U'*Bt')'.*U;
end

im = A;
maxv = max(im(:));
minv = min(im(:));
ims = reshape(im,19,19);
subplot(2,1,1),imshow(ims,[minv,maxv]);

Bor = imread(filename);
maxvb = max(Bor(:));
minvb = min(Bor(:));
subplot(2,1,2),imshow(Bor,[minvb,maxvb]);