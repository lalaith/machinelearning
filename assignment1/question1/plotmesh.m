function [ output_args ] = plotmesh( timegap,eta )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%reading the values and normalizing
x = load('q1x.dat');
x = (x- mean(x))/std(x);
y = load('q1y.dat');


%calculating their sizes - sample number and variable number
[m,n] = size(x);
n = n+1;

alpha = eta/m;

%adding x0 to x - including the intercept term
x0 = ones(m,1);
x = [x0 x];



%initialize t0 and t1

noi = 1000;
t0 = linspace(-100,100,noi);
t1 = linspace(-40,40,noi);
jt = zeros(noi,noi);


%for every t0 and t1, calculate error value

for i = 1:noi
    for j = 1:noi
        %jt(i,j) represents the error value at t0(i) anf t1(j)
        theta = [t0(i); t1(j)];
        hth = x*theta;
        sumtot = sum((hth-y)'*(hth-y));
        %dimension n*1
        jt(i,j) = 1/(2*m)*(sumtot);
    end
end


%plot contour for error
figure;
rotate3d on;
mesh(t0,t1,(jt.'));
%contour(t0,t1,10*log10(jt.'));
xlabel('t0'); 
ylabel('t1');


%initializing theta,alpha and difference

theta = zeros(n,1);
cond1 = true;
cond2 = true;
condf = true;
l1 = 0;
error = 50000;
errorold = 0;


%looping until there are atleast 100000 iterations and error is less than
%discribed

while condf
    %incrementing number of iterations
    
    l1= l1+ 1;
    
    %modifying looping condition with each iteration    
    
    if l1 >= 100000 
        cond1 = false;
    end
    if abs(errorold-error) > 0.001
        cond2 = false;
    end
    
    condf = cond1 | cond2;
    
    errorold = error;
    error=0;
    
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
    
    %Finding error with each iteration
    error = (hth-y)'*(hth-y);
    
    %plotting error
    hold on
    plot3(theta(1),theta(2),(error),'sk','markersize',6.0,'markerfacecolor','k');
    hold off
    
    %inducing timegap
    pause(timegap);
    
    %modifying theta
    theta = theta - (alpha*sumtot);
end

end

