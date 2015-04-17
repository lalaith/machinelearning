function [ accuracy,confuse ] = nb( train,test )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

[mapObj,mapObjcat,numcat ,cattotal,dictapo] = makedictionary(train,test);
confuse = zeros(8,8);

totalv = sum(numcat);

sizetest = size(test,1);
total = 0;
for i = 1:sizetest
    words = strsplit(test{i});
    cat = mapObjcat(char(words(1)));
    probab = zeros(8,1);
    for k = 1:8
        prob = log(double(numcat(k))/double(totalv));
        for j = 2:size(words,2)
            word = char(words(j));
%             if isKey(mapObj,word)
                aut = mapObj(word);
                a = dictapo(aut,:);
                p1 = log(double(a(k))/double(cattotal(k)));
%             else
%                 p1 = log(double(1)/double(cattotal(k)));
%             end
            prob = prob+p1;
        end
        probab(k)=prob;
    end
    [maxVal maxInd] = max(probab);
    if maxInd == cat
        total=total+1;
    end
    confuse(maxInd,cat)= confuse(maxInd,cat)+1;
end

accuracy = double(total)/double(sizetest);

end

