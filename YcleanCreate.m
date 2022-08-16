%Written by: Mordechai Roth
%Last updated: Aug 16, 2022

Yclean=zeros(1,signal_length);
for i=1:numel(changeIdx)
    
    Yclean(changeIdx(i):changeIdx(i)+pw*fs-1)=1;%0.5.*(1+cos(2*pi/(fs*pw)*(-fs*pw/2+1:1:fs*pw/2)));

    
end
Y=Yclean(1:signal_length);