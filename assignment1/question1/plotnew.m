function [  ] = plotnew( x,y,theta )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
%figure;
x1 = x(:,2);
ypre = x*theta;

scatter(x1,y,'r');
hold on
grid on
plot(x1,ypre);
legend('original', 'obtained');
hold off




end

