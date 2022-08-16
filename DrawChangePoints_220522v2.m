%Written by: Mordechai Roth
%Last updated: Aug 16, 2022

function [changeIdx,Terminate] = DrawChangePoints_220522v2(pw,fs,signal_length,num_change_points,sparseFlag)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
Terminate=0;
if sparseFlag==1
    pw=2*pw;
end


changeIdx=[];
Terminate=0;
for i=1:num_change_points
    

    if Terminate==0
    T=1;
    tries=0;
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
        else
            tries=tries+1;
        end
       
       if tries>=20
            T=0;
            Terminate=1;

       end
    end
    
        
    end
end
changeIdx=sort(changeIdx);
changeIdx=changeIdx';
end

