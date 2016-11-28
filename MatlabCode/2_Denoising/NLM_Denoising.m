%�㷨ʵ���������ܣ�
%1�����������
%2��ȥ������
close all;clc;clear all;
T=xlsread('demo.xls','A2:A61');    %ʱ������
S=xlsread('demo.xls','B2:B61');    %ԭʼ��������
figure(1);
plot(T,S);axis([1949 2010 1 60]);
xlabel('Year');ylabel('NCE (10000 persons)');grid on;

figure(2);
subplot(2,1,1);
autocorr(S);
subplot(2,1,2);
parcorr(S);

%��׼��������˹������
O=zscore(S);                         %ԭʼ�������ݱ�׼��
[J,NOISE]=Noisegen(O,20);    %���������

% NLMȥ��
J_output=NLMfilter(J,20,5,0.15);     %��˹�˲�������Ϊ0.15
J_out=J_output';          %J_output����ת�òŵõ�J_out����ȥ��������

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

%1�������SNR
snr1=10*log10(sum((O-mean(O)).^2)/sum((O-J).^2));           %ȥ��֮ǰ
snr2=10*log10(sum((O-mean(O)).^2)/sum((O-J_out).^2));    %ȥ��֮��
snr=snr2-snr1;                  %��ߵ�SNR

%2�����������RMSE
[m,n]=size(O);
SRMSE =(sum((O-J_out).^2)/(m)).^0.5;   %ԽС��˵��Խ����
NRMSE=(sum((J-J_out).^2)/(m)).^0.5;     %NRMSEԽ�ӽ�����ˮƽ��ȥ��Ч��Խ��

%3�������ϵ��R
cov=mean(O.*J_out)-(mean(O).*mean(J_out));
R=cov/(std(O)*std(J_out));     %RԽ��ȥ����źź�ԭʼ�ź�Խ����
