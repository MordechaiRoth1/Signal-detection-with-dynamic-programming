%Written by: Mordechai Roth
%Last updated: Aug 16, 2022

function [TempLoc,ObjectiveCorr,RunTime] = MaxCorrelation(corrVec,pw,fs,num_change_to_find,MeasurementLength)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
tic;
    TempLoc=zeros(1,num_change_to_find);
    ObjectiveCorr=zeros(1,length(TempLoc));

    temp=corrVec.';
    for i=1:num_change_to_find
        [val,TempLoc(i)]=max(temp);
        if i>1
           ObjectiveCorr(i)=ObjectiveCorr(i-1)+val;
        else
            ObjectiveCorr(i)=val;
        end
        if TempLoc(i)-round(pw*fs)-1<0
            temp=[zeros(1,round(pw*fs)+TempLoc(i)),temp(TempLoc(i)+round(pw*fs)+1:end)];
        elseif TempLoc(i)+round(pw*fs)>MeasurementLength
            temp=[temp(1:TempLoc(i)-round(pw*fs)),zeros(1,MeasurementLength-TempLoc(i)+round(pw*fs))];
        else
        temp=[temp(1:TempLoc(i)-round(pw*fs)-1),zeros(1,round(pw*fs)*2),temp(TempLoc(i)+round(pw*fs):end)];
        end
        if val==0
            TempLoc=TempLoc(1:i-1);
%             break
        end
    
    end
    RunTime=toc;
end

