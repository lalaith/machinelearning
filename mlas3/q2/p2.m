a = fopen('digitdata.txt');
totaldat = textscan(a,'%s','Delimiter','\n');
data = totaldat{1};
imagestore = zeros(1000,159);

a2 = fopen('digitlabels.txt');
totaldat2 = textscan(a2,'%s','Delimiter','\n');
data2 = totaldat2{1};

for i = 1:1000
    imageobt = data{i+1};
    image = strsplit(imageobt);
    labelobt = data2{i+1};
    label = strsplit(labelobt);
    for j = 2:size(image,2)
         s = strrep(image{j}, 'pixel', '');
         s = strrep(s, '"', '');
         labeler = str2double(label{2});
         %imagestore(i,j-1) = str2double(s);
         imagestore(i,j-1) = str2double(s)/255;
    end
    imagestore(i,158) = labeler;
    
end

imagestore = imagestore(randperm(size(imagestore,1)),:);



%value = imagestore(1:4,1:157);
value = rand(4,157);


error = ones(4,157);
zeromatrix = zeros(4,157);

plotmat = zeros(30,3);

it = 0;
while  not(isequal(error,zeromatrix)) && (it<30)
    it = it+1;
    confuse = zeros(10,4);
    
    %calculating closest category
    for i = 1:1000
        dist = zeros(4,1);
        for j = 1:4
            dist(j,1) = sum((imagestore(i,1:157)-value(j,:)).^2);
        end
        [minval,minindex]=min(dist);
        imagestore(i,159)=minindex;
    end
    
    old = value;
    new = zeros(4,157);
    count = zeros(4,1);
    
    for i = 1:1000
        cv = imagestore(i,159);
        new(cv,:) = new(cv,:)+ imagestore(i,1:157);
        count(cv,1) = count(cv,1)+1;
    end
    for j = 1:4
        new(j,:) = new(j,:)/count(j,1);
    end

    error = new-old;
    value = new;
    
    for i = 1:1000
        a1 = imagestore(i,158);
        a2 = imagestore(i,159);
        confuse(a1,a2) = confuse(a1,a2)+1;
                  
    end
    misclssified = sum(confuse,2)-(max(confuse'))';
    errorold = sum(misclssified)/1000;
    
    sumval = 0;
    count=0;
    for i = 1:1000
        j = imagestore(i,159);
        sumval = sumval + sum((imagestore(i,1:157)-value(j,:)).^2);
    end
    S = sumval/1000;
    plotmat(it,1)=errorold;
    plotmat(it,2)=S;
    plotmat(it,3)=it;
    
end
plotmat = plotmat(1:it,:);

figure % create new figure
subplot(1,2,1) % first subplot
plot(plotmat(:,1));
title('Error');
subplot(1,2,2)
plot(plotmat(:,2),'r');
title('S');