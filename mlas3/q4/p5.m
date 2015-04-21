imsd = uint32(imread('courses.jpg'));
imsd = imresize(imsd,[19 19]);
imsd = rgb2gray(imsd);
B = double(reshape(imsd,361,1));

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

Bor = imsd;
maxvb = max(Bor(:));
minvb = min(Bor(:));
subplot(2,1,2),imshow(Bor,[minvb,maxvb]);