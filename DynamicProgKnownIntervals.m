%Written by: Mordechai Roth
%Last updated: Aug 16, 2022

function [Locations,g,RunTime] = DynamicProgKnownIntervals(corrVec,pw,fs,num_change_to_find,MeasurementLength)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
tic 
     g=zeros(num_change_to_find,MeasurementLength);

    loc=zeros(num_change_to_find,MeasurementLength);
    Locations=cell(num_change_to_find,MeasurementLength);
    g(1,1)=corrVec(1);
    loc(1,1)=1;
    Locations{1,1}=loc(1,1);
    
    for i=2:MeasurementLength
        
        g(1,i)=max(g(1,i-1),corrVec(i));
        
        if g(1,i)>g(1,i-1)
           loc(1,i)=i;
        else
           loc(1,i)=loc(1,i-1);           
        end
        
           Locations{1,i}=loc(1,i);
    end
    

    for j=2:num_change_to_find
        if round(j*pw*fs)>MeasurementLength
            g(j,:)=g(j-1,:);
            loc(j,:)=loc(j-1,:);
        else
        for i=1:MeasurementLength
            
            if i>round((j-1)*pw*fs+1)
%                 try 
                    g(j,i)=max(g(j,i-1),g(j-1,round(i-pw*fs))+corrVec(i));
%                 catch
%                     1;
%                 end
                        if g(j,i)>g(j,i-1)

                            loc(j,i)=i;
                            Locations{j,i}=[Locations{j-1,i-round(pw*fs)},i];
                        else
                            loc(j,i)=loc(j,i-1);
                            Locations{j,i}=Locations{j,i-1};

                        end
            elseif i==(j-1)*round(pw*fs)+1
                g(j,i)=sum(corrVec(1:round(pw*fs):(j-1)*round(pw*fs)+1));
                loc(j,i)=i;
                Locations{j,i}=[Locations{j-1,i-round(pw*fs)},i];
            else
                g(j,i)=g(j-1,i);
            end
            
        end

    end
end
RunTime=toc;

end

