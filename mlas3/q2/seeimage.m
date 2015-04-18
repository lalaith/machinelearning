function [ ] = seeimage( i )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

a = fopen('digitdata.txt');
totaldat = textscan(a,'%s','Delimiter','\n');
data = totaldat{1};


indexobt = data{1};
imageobt = data{i+1};

index = strsplit(indexobt);
image = strsplit(imageobt);

indeximp={};
for j = 1:size(index,2)
     s = strrep(index{j}, 'pixel', '');
     s = strrep(s, '"', '');
     indeximp{j} = str2double(s);
end

imageimp={};
for j = 1:size(image,2)
     s = strrep(image{j}, 'pixel', '');
     s = strrep(s, '"', '');
     imageimp{j} = str2double(s);
end

imagestore = zeros(784,1);
for i = 2:size(imageimp,2)
    pixel = indeximp{i-1};
    pixelvalue = imageimp{i};
    imagestore(pixel,1) = pixelvalue;
end
imagestore = reshape(imagestore,28,28);
imshow(imagestore');

end

