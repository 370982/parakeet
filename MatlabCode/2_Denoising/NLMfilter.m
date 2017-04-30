function output = NLMfilter(input,t,f,h)
 %  input is the time series with noise
 %  t is the size of searching window
 %  f is the similar neighbourhood
 %  h is the Gaussian kernel parameters 
[m,n]=size(input);
Output = zeros(m,n);
input2 = padarray(input,f,'symmetric');

%generating kernel weight
kernel=zeros(2*f+1,1);
for d=1:f
	value = 1 / (2 * d + 1)^2;
    for i = -d : d
        kernel(f+1-i)= kernel(f+1-i) + value ; 
    end
end
kernel = kernel / sum(kernel);

h0 = h * h;
for i = 1 : m
    i1=i+f;
    W1= input2(i1-f : i1+f);
    
    wmax = 0;
    average = 0;
    weight = 0;
    
    rmin = max(i1-t, f+1);
    rmax = min(i1+t, m+f);
    
    for r = rmin : rmax
	    if (r==i1)
		    continue; 
        end;
        W2= input2(r-f:r+f);
        d = sum(sum(kernel.*(W1-W2).*(W1-W2)));
        w=exp(-d/h0);
        
        if w>wmax
            wmax=w;
		end
        
        weight = weight + w;
        average = average + w*input2(r);
	end
    
    average = average + wmax*input2(i1);
    weight = weight + wmax;
    output(i) = average / weight;
end   
end