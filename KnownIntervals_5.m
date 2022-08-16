%Written by: Mordechai Roth
%Last updated: Aug 16, 2022

function [LocationsOurs,pw_ours,LocationsOursKnownK,LocationOursKnownPW,BenchmarkLocations,pw_benchmark,BenchmarkLocationsKnownK,BenchmarkLocationsKnownPW,tempObjectiveOursMat,tempBenchmarkMat,timeObjective,timeCorr,NullOursMat,...
    NullBenchmarkMat,NumChangeOurs,NumChangeBenchmark,NumChangePointsBenchmarkKnownNumber] = KnownIntervals_5(signal,pw,fs,num_change_points,num_change_to_find,MeasurementLengthFlag)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
   
    Locations_Mat={};
    
    BenchmarkLoc_Mat={};    
if MeasurementLengthFlag==1
    pw_vec=pw;
    pw_ours=pw;
    pw_benchmark=pw;
else
    pw_vec=[0.7*pw:0.1*pw:1.3*pw];
end


%     LocationsOurs=cell(1,length(pw_vec));
%     LocationsOursKnownK=cell(1,length(pw_vec));
%     BenchmarkLocations=cell(1,length(pw_vec));
%     BenchmarkLocationsKnownK=cell(1,length(pw_vec));
%     NumChangePointsBenchmarkKnownNumber=zeros(1,length(pw_vec));


    NullOursMat=zeros(length(pw_vec),num_change_to_find);
    NullBenchmarkMat=zeros(length(pw_vec),num_change_to_find);
    ObjectiveOursMat=zeros(length(pw_vec),num_change_to_find);
    ObjectiveBenchmarkMat=zeros(length(pw_vec),num_change_to_find);
    numPer=10;
    for j=1:length(pw_vec)
        pw_eff=pw_vec(j);
    tic  
      [~,corrVec]=corrPulse(signal,round(pw_eff*fs),fs);
       tCorr=toc;
       for i=1:numPer
            temp=signal(randperm(length(signal)));
            [~,corrNoise]=corrPulse(temp,round(pw_eff*fs),fs);
           [~,gNoiseObjective,timeNoise(i)] = DynamicProgKnownIntervals(corrNoise,pw_eff,fs,num_change_to_find,length(signal));
           [~,gNoiseCorr,timeNoiseCorr(i)] = MaxCorrelation(corrNoise,pw_eff,fs,num_change_to_find,length(signal));
            NullOurs(i,:)=gNoiseObjective(:,end);
            NullBenchmark(i,:)=gNoiseCorr;
        end
        NullOurs=(mean(NullOurs));
        NullBenchmark=(mean(NullBenchmark));
        tNoiseOurs=sum(timeNoise);
        tNoiseBenchmark=sum(timeNoiseCorr);
        
        %%%%%
        NullOursMat(j,:)=NullOurs;
        NullBenchmarkMat(j,:)=NullBenchmark;
        %%%%%
        
        [Locations,g,timeObjective] = DynamicProgKnownIntervals(corrVec,pw_eff,fs,num_change_to_find,length(signal));
        [BenchmarkLoc,ObjectiveCorr,timeCorr] = MaxCorrelation(corrVec,pw_eff,fs,num_change_to_find,length(signal));
        
        tic
        Locations_Mat{j}=Locations;
        BenchmarkLoc_Mat{j}=BenchmarkLoc;
        %%%%
        temp=g(:,end);
        ObjectiveOursMat(j,:)=temp.';
        ObjectiveBenchmarkMat(j,:)=ObjectiveCorr;
        
        
        
        
        
        t_gapOurs=toc;
        
        tic
        
        
        
        t_gapBecnhmark=toc;
        
        
        timeObjective=timeObjective+tCorr+tNoiseOurs+t_gapOurs;
        timeCorr=timeCorr+tCorr+tNoiseBenchmark+t_gapBecnhmark;
        
    end    
    
    
    %%Mat without falls ours
    tempObjectiveOursMat=zeros(length(pw_vec),num_change_to_find-1);
    for i=1:length(pw_vec)
        gt(i,:)=ObjectiveOursMat(i,1:end-1)<=ObjectiveOursMat(i,2:end);
        tempObjectiveOursMat(i,:)=gt(i,:).*ObjectiveOursMat(i,2:end);
    end
    tempObjectiveOursMat=[ObjectiveOursMat(:,1),tempObjectiveOursMat];
