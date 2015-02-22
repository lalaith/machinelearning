function [ output_args ] = plotall(  )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
tau = [0.1, 0.3, 0.8,2,10];
[a,b,c] = lxlrc(0.8);
linespec = {'b', 'r', 'g','k','m'}
figure;
scatter(a,b,'y','*');
lo = length(tau)
for i = 1:lo
    hold on;
    [a,b,c] = lxlrc(tau(i));
    data = [a,c];
    data = sortrows(data,1);
    plot(data(:,1),data(:,2),linespec{i});    
end
hold off;
legend('original','0.1','0.3','0.8','2.0','10');

end

