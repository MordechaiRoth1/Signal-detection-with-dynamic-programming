%Written by: Mordechai Roth
%Last updated: Aug 16, 2022

function [changeIdx] = DrawChangePoints(pw,fs,signal_length,num_change_points)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
changeIdx=[];
for i=1:num_change_points
    T=1;
    tries=0;
    Terminate=0;
    while T==1
        temp=round(rand(1)*(signal_length-pw*fs-1))+1;
         andProd=1;

        for j=1:length(changeIdx)
            if abs(changeIdx(j)-temp)<pw*fs
               andProd=0;
            end
            
        end
        
        if  andProd==1
            changeIdx(i)=temp;
            T=0;
        end
       tries=tries+1;
       if tries>=20
            randStart=round(rand(1)*pw*fs);
            changeIdx=[1+randStart:((pw*fs+1)):randStart+num_change_points*(pw*fs+1)];
            Terminate=1;
%            [changeIdx] = DrawChangePoints(pw,fs,signal_length,num_change_points);
%            T=0;
       end
%        if Terminate==1
%            break
%        end
    end
%     if Terminate==1
%         break
%     end
end
changeIdx=sort(changeIdx);
changeIdx=changeIdx';
end

