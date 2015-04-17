%reading and partioning the data

a = fopen('20ng-rec_talk.txt');
totaldat = textscan(a,'%s','Delimiter','\n');
I = randperm(7230);
datadiv = {};
for i = 1:5
    datadiv{i} =  totaldat{1}(I(1446*(i-1)+1:1446*i));
end

accuracy = zeros(5,1);
tys = [1446*4];

for ki = 1:size(tys,2)
    confuse = zeros(8,8);
    for i = 1:5
        datatest = datadiv{i};
        datatrain = {};
        for j = 1:5
            if j~=i
                datatrain = [datatrain ; datadiv{i}];  
            end
        end
        dsp={};
        for k = 1:tys(ki)
            dsp{k,1} = datatrain{k};
        end
        [accuracy(i,1),confuse1] = nb(dsp,datatest);
        confuse = confuse+confuse1;

    end
    finaccuracy = mean(accuracy);
    disp(tys(ki));
    disp(finaccuracy);
    disp(confuse);
    
end