%Written by: Mordechai Roth
%Last updated: Aug 16, 2022

function C = circulant(v)
% Produces same output as gallery('circul', v) but faster because it avoids
% a succession of checks. This code is adapted from Matlab's circul.m.

    % Make v into a row vector
    v = v(:).';
    n = length(v);

    if n == 1
        C = v;
    else
        C = toeplitz([v(1), v(n:-1:2)], v);
    end
    
end
