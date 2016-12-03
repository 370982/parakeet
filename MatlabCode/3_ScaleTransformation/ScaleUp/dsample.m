% function：降采样
% Input：采样原始图像O，降采样系数N
% Output：采样后的图像为Odown
function Odown = dsample(O,N) 
[row,col] = size(O); 
drow = round(row/N); 
dcol = round(col/N); 
Odown = zeros(drow,dcol); 
p =1; q =1;        %采样后新图像的行列数
for i = 1:N:row 
    for j = 1:N:col 
        Odown(p,q) = O(i,j); 
        q = q+1;   %按行隔点采样
    end
    q =1;
    p = p+1; 
end
end