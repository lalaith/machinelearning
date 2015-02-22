function [ x1,x0 ] = read( )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%reading values
x = load('q4x.dat');
yo = importdata('q4y.dat');

%initializing sizes of values of x for which y  is 0 nd 1 respectively
x0l = 0;
x1l = 0;

%finding size of samples an variables
[m,n] = size(x);

%finding sizes of values of x for which y  is 0 nd 1 respectively
for i = 1:m
    if yo{i}=='Canada'
      x1l= x1l+1;  
    else
       x0l = x0l +1; 
    end
    
end


%initializing x0 and x1
x1 = zeros(x1l,n);
x0 = zeros(x0l,n);
l1 = 1;
l0 =1;

%seperating values of x according to their y values (0 or 1)
for i = 1:m
    if yo{i}=='Canada'
      x1(l1,:) = x(i,:);
      l1 = l1+1;
    else
       x0(l0,:)=x(i,:);
       l0 = l0+1;
    end
end

%calculating mean for each list
m0 = mean(x0);
m1 = mean(x1);

% subtracting each value by their respective mean
x0m =  bsxfun(@minus, x0, mean(x0,1) );
x1m = bsxfun(@minus, x1, mean(x1,1) );


xm = [x0m ; x1m];


%finding covariance of collective as well as classified x values
c = (xm'*xm)/m;
c0 = (x0m'*x0m)/size(x0,1)
c1 = (x1m'*x1m)/size(x1,1)




fprintf('mean for Alaska: %f\n',m0);
fprintf('mean for Canada: %f\n',m1);
fprintf('Covariance: \n');
disp(c);
fprintf('Covariance for Alaska: \n');
disp(c0);
fprintf('Covariance for Canada: \n');
disp(c1);


%calculating linear boundary for regression, use the collective covariance
a0 = log(x1l/x0l) - ((m0+m1)*inv(c)*(m0-m1)')/2;
z = inv(c)*(m0-m1)';
xplot = x(:,1);


%calculating quadratic boundary for regression, use the classified covariance

%itearting over each x value, finding values where z1 is equal to 0(or
%around it.

x11t = linspace(40,200,100);
x21t = linspace(0,500,100);
z1t = [0 0];
z2t = [0 0];
for i = 1:100
    for j = 1:100
        x11 = x11t(i);
        x21 = x21t(j);
        %when p(0)=p(1), z1 should be zero
        z1 = log(x0l/x1l) -1/2*(log(det(c1))) + 1/2*(log(det(c0)))  - 1/2*(([x11 x21]-m1)*inv(c1)*([x11 x21]-m1)') + 1/2*(([x11 x21]-m0)*inv(c0)*([x11 x21]-m0)');
        z2 = log(x0l/x1l) -1/2*(log(det(c))) + 1/2*(log(det(c)))  - 1/2*(([x11 x21]-m1)*inv(c)*([x11 x21]-m1)') + 1/2*(([x11 x21]-m0)*inv(c)*([x11 x21]-m0)');
        %if z1 is around 0, add it to the list z1t
        if z1<=0.25 && z1>=-0.25
            z1t = [z1t; x11 x21];
        end
        if z2<=0.1 && z2>=-0.1
            z2t = [z2t; x11 x21];
        end
        
    end
end

z1t(1,:)=[];

%plot original, linear boundary and quadratic boundary(given by z1t)
figure();
scatter(z1t(:,1),z1t(:,2),'r','.');
hold on;
scatter(x1(:,1),x1(:,2),'g');
hold on;
scatter(x0(:,1),x0(:,2),'+','b');
hold on;
plot(xplot,(-a0-z(1)*xplot)/z(2));
hold on;
grid on;
legend('Quadratic', 'Canada','Alaska','Linear Seperator');
hold off;



end

