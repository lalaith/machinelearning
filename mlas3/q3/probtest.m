function [ prob ] = probtest( d,i,g,s,l )
%UNTITLED13 Summary of this function goes here
%   Detailed explanation goes here
data = load('q3_data/test.data');

sizedata = size(data,1);
prob = 0;

for iter = 1:sizedata
    prob=prob + log(d(data(iter,1)+1,1));
    prob=prob + log(i(data(iter,2)+1,1));
    prob=prob + log(g(data(iter,3),(data(iter,1))*2+data(iter,2)+1));
    prob=prob + log(s(data(iter,4)+1,data(iter,2)+1));
    prob=prob + log(l(data(iter,5)+1,data(iter,3)));    
end

end

