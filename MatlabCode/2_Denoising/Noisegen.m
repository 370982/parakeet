%把白噪声加到信号上%%%%%%%%%%%%%%%%%
function [X1,NOISE]=Noisegen(X,SNR)    %SNR是要求的信噪比
stream = RandStream.getGlobalStream;  %获取默认的随机种子
reset(stream);  %重置，为了保证每次随机数一致
NOISE=rand(stream,size(X));     %X是纯信号
NOISE=NOISE-mean(NOISE);     %NOISE是叠加在信号上的噪声
signal_power=1/length(X)*sum(X.*X);
noise_variance=signal_power/(10^(SNR/10));
NOISE=sqrt(noise_variance)/std(NOISE)*NOISE;
X1=X+NOISE;   %X1是带噪信号
end
