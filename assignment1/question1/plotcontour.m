function [ output_args ] = plotcontour( timegap,eta )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


x = load('q1x.dat');
x = (x- mean(x))/std(x);
y = load('q1y.dat');
[m,n] = size(x);
n = n+1;

alpha = eta/m;
%adding x0 to x
x0 = ones(m,1);
x = [x0 x];


noi = 1000;
t0 = linspace(-100,100,noi);
t1 = linspace(-40,40,noi);
jt = zeros(noi,noi);

for i = 1:noi
    for j = 1:noi
        theta = [t0(i); t1(j)];
        hth = x*theta;
        sumtot = sum((hth-y)'*(hth-y));
        jt(i,j) = 1/(2*m)*(sumtot);
    end
end


figure;
rotate3d on;
contour(t0,t1,10*log10(jt.'));
%contour(t0,t1,10*log10(jt.'));
xlabel('t0'); 
ylabel('t1');


theta = zeros(n,1);
cond1 = true;
cond2 = true;
condf = true;
l1 = 0;
error = 50000;
errorold = 0;


while condf
    l1= l1+ 1;
    
    if l1 >= 100000 
        cond1 = false;
    end
    if abs(errorold-error) > 0.001
        cond2 = false;
    end
    
    condf = cond1 | cond2;
    
    errorold = error;
    error=0;
    
    hth = x*theta;
    sumtot = sum((hth-y).*x(:,1));
    val = sumtot;
    
    for i = 2:n
        sumtot = sum((hth-y).*x(:,i));
        val = [val sumtot];
    end
    
    %dimension n*1
    val = 1/m*(val)';
    error = (hth-y)'*(hth-y);
    
    
    hold on
    plot3(theta(1),theta(2),10*log10(error),'sk','markersize',2.0,'markerfacecolor','b');
    hold off
    
    
    pause(timegap);
    theta = theta - (alpha*sumtot);
end

end