%     for i=1:num_change_to_find
%         gn(:,i)=ObjectiveOursMat(i,1:end-1)<ObjectiveOursMat(2:end,i);
%         a=gn(:,i);
%         a(find(a==0):end)=0;
%         gn(:,i)=a;
%         tempObjectiveOursMat(2:end,i)=gn(:,i).*tempObjectiveOursMat(2:end,i);
%     end
%     
    a=find(tempObjectiveOursMat==0);
    if isempty(a)~=1
        tempObjectiveOursMat(a(1):end)=-inf;
        NullOursMat(a(1):end)=-inf;
    end
    GapOurs=tempObjectiveOursMat-NullOursMat;
     [GapOursN,N_IDX]=(max(GapOurs,[],2));
     
    
    NumChangeOurs=N_IDX;
    
    %%Mat without falls benchmark
    for i=1:length(pw_vec)
        gt(i,:)=ObjectiveBenchmarkMat(i,1:end-1)<=ObjectiveBenchmarkMat(i,2:end);
        tempBenchmarkMat(i,:)=gt(i,:).*ObjectiveBenchmarkMat(i,2:end);
    end
    tempBenchmarkMat=[ObjectiveBenchmarkMat(:,1),tempBenchmarkMat];
%     for i=1:num_change_to_find
%         gn(:,i)=tempObjectiveOursMat(1:end-1,i)<tempObjectiveOursMat(2:end,i);
%         a=gn(:,i);
%         a(find(a==0):end)=0;
%         gn(:,i)=a;
%         tempBenchmarkMat(2:end,i)=gn(:,i).*tempBenchmarkMat(2:end,i);
%     end
%     
    a=find(tempBenchmarkMat==0);
        if isempty(a)~=1

        tempBenchmarkMat(a(1):end)=-inf;
        NullBenchmarkMat(a(1):end)=-inf;
        end
     GapBenchmark=tempBenchmarkMat-NullBenchmarkMat;
     [GapBencharkN,N_IDX_Benchamrk]=(max(GapBenchmark,[],2));
    
    NumChangeBenchmark=N_IDX_Benchamrk;
    [GapOursFull,PW_IDX_Ours]=max(GapOursN);
    pw_ours=pw_vec(PW_IDX_Ours);
    [GapBenchmarkFull,PW_IDX_Benchmark]=max(GapBencharkN);
    pw_benchmark=pw_vec(PW_IDX_Benchmark);
    
%     for i=1:length(pw_vec)
        LocationsOurs=sort(Locations_Mat{PW_IDX_Ours}{NumChangeOurs(PW_IDX_Ours),end});
        LocationsOursKnownK=sort(Locations_Mat{PW_IDX_Ours}{num_change_points,end});
        LocationOursKnownPW=sort(Locations_Mat{floor(length(pw_vec)/2)+1}{NumChangeOurs(floor(length(pw_vec)/2)+1),end});
        
        BenchmarkLocations=sort(BenchmarkLoc_Mat{PW_IDX_Benchmark}(1:min(NumChangeBenchmark(PW_IDX_Benchmark),length(BenchmarkLoc_Mat{PW_IDX_Benchmark}))));
        NumChangeBenchmark=length(BenchmarkLocations);
        
        BenchmarkLocationsKnownPW=sort(BenchmarkLoc_Mat{floor(length(pw_vec)/2)+1}(1:min(N_IDX_Benchamrk(floor(length(pw_vec)/2)+1),length(BenchmarkLoc_Mat{floor(length(pw_vec)/2)+1}))));
        NumChangeBenchmarkKnownPw=length(BenchmarkLocationsKnownPW);
        
        
        
        BenchmarkLocationsKnownK=sort(BenchmarkLoc_Mat{PW_IDX_Benchmark}(1:min(num_change_points,length(BenchmarkLoc_Mat{PW_IDX_Benchmark}))));
        NumChangePointsBenchmarkKnownNumber= min(num_change_points,length(BenchmarkLocationsKnownK));
%     end
    NumChangeOurs=length(LocationsOurs);
%     NumChangeOurs=NumChangeOurs';
%     NumChangeBenchmark=NumChangeBenchmark';
%     NumChangePointsBenchmarkKnownNumber=NumChangePointsBenchmarkKnownNumber';
    
end

