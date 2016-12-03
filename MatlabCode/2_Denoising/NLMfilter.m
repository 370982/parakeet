function output = NLMfilter(input,t,f,h)
 %  input：带噪数据
 %  t：搜索窗的大小 20
 %  f：相似块邻域5
 %  h：高斯核的参数
[m,n]=size(input);
Output = zeros(m, n);
input2 = padarray(input,f,'symmetric');    %复制输出边界
% 生成核权重%%%%%%%%%%%%
kernel=zeros(2*f+1,1);   
for d=1:f
    value = 1 / (2 * d + 1)^2;
    for i = -d : d
        kernel(f+1-i)= kernel(f+1-i) + value ; 
    end
end
kernel = kernel / sum(kernel);      %归一化核权重

h0 = h * h;
for i = 1 : m
    i1=i+f;   
    W1= input2(i1-f : i1+f);           
    
    wmax = 0;
    average = 0;
    weight = 0;
    
    rmin = max(i1-t, f+1);   %划定搜索窗范围
    rmax = min(i1+t, m+f);
    
    for r = rmin : rmax
        if (r==i1)       %与当前位置重合
            continue; 
        end;
        W2= input2(r-f:r+f);
        d = sum(sum(kernel.*(W1-W2).*(W1-W2)));
        w=exp(-d/h0);
        
        if w>wmax        %当前位置是最大的w
            wmax=w;
        end
        
        weight = weight + w;               %权重相加的和
        average = average + w*input2(r);   %权重乘以元素值相加的和
    end
    
    average = average + wmax*input2(i1);   %处理当前位置
    weight = weight + wmax;
    output(i) = average / weight;
end   
end       

