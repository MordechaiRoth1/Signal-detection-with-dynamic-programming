%Written by: Mordechai Roth
%Last updated: Aug 16, 2022

clear all;
clc;
close all;

rng(120)
osf=1.5;
MeasurementLength=osf;
num_signals=1;
sparseFlag=0;
signal_length=75;
snr=1; %not really, just used for initilaizing the signal creation with chosen noise later on
num_change_points=3;
num_change_to_find=2*num_change_points;
max_times=1e3;
Template_Length=1e-3*osf;
signal_flag=1;
varStep=0;
initialVariance=1e-12;
FinalVariance=2;
VarianceJump=1/6;
pwVec=0.5*MeasurementLength:10:1.5*MeasurementLength;
VarVec=(initialVariance:VarianceJump:FinalVariance);
density=8/15;

% num_change_points_vec=8:4:3900;    
% signal_length_vec=round((num_change_points_vec/density)*MeasurementLength);


numVar=length(VarVec);
pw=Template_Length;
fs=1e4;
% pw_eff=[0.8*pw,1*pw,1.2*pw];
pw_eff=pw;
% load('ChangePointsPool_8_lengthTemplate10_lengthSignal150.mat');



%%
       %% preallocate all
 change_points_var_num_tot=3;   
 SNR_F1score=zeros(numVar,change_points_var_num_tot);        
 SNR_F1scoreSR=zeros(numVar,change_points_var_num_tot);        

 SNR_F1scoreBemchmark=zeros(numVar,change_points_var_num_tot);        
 SNR_F1scoreBemchmarkKnown=zeros(numVar,change_points_var_num_tot);        
 SNR_F1scoreBemchmarkKnownPW=zeros(numVar,change_points_var_num_tot);        

 SNR_F1scoreOursKnown=zeros(numVar,change_points_var_num_tot);        
 SNR_F1scoreOursKnownPW=zeros(numVar,change_points_var_num_tot);        

 SNR_F1scoreRandom=zeros(numVar,change_points_var_num_tot);        
 
 SNR_Precision=zeros(numVar,change_points_var_num_tot);        
 SNR_PrecisionSR=zeros(numVar,change_points_var_num_tot);        
 SNR_PrecisionBemchmark=zeros(numVar,change_points_var_num_tot);        
 SNR_PrecisionBemchmarkKnown=zeros(numVar,change_points_var_num_tot);        
 SNR_PrecisionBemchmarkKnownPW=zeros(numVar,change_points_var_num_tot);        
 SNR_PrecisionOursKnown=zeros(numVar,change_points_var_num_tot);        
 SNR_PrecisionOursKnownPW=zeros(numVar,change_points_var_num_tot);        

 SNR_PrecisionRandom=zeros(numVar,change_points_var_num_tot);        
 
 SNR_RandBenchmark=zeros(numVar,change_points_var_num_tot);        
 SNR_RandBenchmarkKnownNumber=zeros(numVar,change_points_var_num_tot);        
 SNR_RandOurKnownNumber=zeros(numVar,change_points_var_num_tot);        
 SNR_RandOursFull=zeros(numVar,change_points_var_num_tot);        
 SNR_RandRandom=zeros(numVar,change_points_var_num_tot);        
 
 SNR_Recall=zeros(numVar,change_points_var_num_tot);        
 SNR_RecallSR=zeros(numVar,change_points_var_num_tot);        
 SNR_RecallBemchmark=zeros(numVar,change_points_var_num_tot);        
 SNR_RecallBemchmarkKnown=zeros(numVar,change_points_var_num_tot);        
 SNR_RecallBemchmarkKnownPW=zeros(numVar,change_points_var_num_tot);        

 SNR_RecallOursKnown=zeros(numVar,change_points_var_num_tot);        
 SNR_RecallOursKnownPW=zeros(numVar,change_points_var_num_tot);        

 SNR_RecallRandom=zeros(numVar,change_points_var_num_tot);        
 
 
 
 numChangeFoundBenchmark=zeros(numVar,change_points_var_num_tot);        
 numChangeFoundOurs=zeros(numVar,change_points_var_num_tot); 
 numChangeFoundSR=zeros(numVar,change_points_var_num_tot); 
 
 SNR_PWours=zeros(numVar,change_points_var_num_tot);
 SNR_PWbenchmark=zeros(numVar,change_points_var_num_tot);
 
 SNR_Iours=zeros(numVar,change_points_var_num_tot);
 SNR_Ibenchmark=zeros(numVar,change_points_var_num_tot);
 SNR_IoursKnown=zeros(numVar,change_points_var_num_tot);
 SNR_IbenchmarkKnown=zeros(numVar,change_points_var_num_tot);
%%

