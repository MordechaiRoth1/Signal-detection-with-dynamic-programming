%Written by: Mordechai Roth
%Last updated: Aug 16, 2022

function [Rec,Prec,F1score] = F1_score_4(num_change_points,num_change_points_found,ActualChangePoint,FoundChangePoints,PrecentageAllowed,numSamplesTemplate,numSamplesFound,MeasurementLength)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
FoundChangePoints=FoundChangePoints(FoundChangePoints>0);
num_change_points_found=length(FoundChangePoints);
diss=ones(1,num_change_points)*Inf;
diss2=ones(1,num_change_points)*Inf;
    for i=1:num_change_points_found
        for j=1:num_change_points
            try
%                 if PrecentageAllowed<=50 || sign(FoundChangePoints(i)-ActualChangePoint(j))>=0
                    if diss(j)>=abs(FoundChangePoints(i)-ActualChangePoint(j))
                        diss2(j)=abs((FoundChangePoints(i)+numSamplesFound) -(ActualChangePoint(j)+numSamplesTemplate));
                    end
                        
                    diss(j)=min(diss(j),abs(FoundChangePoints(i)-ActualChangePoint(j)));
                           
            catch
                2;
            end
        end
    end

   diss3=ones(1,num_change_points_found)*Inf;
    for i=1:num_change_points_found
         
         temp2=zeros(1,MeasurementLength);
         try
         temp2(FoundChangePoints(i):FoundChangePoints(i)+numSamplesFound)=1;
         catch
             2;
         end
         for j=1:num_change_points
        temp=zeros(1,MeasurementLength);
        temp(ActualChangePoint(j):ActualChangePoint(j)+numSamplesTemplate)=1;
        temp=temp(1:MeasurementLength);
        temp2=temp2(1:MeasurementLength);
        cover=sum(temp.*temp2);
        diss3(i)=min(numSamplesTemplate-cover,diss3(i));
        end
    
    end
       
   
   

    
%     Tp=zeros(1,num_change_points_found);
    Tp=(diss<numSamplesTemplate/(100/PrecentageAllowed));
    Tp2=(diss2<numSamplesTemplate/(100/PrecentageAllowed));
    Tp3=(diss3<numSamplesTemplate/(100/PrecentageAllowed));
    Tp=and(Tp,Tp2);
    
    
    
    Rec=sum(Tp)/num_change_points;
    if num_change_points_found>num_change_points
        Prec=sum(Tp3)/num_change_points_found;
    else
        Prec=sum(Tp)/num_change_points_found;    
    end
    F1score=2*(Prec*Rec)/(Prec+Rec);
    if isnan(F1score)==1
        F1score=0;
    end
end

