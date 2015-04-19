function [ datanew ] = expectation( d,i,g,s,l,data )
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here

sizedata = size(data,1);
datanew = data;

for iter = 1:sizedata
    v = data(iter,6);
    if v==1
        continue
    end
    ind = find(data(iter,1:5)==-1);
    values = data(iter,:);
    values0 = values;
    values1 = values;
    values2 = values;
    values3 = values;
    values0(1,ind)=0;
    values1(1,ind)=1;
    values2(1,ind)=2;
    values3(1,ind)=3;
        
    if ind==1
        prob0 = d(1,1);
        prob1 = d(2,1);
        values0(1,6)=prob0;
        values1(1,6)=prob1;
        datanew(iter,:) = values0;
        datanew = [datanew;values1];        
    elseif ind==2
        prob0 = i(1,1);
        prob1 = i(2,1);
        values0(1,6)=prob0;
        values1(1,6)=prob1;
        datanew(iter,:) = values0;
        datanew = [datanew;values1];
    elseif ind==3
        prob1 = g(1,(data(iter,1))*2+data(iter,2)+1);
        prob2 = g(2,(data(iter,1))*2+data(iter,2)+1);
        prob3 = g(3,(data(iter,1))*2+data(iter,2)+1);
        values1(1,6)=prob1;
        values2(1,6)=prob2;
        values3(1,6)=prob3;
        datanew(iter,:) = values1;
        datanew = [datanew;values2];
        datanew = [datanew;values3];
    elseif ind==4
        prob0 = s(1,data(iter,2)+1);
        prob1 = s(2,data(iter,2)+1);
        values0(1,6)=prob0;
        values1(1,6)=prob1;
        datanew(iter,:) = values0;
        datanew = [datanew;values1];
    elseif ind==5
        prob0 = l(1,data(iter,3));
        prob1 = l(2,data(iter,3));
        values0(1,6)=prob0;
        values1(1,6)=prob1;
        datanew(iter,:) = values0;
        datanew = [datanew;values1];
        
    end
    
end
end