for k=1:1
    change_points_var_num=k;
    %% alocate
    L=1;
    pw_ours=zeros(max_times,L);
    pw_benchmark=zeros(max_times,L);
    
    RandBenchmark=zeros(max_times,L);
    RandOursFull=zeros(max_times,L);
    RandOurKnownNumber=zeros(max_times,L);
    RandBenchmarkKnownNumber=zeros(max_times,L);
    RandRandom=zeros(max_times,L);
    
    F1score=zeros(max_times,L);
    F1scoreSR=zeros(max_times,L);
    F1scoreBemchmark=zeros(max_times,L);
    F1scoreBemchmarkKnown=zeros(max_times,L);
    F1scoreBemchmarkKnownPW=zeros(max_times,L);

    F1scoreOursKnown=zeros(max_times,L);
    F1scoreOursKnownPW=zeros(max_times,L);

    F1scoreRandom=zeros(max_times,L);
    
    Prec=zeros(max_times,L);
    PrecSR=zeros(max_times,L);
    PrecBemchmark=zeros(max_times,L);
    PrecBemchmarkKnown=zeros(max_times,L);
    PrecOursKnown=zeros(max_times,L);
    PrecBemchmarkKnownPW=zeros(max_times,L);
    PrecOursKnownPW=zeros(max_times,L);
    PrecRandom=zeros(max_times,L);
    
    Rec=zeros(max_times,L);
    RecSR=zeros(max_times,L);
    RecBemchmark=zeros(max_times,L);
    RecBemchmarkKnown=zeros(max_times,L);
    RecOursKnown=zeros(max_times,L);
    
    RecBemchmarkKnownPW=zeros(max_times,L);
    RecOursKnownPW=zeros(max_times,L);
    
    RecRandom=zeros(max_times,L);
    
    NumChangeOurs=zeros(max_times,L);
    NumChangeBenchmark=zeros(max_times,L);
    num_change_found_SR=zeros(max_times,L);
    %% 
%     varianceAmp=initialVariance;

        for varianceAmp=VarVec
%             varianceAmp=initialVariance;
            varStep=varStep+1;
            timeOurs=zeros(1,max_times);
            timeBenchmark=zeros(1,max_times);
%             if varStep>=2
%             num_change_points=num_change_points*2;
%             num_change_to_find=num_change_to_find*2;
%             signal_length=signal_length*2;
%             end
        for times=1:max_times
%            [~,Yclean,t,fs,changeIdx,pw] =unsynchronized_pulses_func(num_change_points,num_signals,snr,signal_length,Template_Length);
%             Yclean=Yclean(1:signal_length);
              Terminate=1;
           while Terminate==1
%                 changeIdx=DrawChangePoints(pw,fs,signal_length,num_change_points)+1;
                
                [changeIdx,Terminate] = DrawChangePoints_220522v2(pw,fs,signal_length,num_change_points,sparseFlag);
                changeIdx=changeIdx+1;
           end

            YcleanCreate;
            noise=wgn(1,signal_length,pow2db(varianceAmp));
            
            Y=signal_flag*Yclean(1:signal_length)+noise(1:signal_length);
        
            signal=Y.';
            SignalNoNoise=Yclean.';
            num_change_to_find=num_change_points*2;
            
            ActualChangePoint=changeIdx';
%             PwOptions=pw*[0.8,1,1.3];
% PwOptions=pw*[1,1,1];
            PwOptions=pw;
            
          
%             [LocationsOurs,LocationsOursKnownK,LocationsOursKnownPW,BenchmarkLocations,BenchmarkLocationsKnownK,BenchmarkLocationsKnownPW,tempObjectiveOursMat,tempBenchmarkMat,timeObjective,timeCorr,NullOursMat,...
%              NullBenchmarkMat,NumChangeOurs(times,:),NumChangePointsBenchmarkFull(times,:),NumChangePointsBenchmarkKnownNumber(times,:)] = KnownIntervals_5(signal,pw,fs,num_change_points,num_change_to_find,0);
%             
            
            for l=1:1
            [LocationsOurs,pw_ours(times,l),LocationsOursKnownK,LocationsOursKnownPW,BenchmarkLocations,pw_benchmark(times,l),BenchmarkLocationsKnownK,BenchmarkLocationsKnownPW,tempObjectiveOursMat,tempBenchmarkMat,timeObjective,timeCorr,NullOursMat,...
             NullBenchmarkMat,NumChangeOurs(times,l),NumChangePointsBenchmarkFull(times,l),NumChangePointsBenchmarkKnownNumber(times,l)] = KnownIntervals_5(signal,PwOptions(l),fs,num_change_points,num_change_to_find,1);
            
            LocationsOursFull=LocationsOurs;
            LocationsOursKnownNumber=LocationsOursKnownK;
            LocationBenchmarkFull=BenchmarkLocations;
            LocationBenchmarkKnownNumber=BenchmarkLocationsKnownK;
