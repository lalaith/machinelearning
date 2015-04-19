
%reading the data
data = getdata('q3_data/train-100.data');

%creating the data table
[d,i,g,s,l ] = gettable( data );

error = 1;
iteration = 0;
p = 20;

forplot = [];

while(error~=0)
    iteration = iteration+1
    %Expectation - add to the data
    datanew = expectation( d,i,g,s,l,data );
    
    
    
    %Maximization - create new tables
    [d,i,g,s,l ] = gettable( datanew );
    
    
    %find the error
    oldp = p;
    %calculate newp
    newp = probtest(d,i,g,s,l);
    p = newp;
    error = p-oldp;
    
    forplot = [forplot;[error,p]];
    error
    p
end

d = size(forplot,1);
figure % create new figure
subplot(1,2,1) % first subplot
plot(forplot(2:d,1));
title('Error');
subplot(1,2,2)
plot(forplot(2:d,2),'r');
title('Prob');


