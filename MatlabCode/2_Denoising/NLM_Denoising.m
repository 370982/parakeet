%算法实现两个功能：
%1、添加噪声；
%2、去除噪声
close all;clc;clear all;
T=xlsread('demo.xls','A2:A61');    %时间序列
S=xlsread('demo.xls','B2:B61');    %原始序列数据
figure(1);
plot(T,S);axis([1949 2010 1 60]);
xlabel('Year');ylabel('NCE (10000 persons)');grid on;

figure(2);
subplot(2,1,1);
autocorr(S);
subplot(2,1,2);
parcorr(S);

%标准化后加入高斯白噪声
O=zscore(S);                         %原始序列数据标准化
[J,NOISE]=Noisegen(O,20);    %加入白噪声

% NLM去噪
J_output=NLMfilter(J,20,5,0.15);     %高斯核参数设置为0.15
J_out=J_output';          %J_output必须转置才得到J_out，即去噪后的序列

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

%1：信噪比SNR
snr1=10*log10(sum((O-mean(O)).^2)/sum((O-J).^2));           %去噪之前
snr2=10*log10(sum((O-mean(O)).^2)/sum((O-J_out).^2));    %去噪之后
snr=snr2-snr1;                  %提高的SNR

%2：均方根误差RMSE
[m,n]=size(O);
SRMSE =(sum((O-J_out).^2)/(m)).^0.5;   %越小，说明越相似
NRMSE=(sum((J-J_out).^2)/(m)).^0.5;     %NRMSE越接近噪声水平，去噪效果越好

%3：互相关系数R
cov=mean(O.*J_out)-(mean(O).*mean(J_out));
R=cov/(std(O)*std(J_out));     %R越大，去噪后信号和原始信号越相似
