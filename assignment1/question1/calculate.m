function [ x,y,theta ] = calculate( )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%reading the values
x = load('q1x.dat');
y = load('q1y.dat');


%calculating their sizes - sample number and variable number
[m,n] = size(x);
n = n+1;



%adding x0 to x - including the intercept term
x0 = ones(m,1);
x = [x0 x];

%initializing theta,alpha and difference
theta = zeros(n,1);
alpha = 0.001;
cond1 = true;
cond2 = true;
condf = true;
l1 = 0;
lc = [0.000000000001, 0.000000000001]';

%looping until there are atleast 100000 iterations and error is less than
%discribed
while condf
    
    %incrementing number of iterations
    l1= l1+ 1;
    
    
    % finding the val matrix, which represents (y-htheta(x))*x
    % it's dimensions will be nX1
    hth = x*theta;
    sumtot = sum((hth-y).*x(:,1));
    val = sumtot;
    
    for i = 2:n
        sumtot = sum((hth-y).*x(:,i));
        val = [val sumtot];
    end
    
    %dimension n*1
    val = 1/m*(val)';
    
    %modifying looping condition with each iteration    
    if l1 >= 100000 
        cond1 = false;
    end
    if sum(gt(val,lc))==0
        cond2 = false;
    end
    condf = cond1 | cond2;
    
    
    
    
    %chnage theta value
    theta= theta - alpha*val;
end


%plot graphs
fprintf('Learning Rate: %f',alpha);
fprintf('\nStopping criteria: diff < %lu',lc);
fprintf('\ntheta obtained:\n');
disp(theta);
fprintf('\n');
plotnew(x,y,theta);
xlabel('x');
ylabel('y');
plotdyn(x,y);

end

