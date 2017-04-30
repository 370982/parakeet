%1.The single missing value must be input 0;
%2.The NLM algorithm only processes single missing value;
%3.Need modify parameter h0, it directly determines the degree of filtering.

clc;clear;close all;
X=xlsread('NLTS_Beijing.xlsx','B3:B62');   %time series with missing value 
Y=xlsread('NLTS_Beijing.xlsx','C3:C62');   %complete population time series 
f=5;            %f is the size of neighbourhood window
h0=8;          %h0 is the Gaussian kernel parameter
[m n]=size(Y);

%replicate the boundaries of the input data: Y 
Y1 = padarray(Y,f,'symmetric'); 

%normalized kernel weight
kernel=zeros(2*f+1,1);  
for d=1:f    
  value = 1 / (2 * d + 1)^2 ;    
  for i = -d : d
      kernel(f+1-i)= kernel(f+1-i) + value ; 
  end
end
kernel = kernel / sum(kernel);     

h = h0 * h0;
for i = 1 : m
    if X(i)==0
      W1=Y1(i:i+2*f);   
    end
end
average = 0;
weight = 0;
 
for r = 1 : m
     W2= Y1(r:r+2*f);
     d = sum(kernel.*((W1-W2).*(W1-W2)));
     a=-d/h;
     w=exp(a);
     average = average + w*X(r,1);   
     weight = weight + w;                 
end
 weight = weight-1;

for i = 1 : m
    if X(i)==0
        X(i,1) = average / weight;
        X_pre=X(i,1);      %estimation of missing data
    end
end