%NLM algorithm denoising has two steps:
%1.add the noise;
%2.remove the noise;
close all;clc;clear all;
T=xlsread('NCE_Beijing.xlsx','A3:A62');    %time series
S=xlsread('NCE_Beijing.xlsx','B3:B62');    %original data
figure(1);
plot(T,S);axis([1949 2010 1 60]);
xlabel('Year');ylabel('NCE (10000 persons)');grid on;

figure(2);
subplot(2,1,1);
autocorr(S);
subplot(2,1,2);
parcorr(S);

O=zscore(S);                 %original data standardized
[J,NOISE]=Noisegen(O,20);    %add Gaussian noise

%denoise using NLM algorithm
J_output=NLMfilter(J,20,5,0.15); 
J_out=J_output';             %J_out is the time series after denoising

figure(3);
subplot 411;plot(T,O);axis([1949 2010 -1.5 3]);
xlabel('Year');ylabel('Normalized Data');grid on;
subplot 412;plot(T,NOISE);axis([1949 2010 -1 1]);
xlabel('Year');ylabel('Noise');grid on;
subplot 413;plot(T,J);axis([1949 2010 -1.5 3]);
xlabel('Year');ylabel('Normalized Data with Noise');grid on;
subplot 414;plot(T,J_out);
axis([1949 2010 -1.5 3]);
xlabel('Year');ylabel('NLM Denoising');grid on;

%SNR
snr1=10*log10(sum((O-mean(O)).^2)/sum((O-J).^2));        %before denoising
snr2=10*log10(sum((O-mean(O)).^2)/sum((O-J_out).^2));    %after denoising
snr=snr2-snr1;                                           %improved SNR

%RMSE
[m,n]=size(O);
SRMSE =(sum((O-J_out).^2)/(m)).^0.5;   
NRMSE=(sum((J-J_out).^2)/(m)).^0.5;

%R
cov=mean(O.*J_out)-(mean(O).*mean(J_out));
R=cov/(std(O)*std(J_out));
