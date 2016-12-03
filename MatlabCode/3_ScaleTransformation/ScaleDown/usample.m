% function：升采样 
% Input：采样的原始图像O，升采样系数N
% Output：采样后的图像Oup
function Oup = usample(O,N) 
[row,col] = size(O); 
upcol = col*N; 
upcolnum = upcol - col; 
uprow = row*N; 
uprownum = uprow -row;

If = fft(fft(O).').';     %fft2变换
Ifrow = [If(:,1:col/2) zeros(row,upcolnum) If(:,col/2 +1:col)];  %水平方向中间插零 
%补零之后，Ifrow为 row*upcol
Ifcol = [Ifrow(1:row/2,:);zeros(uprownum,upcol);Ifrow(row/2 +1:row,:)]; %垂直方向补零
Oup = ifft2(Ifcol); 
end 