%             RandomChangePoints=DrawChangePoints(pw,fs,signal_length,num_change_points);
            
            
            %%Super Resolution
            [x] = SuperResolutionFunV1(signal,MeasurementLength,var(noise)*signal_length);
            
            [TempLoc,ObjectiveCorr,~] = MaxCorrelation(x,pw,fs,num_change_to_find,length(signal));
%             for per=1:10
%                 [xnoise] = SuperResolutionFun(signal(randperm(length(signal))),MeasurementLength);
%                 [~,ObjectiveCorrNull(per,:),~] = MaxCorrelation(xnoise,pw,fs,num_change_to_find,length(signal));
%             end
%             NullSR=(mean(ObjectiveCorrNull));
            
%             GapSR=ObjectiveCorr-NullSR;
%             a=min(find(diff(ObjectiveCorr)<=1e-5));
%             [~,num_change_found_SR(times)]=(max(GapSR(1:a),[],2));
%             num_change_found_SR(times)=min(num_change_points,a);
            num_change_found_SR(times)=min(num_change_points,length(TempLoc));

%             num_change_found_SR(times)=min(find(diff(ObjectiveCorr)<=1e-5));
            Signal_Start_SR=TempLoc(1:num_change_found_SR(times))-round(pw*fs);
            %%
            
            
            
            %% Calcualte Recall, Precision and F1-score
            [RecSR(times,l),PrecSR(times,l),F1scoreSR(times,l)] = F1_score_4(num_change_points,num_change_found_SR(times),ActualChangePoint,Signal_Start_SR,50,round(pw*fs),round(pw*fs),signal_length) ;
            [Rec(times,l),Prec(times,l),F1score(times,l)] = F1_score_4(num_change_points,NumChangeOurs(times,l),ActualChangePoint,LocationsOursFull,50,round(pw*fs),round(pw_ours(times,l)*fs),signal_length) ;
            [RecOursKnown(times,l),PrecOursKnown(times,l),F1scoreOursKnown(times,l)] = F1_score_4(num_change_points,num_change_points,ActualChangePoint,LocationsOursKnownNumber,50,round(pw*fs),round(PwOptions(l)*fs),signal_length) ;
            [RecOursKnownPW(times,l),PrecOursKnownPW(times,l),F1scoreOursKnownPW(times,l)] = F1_score_4(num_change_points,length(LocationsOursKnownPW),ActualChangePoint,LocationsOursKnownPW,50,round(pw*fs),round(PwOptions(l)*fs),signal_length) ;
            [RecBemchmark(times,l),PrecBemchmark(times,l),F1scoreBemchmark(times,l)] = F1_score_4(num_change_points,NumChangePointsBenchmarkFull(times,l),ActualChangePoint,LocationBenchmarkFull,50,round(pw*fs),round(pw_benchmark(times,l)*fs),signal_length) ;
            [RecBemchmarkKnownPW(times,l),PrecBemchmarkKnownPW(times,l),F1scoreBemchmarkKnownPW(times,l)] = F1_score_4(num_change_points,length(BenchmarkLocationsKnownPW),ActualChangePoint,BenchmarkLocationsKnownPW,50,round(pw*fs),round(PwOptions(l)*fs),signal_length) ;
            [RecBemchmarkKnown(times,l),PrecBemchmarkKnown(times,l),F1scoreBemchmarkKnown(times)] = F1_score_4(num_change_points,NumChangePointsBenchmarkKnownNumber(times,l),ActualChangePoint,LocationBenchmarkKnownNumber,50,round(pw*fs),round(PwOptions(l)*fs),signal_length) ;
%             [RecRandom(times,l),PrecRandom(times,l),F1scoreRandom(times,l)] = F1_score(num_change_points,num_change_points,ActualChangePoint,RandomChangePoints,50,round(pw*fs)) ;
%             [RecRandom(times,l),PrecRandom(times,l),F1scoreRandom(times,l)] = F1_score_4(num_change_points,num_change_points,ActualChangePoint,RandomChangePoints,50,round(pw*fs),round(PwOptions(l)*fs),signal_length) ;
        
            %% Calcualte Rand-Index
%                 [Partition] = PartitionChange(ActualChangePoint,num_change_points,length(signal));
%                 [PartitionOursFull] = PartitionChange(LocationsOursFull,NumChangeOurs(times,l),length(signal));
%                 [PartitionOurKnownNumber] = PartitionChange(LocationsOursKnownNumber,num_change_points,length(signal));
%                 [PartitionBenchmark] = PartitionChange(LocationBenchmarkFull,NumChangePointsBenchmarkFull(times,l),length(signal));
%                 [PartitionBenchmarkKnownNumber] = PartitionChange(LocationBenchmarkKnownNumber,NumChangePointsBenchmarkKnownNumber(times,l),length(signal));
%                 [PartitionRandom] = PartitionChange(RandomChangePoints,num_change_points,length(signal));
                
