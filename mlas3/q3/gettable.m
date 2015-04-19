function [ d,i,g,s,l ] = gettable( data )
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
d = zeros(2,1);
i = zeros(2,1);
g = zeros(3,4);
s = zeros(2,2);
l = zeros(2,3);

sizedata = size(data,1);

for iter = 1:sizedata
    if data(iter,6)~=0
    d(data(iter,1)+1,1)=d(data(iter,1)+1,1)+data(iter,6);
    i(data(iter,2)+1,1)=i(data(iter,2)+1,1)+data(iter,6);
    g(data(iter,3),(data(iter,1))*2+data(iter,2)+1)=g(data(iter,3),(data(iter,1))*2+data(iter,2)+1)+data(iter,6);
    s(data(iter,4)+1,data(iter,2)+1) = s(data(iter,4)+1,data(iter,2)+1)+data(iter,6);
    l(data(iter,5)+1,data(iter,3))=l(data(iter,5)+1,data(iter,3))+data(iter,6);  
    end
end


d = bsxfun(@rdivide,d,sum(d));
i = bsxfun(@rdivide,i,sum(i));
g = bsxfun(@rdivide,g,sum(g));
s = bsxfun(@rdivide,s,sum(s));
l = bsxfun(@rdivide,l,sum(l));


end

