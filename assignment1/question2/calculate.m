function [ x,y,theta ] = calculate( )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%reading values
x = load('q3x.dat');
y = load('q3y.dat');

%finding size of samples and variables
[m,n] = size(x);
n = n+1;

%adding x0 to x
x0 = ones(m,1);
x = [x0 x];

%initializing output
y1 = ones(m,1);

%using normal equations to find appropraite theta
theta = inv(x'*x)*x'*y;

%finding y(i) using theta and x(i)
for i = 1:m
    theta = inv(x'*x)*x'*y;
    y1(i) = x(i,:)*theta;
end


%plotting data
xaxis = x(:,2);
scatter(xaxis,y,'r');
hold on
scatter(xaxis,y1,'b');
legend('original', 'unweighted linear regression');
grid on;

end

