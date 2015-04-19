%average face

arrayzero = {'0000','000','00','0'};
F = uint32(imread('q5_data/face00001.pgm'));
for i = 2:2429
    df = floor(log(i)/log(10))+1;
    if i==1000
        df = 4;
    end
    zerovalue = arrayzero{df};
    filename = strcat('q5_data/face',zerovalue,int2str(i),'.pgm');
    F = imadd(F,uint32(imread(filename)));
end
F = F/2429;
imshow(F,[]);