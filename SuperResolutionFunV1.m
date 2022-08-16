%Written by: Mordechai Roth
%Last updated: Aug 16, 2022

function [x] = SuperResolutionFunV1(signal,MeasurementLength,delta)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

n=length(signal);
f=linspace(0,1,length(signal));
vec=1:1:length(signal);
kernelG=exp(-(vec-50).^2/2/100);

d=[ones(1,MeasurementLength*10),zeros(1,length(signal)-MeasurementLength*10)];
K=circulant(d);

null=signal(randperm(length(signal)));
% delta=norm(K*null,2);
% delta=min(norm(K*null,1)/2,norm(signal,1)/2);
% delta=(norm(signal,1)/2);
% delta=norm(K*null,1);
cvx_optval=inf;
% delta=200;
% s=-n/2:1:n/2-1;
% R=norm(ifft(fft(kernelG).*fft(abs(vec)<=100)),1)/100;
% R=1
count=0;
while cvx_optval==inf
    count=count+1;
cvx_begin quiet
variable x(n);
minimize( norm(x,1)) ;

subject to
norm(signal-K*x,2).^2<=1.2*delta;
0<=x<=1
% norm(signal-fshift(kernelG,s.')/R*x,1)<=delta;
% norm(signal-fshift(ifft(fft(kernelG).*fft(abs(vec)<=100)),s.')/R*x,1)<=delta;
cvx_end
%     if cvx_optval==inf
%         delta=delta*1.1;
%     end
%     if count==10;
%         delta=delta*2;
%     elseif count==20;
%         cvx_optval=-inf;
%         x=rand(size(signal));
%         pause;
%     end
%     
    
end
% TemplateSpread(length(signal),100)end

