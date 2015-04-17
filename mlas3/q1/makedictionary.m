function [ mapObj,mapObjcat,numcat ,cattotal,dictapo] = makedictionary( train,test )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

sizetrain = size(train,1);
sizetest = size(test,1);

wordlist = {'talk.politics.mideast.dummyword'};
mat = [0];
mapObj = containers.Map(wordlist,mat);
dictapo = [];
categories = {'talk.politics.mideast','rec.motorcycles', 'rec.sport.baseball', 'rec.sport.hockey', 'talk.politics.misc', 'talk.religion.misc' ,'talk.politics.guns' , 'rec.autos'  };
values = [1 2 3 4 5 6 7 8];
numcat = zeros(8,1);
mapObjcat = containers.Map(categories,values);


for i = 1:sizetrain
    words = strsplit(train{i});
    cat = mapObjcat(char(words(1)));
    numcat(cat)=numcat(cat)+1;
    for j = 2:size(words,2)
        word = char(words(j));
        if isKey(mapObj,word)
            ai = mapObj(word);
            dictapo(ai,cat) = dictapo(ai,cat)+1;            
        else
            sd = size(dictapo,1)+1;
            mapObj(word)=sd;
            dictapo(sd,:) = ones(1,8);
            dictapo(sd,cat) = dictapo(sd,cat)+1;
        end
    end
end

for i = 1:sizetest
    words = strsplit(test{i});
    for j = 2:size(words,2)
        word = char(words(j));
        if not(isKey(mapObj,word))
            sd = size(dictapo,1)+1;
            mapObj(word)=sd;
            dictapo(sd,:) = ones(1,8);
        end
    end
end

size(dictapo);
cattotal = sum(dictapo);


end

