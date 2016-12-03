function output = NLMfilter(input,t,f,h)
 %  input����������
 %  t���������Ĵ�С 20
 %  f�����ƿ�����5
 %  h����˹�˵Ĳ���3
[m,n]=size(input);
Output = zeros(m, n);
input2 = padarray(input,f,'symmetric');    %��������߽�
% ���ɺ�Ȩ��%%%%%%%%%%%%
kernel=zeros(2*f+1,1);   
for d=1:f
    value = 1 / (2 * d + 1)^2;
    for i = -d : d
        kernel(f+1-i)= kernel(f+1-i) + value ; 
    end
end
kernel = kernel / sum(kernel);      %��һ����Ȩ��

h0 = h * h;
for i = 1 : m
    i1=i+f;   
    W1= input2(i1-f : i1+f);           
    
    wmax = 0;
    average = 0;
    weight = 0;
    
    rmin = max(i1-t, f+1);   %������������Χ
    rmax = min(i1+t, m+f);
    
    for r = rmin : rmax
        if (r==i1)       %�뵱ǰλ���غ�
            continue; 
        end;
        W2= input2(r-f:r+f);
        d = sum(sum(kernel.*(W1-W2).*(W1-W2)));
        w=exp(-d/h0);
        
        if w>wmax        %��ǰλ��������w
            wmax=w;
        end
        
        weight = weight + w;               %Ȩ����ӵĺ�
        average = average + w*input2(r);   %Ȩ�س���Ԫ��ֵ��ӵĺ�
    end
    
    average = average + wmax*input2(i1);   %����ǰλ��
    weight = weight + wmax;
    output(i) = average / weight;
end   
end       

