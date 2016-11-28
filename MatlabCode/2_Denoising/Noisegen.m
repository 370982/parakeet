%�Ѱ������ӵ��ź���%%%%%%%%%%%%%%%%%
function [X1,NOISE]=Noisegen(X,SNR)    %SNR��Ҫ��������
stream = RandStream.getGlobalStream;  %��ȡĬ�ϵ��������
reset(stream);  %���ã�Ϊ�˱�֤ÿ�������һ��
NOISE=rand(stream,size(X));     %X�Ǵ��ź�
NOISE=NOISE-mean(NOISE);     %NOISE�ǵ������ź��ϵ�����
signal_power=1/length(X)*sum(X.*X);
noise_variance=signal_power/(10^(SNR/10));
NOISE=sqrt(noise_variance)/std(NOISE)*NOISE;
X1=X+NOISE;   %X1�Ǵ����ź�
end
