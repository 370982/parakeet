%Add the Gaussian noise into time series
function [X1,NOISE]=Noisegen(X,SNR)
stream = RandStream.getGlobalStream;
reset(stream);
NOISE=rand(stream,size(X));
NOISE=NOISE-mean(NOISE);
signal_power=1/length(X)*sum(X.*X);
noise_variance=signal_power/(10^(SNR/10));
NOISE=sqrt(noise_variance)/std(NOISE)*NOISE;
X1=X+NOISE;
end
