function [ probdata ] = getdata( input )
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here

a = fopen(input);
totaldat = textscan(a,'%s','Delimiter','\n');
data = totaldat{1};
sizedata = size(data,1);
probdata = zeros(sizedata,6);

%initialize data values
for i = 1:sizedata
    d = strsplit(data{i});
    isq = 0;
    probdata(i,6)=1;
    for j = 1:size(d,2)
        if d{j}=='?'
            isq=isq+1;
            probdata(i,j)=-1;
            probdata(i,6)=0;
        else
            probdata(i,j) = str2double(d{j});
        end
    end
end

end

