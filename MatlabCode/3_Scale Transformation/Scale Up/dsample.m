%function:down-sampling
function Odown = dsample(O,N)
[row,col] = size(O);
drow = round(row/N);
dcol = round(col/N);
Odown = zeros(drow,dcol);
p =1; q =1;
for i = 1:N:row
    for j = 1:N:col
		Odown(p,q) = O(i,j);
        q = q+1;
	end
	q =1;
	p = p+1;
end
end