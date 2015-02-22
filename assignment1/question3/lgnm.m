function [ ly0,ly1 ] = lgnm( )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%reading values
x = load('q2x.dat');
y = load('q2y.dat');

%finding size of samples an variables
[m,n] = size(x);



%dividing x values into 2 groups depenidng on their y values(0 or 1)
ly0 =[0 0];
ly1 = [0 0];
for i = 1:m
    if y(i)==1
        ly1 = [x(i,:);ly1];
        
    else
        ly0 = [x(i,:);ly0];
        
    end
end 

n = n+1;

%adding x0 to x
x0 = ones(m,1);
x = [x0 x];

%initializing theta and difference
theta = zeros(n,1);
alpha = 0.001;
cond1 = true;
cond2 = true;

condf = true;
l1 = 0;
lc = 0.00001;


%looping
while condf
    
    %increasing iteration number
    l1= l1+1;
    
    
    % modifying looping criteria
    if l1 >= 9 
        cond1 = false;
    end 
    
    
    
    %defining htehta for logistic regression
    hth = 1./(1+exp(-(x*theta)));
    
    % finding the val matrix, which represents (y-htheta(x))*x
    % it's dimensions will be nX1
    sumtot = sum((hth-y).*x(:,1));
    val = sumtot;
    
    for i = 2:n
        sumtot = sum((hth-y).*x(:,i));
        val = [val sumtot];
    end
    
    %dimension n*1
    gradient = 1/m*(val)';
    
    
   
    %calculating hessian matrix
    hessian = zeros(n,n);
    
    for i = 1:m
        for j = 1:n
            for k = 1:n
                hessian(j,k) = hessian(j,k) + hth(i)*(1-hth(i))*x(i,j)*x(i,k);
            end
        end
    end
    
    %fidning the difference
    diff = inv(hessian)*gradient;
            
    
    %editing theta
    theta = theta -diff/(m) ;
    
    
    % modifying looping criteria
    if diff'*diff <= lc
       cond2 = false;
    end
    condf = cond1 &cond2;
    
    
    
end



%plotting original values
scatter(ly0(:,1),ly0(:,2),'r');
hold on
scatter(ly1(:,1),ly1(:,2),'b','+');
grid on
legend('y=0','y=1');


%plotting where p(0)==p(1)==0.5
px = x(:,2);
py = (-1/theta(3))*(theta(2)*x(:,2)+theta(1)*x(:,1));
plot(px,py);


hold off

theta
end

