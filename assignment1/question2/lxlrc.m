function [ xaxis,y,y1 ] = lxlrc(tau)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%reading the values
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

%initializinf theta
theta = inv(x'*x)*x'*y;

for i = 1:m
    %calculating W matrix for every sample to define proximity
    we = exp(-(x(i,2) - x(:,2)).^2./(2*tau^2));
    W = diag(we);
    %calculating appropriate theta using normal equations
    theta = inv(x'*W*x)*x'*W*y;
    %calculating y(i) for theta and x(i)
    y1(i) = x(i,:)*theta;
end

    
%plotting values
xaxis = x(:,2);
scatter(xaxis,y,'r');
hold on
scatter(xaxis,y1,'b');
legend('original', 'obtained tau=0.8');
grid on;
hold off;

end

