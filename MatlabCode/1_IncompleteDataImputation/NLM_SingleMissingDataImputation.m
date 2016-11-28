%1¡¢The location of missing value must be input 0; 
%2¡¢Only process single missing value;
%3¡¢Need modify h0, h0 directly determines the degree of filtering
clc;clear;close all;
X=xlsread('demo.xls','B2:B61');   %Time series with missing value 
Y=xlsread('demo.xls','C2:C61');   %Complete population series 
f=5;            %f is neighborhood window
h0=20;         %h0 is gaussian kernel parameter
[m n]=size(Y);

% Replicate the boundaries of the input Y data
Y1 = padarray(Y,f,'symmetric'); 

% normalized kernel weight
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
        X_pre=X(i,1);      %output of the missing data 
    end
end
