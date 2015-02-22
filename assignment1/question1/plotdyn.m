function [ output_args ] = plotdyn( x,y )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
[m,n] = size(x);


%initialize t0 and t1
noi = 1000;
t0 = linspace(-50,50,noi);
t1 = linspace(-20,20,noi);
jt = zeros(noi,noi);


%for every t0 and t1, calculate error value
for i = 1:noi
    for j = 1:noi
        %jt(i,j) represents the error value at t0(i) anf t1(j)
        theta = [t0(i) t1(j)];
        hth = x*theta';
        sumtot = sum((hth-y)'*(hth-y));
        %dimension n*1
        jt(i,j) = 1/(2*m)*(sumtot);
    end
end


%plot mesh and contour for error
figure;
contour(t0,t1,10*log10(jt.'));
xlabel('t0');
ylabel('t1');

figure;
mesh(t0,t1,10*log10(jt.'));
xlabel('t0'); 
ylabel('t1');

end

