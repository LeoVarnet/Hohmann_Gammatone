function [ C, E] = apply_gammatone_filterbank(S, gammatones, fs, fc, display, verbose)
% [ C, E ] = APPLY_GAMMATONE_FILTERBANK( S, gammatones )
%   Applies the gammatone filterbank with impulse responses defined in
%   gammatones (generated using the function gammatone_filterbank) to the
%   sound S
%   Can be used as 
% [ C, E ] = APPLY_GAMMATONE_FILTERBANK (S, gammatones, fs, display, verbose)
%   If display='yes', a display of the output is provided.
%   If verbose='yes', print the processing states.
%
% This function requires the functions isyes.m and plot_channel.m from the
% toolbox MFB model (https://github.com/LeoVarnet/MFB_Model)
%
% Leo Varnet 2020

% default arguments

if nargin<=2
    fs=[];
end
if nargin<=3
    fc=[];
end
if nargin<=4
    display='no';
end
if nargin<=5
    verbose='no';
end

Nfilters = size(gammatones,1);
Nsamples = length(S);
C = zeros(Nsamples,Nfilters);

for i_filter=1:Nfilters
    if isyes(verbose)
        fprintf(['filtering (gammatone ' num2str(i_filter) ' of ' num2str(Nfilters) ')\n']);
    end
    gammatone_response = filter((gammatones(i_filter,:)),1,S);
    gammatone_response=gammatone_response(:);
    % delay correction
    [~,samples_delay] = max(abs(gammatones(i_filter,:)));
    gammatone_response_correct = [gammatone_response; zeros(samples_delay,1)];
    gammatone_response_correct = gammatone_response_correct(end-Nsamples+1 : end);
    C(:,i_filter) = gammatone_response_correct;
end

E = abs(C);

if isyes(display)
    figure;
    plot_channels((1:Nsamples)/fs,E,1:5);hold on
    plot_channels((1:Nsamples)/fs,real(C),1:5);
%     for i_filter=1:Nfilters
%         subplot(Nfilters,1,i_filter);
%         plot((1:Nsamples)/fs,E(:,i_filter)/max(E(:,i_filter)),'b',(1:Nsamples)/fs,real(C(:,i_filter))/max(real(C(:,i_filter))),'r');
%         title(['response of the gammatone filter at ' num2str(fc(i_filter)) ' Hz'])
%     end
end

end

