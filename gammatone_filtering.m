function [ C, E, fc, ERB ] = gammatone_filtering( S, fmin, fmax, d, ERBb, fs, n, display, verbose)
% [ C, E, fc, fb ] = GAMMATONE_FILTERING( S, fmin, fmax, d, ERBb, fs, n, display, verbose )
%   Complex responses C and envelopes E of a gammatone filterbank defined with
%   gammatone_filterbank( fmin, fmax, d, ERBb, fs, n ), applied to sound S.
%   If display='yes', a display of the output is provided.
%   If verbose='yes', print the processing states.
% %%%% WARNING : ERB doesn't work yet !
%
% Leo Varnet 2016

% default arguments

if nargin<=8
    verbose='no';
end
if nargin<=7
    display='no';
end
if nargin<=6
    n=4410;
end
if nargin<=5
    fs=44100;
end
if nargin<=4
    ERBb=0;
end
if nargin<=3
    d=1;
end
if nargin<=2
    error('Not enough input arguments! Correct syntax for this function is: gammatone_filtering( S, fmin, fmax, ...).');
end

if isyes(verbose)
    fprintf('\ngenerating the gammatone filterbank\n');
end
[gammatones, fc, ERB] = gammatone_filterbank( fmin, fmax, d, ERBb, fs, n );
[ C, E] = apply_gammatone_filterbank(S, gammatones, fs, fc, display, verbose);

end

