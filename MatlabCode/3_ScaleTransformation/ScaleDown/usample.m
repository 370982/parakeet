% function�������� 
% Input��������ԭʼͼ��O��������ϵ��N
% Output���������ͼ��Oup
function Oup = usample(O,N) 
[row,col] = size(O); 
upcol = col*N; 
upcolnum = upcol - col; 
uprow = row*N; 
uprownum = uprow -row;

If = fft(fft(O).').';     %fft2�任
Ifrow = [If(:,1:col/2) zeros(row,upcolnum) If(:,col/2 +1:col)];  %ˮƽ�����м���� 
%����֮��IfrowΪ row*upcol
Ifcol = [Ifrow(1:row/2,:);zeros(uprownum,upcol);Ifrow(row/2 +1:row,:)]; %��ֱ������
Oup = ifft2(Ifcol); 
end 