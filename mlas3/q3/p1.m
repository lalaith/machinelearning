data = load('q3_data/train-0.data');

d = zeros(2,1);
i = zeros(2,1);
g = zeros(3,4);
s = zeros(2,2);
l = zeros(2,3);

sizedata = size(data,1);

for iter = 1:sizedata
    d(data(iter,1)+1,1)=d(data(iter,1)+1,1)+1;
    i(data(iter,2)+1,1)=i(data(iter,2)+1,1)+1;
    g(data(iter,3),(data(iter,1))*2+data(iter,2)+1)=g(data(iter,3),(data(iter,1))*2+data(iter,2)+1)+1;
    s(data(iter,4)+1,data(iter,2)+1) = s(data(iter,4)+1,data(iter,2)+1)+1;
    l(data(iter,5)+1,data(iter,3))=l(data(iter,5)+1,data(iter,3))+1;    
end


d = bsxfun(@rdivide,d,sum(d));
i = bsxfun(@rdivide,i,sum(i));
g = bsxfun(@rdivide,g,sum(g));
s = bsxfun(@rdivide,s,sum(s));
l = bsxfun(@rdivide,l,sum(l));


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
prob