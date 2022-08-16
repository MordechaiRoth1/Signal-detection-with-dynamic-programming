%Written by: Mordechai Roth
%Last updated: Aug 16, 2022

function [Value,corrVec] = corrPulse(signal,pw,fs)
%This function is for the correlation of a signal with a pulse. The pulse
%represents the location of the particle;
%   Detailed explanation goes here

if length(signal)*fs<pw
    Value=-inf;
else
    ref=ones(1,(pw));
    corrVec=xcorr(signal,ref);
    corrVec=corrVec(numel(signal):end);
    Value=corrVec(numel(signal));
end

