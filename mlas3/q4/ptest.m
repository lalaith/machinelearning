arrayzero = {'0000','000','00','0'};
total = zeros(361,361);
for i = 1:2429
    df = floor(log(i)/log(10))+1;
    if i==1000
        df = 4;
    end
    zerovalue = arrayzero{df};
    filename = strcat('q5_data/face',zerovalue,int2str(i),'.pgm');
    a = double(reshape(uint32(imread(filename)),361,1));
    total = total+a*a';
end

[Ut,St,Vt] = eigs(total,50);
[U,S,V] = eigs(total,5);

figure;
for i=1:5
    im = U(:,i);
    maxv = max(im(:));
    minv = min(im(:));
    ims = reshape(im,19,19);
    subplot(5,1,i),imshow(ims,[minv,maxv]);   
end