%                 RandOursFull(times,l)=rand_index(Partition,PartitionOursFull);
%                 RandOurKnownNumber(times,l)=rand_index(Partition,PartitionOurKnownNumber);
%                 RandBenchmark(times,l)=rand_index(Partition,PartitionBenchmark);
%                 RandBenchmarkKnownNumber(times,l)=rand_index(Partition,PartitionBenchmarkKnownNumber);
%                 RandRandom(times,l)=rand_index(Partition,PartitionRandom);
                
            end
            
            
            waitbar((times+(varStep-1)*max_times)/(max_times*numVar))
                
            %% 
        
        
    
        end
   
%     
    for l=1:1
    SNR_F1score(varStep,l)=mean(F1score(:,l));
    SNR_F1scoreSR(varStep,l)=mean(F1scoreSR(:,l));
    SNR_F1scoreOursKnown(varStep,l)=mean(F1scoreOursKnown(:,l));
    SNR_F1scoreOursKnownPW(varStep,l)=mean(F1scoreOursKnownPW(:,l));
    SNR_F1scoreBemchmark(varStep,l)=mean(F1scoreBemchmark(:,l));
    SNR_F1scoreBemchmarkKnown(varStep,l)=mean(F1scoreBemchmarkKnown(:,l));
    SNR_F1scoreBemchmarkKnownPW(varStep,l)=mean(F1scoreBemchmarkKnownPW(:,l));

%     SNR_F1scoreRandom(varStep,l)=mean(F1scoreRandom(:,l));
    
    
    SNR_Recall(varStep,l)=mean(Rec(:,l));
    SNR_RecallSR(varStep,l)=mean(RecSR(:,l));
    SNR_RecallOursKnown(varStep,l)=mean(RecOursKnown(:,l));
    SNR_RecallOursKnownPW(varStep,l)=mean(RecOursKnownPW(:,l));
    SNR_RecallBemchmark(varStep,l)=mean(RecBemchmark(:,l));
    SNR_RecallBemchmarkKnown(varStep,l)=mean(RecBemchmarkKnown(:,l));
    SNR_RecallBemchmarkKnownPW(varStep,l)=mean(RecBemchmarkKnownPW(:,l));

%     SNR_RecallRandom(varStep,l)=mean(RecRandom(:,l));

    
    
    SNR_PrecisionSR(varStep,l)=mean(PrecSR(:,l));
    SNR_PrecisionOursKnown(varStep,l)=mean(PrecOursKnown(:,l));
    SNR_PrecisionOursKnownPW(varStep,l)=mean(PrecOursKnownPW(:,l));
    SNR_PrecisionBemchmark(varStep,l)=mean(PrecBemchmark(:,l));
    SNR_PrecisionBemchmarkKnown(varStep,l)=mean(PrecBemchmarkKnown(:,l));
    SNR_PrecisionBemchmarkKnownPW(varStep,l)=mean(PrecBemchmarkKnownPW(:,l));

%     SNR_PrecisionRandom(varStep,l)=mean(PrecRandom(:,l));
    
    SNR_PWours(varStep,l)=mean(pw_ours(:,l));

    SNR_PWbenchmark(varStep,l)=mean(pw_benchmark(:,l));

    
%     SNR_RandOursFull(varStep,l)=mean(RandOursFull(:,l));
%     SNR_RandOurKnownNumber(varStep,l)=mean(RandOurKnownNumber(:,l));
%     SNR_RandBenchmark(varStep,l)=mean(RandBenchmark(:,l));
%     SNR_RandBenchmarkKnownNumber(varStep,l)=mean(RandBenchmarkKnownNumber(:,l));
%     SNR_RandRandom(varStep,l)=mean(RandRandom(:,l));

    
    numChangeFoundOurs(varStep,l)=mean(NumChangeOurs(:,l));
%     maxChangeOurs(varStep,change_points_var_num)=max(NumChangeOurs(:,l)); 
%     minChangeOurs(varStep,change_points_var_num)=min(NumChangeOurs(:,l));
%     
    numChangeFoundBenchmark(varStep,l)=mean(NumChangePointsBenchmarkFull(:,l));
%     maxChangeBenchmark(varStep,change_points_var_num)=max(NumChangePointsBenchmarkFull); 
%     minChangeBenchmark(varStep,change_points_var_num)=min(NumChangePointsBenchmarkFull);
%     
%     timeOur(varStep,change_points_var_num)=mean(timeOurs);
%     timeBenchmarkFull(varStep,change_points_var_num)=mean(timeBenchmark);
    numChangeFoundSR(varStep,l)=mean(num_change_found_SR(:,l));
        
    end
        
    end
end

save  'Run140822_convex'
% exit;