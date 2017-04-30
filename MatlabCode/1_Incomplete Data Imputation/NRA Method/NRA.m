clc;clear;close all;
x=xlsread('PCV_Hebei.xlsx','B6:B62');     %x is population data
y=xlsread('PCV_Hebei.xlsx','C6:C62');     %y is missing value data
figure(1);
plot(x,y,'r.');    
xlabel('Population(10 000 persons)');ylabel('PCV(10 000 units)');

X=xlsread('PCV_Hebei.xlsx','B6:B62');     %population
Y=xlsread('PCV_Hebei.xlsx','D6:D62');     %converted missing value data 
figure(2);
plot(X,Y,'r.');    
xlabel('Population(10 000 persons)');ylabel('ln(10 000*PCV)');
%parameter(a,b)
lxx=0;
lxy=0;
for i=1:length(X)      
      lxx=lxx+(X(i)-mean(X))^2;        
      lxy=lxy+(X(i)-mean(X))*(Y(i)-mean(Y));  
end
b=lxy/lxx; 
a=mean(Y)-b*mean(X); 
%Error
for k = 1:length(X) 
      Y1(k,1) = a+b*X(k);         
      error(k,1) = Y(k)-Y1(k);      
      relaerror(k,1)=abs(error(k,1)/Y(k,1));  
end
figure(3); 
plot(relaerror);
xlabel('Time');ylabel('Relative Error');
%F-test
SST=0;
SSE=0;
for i=1:length(X)      
    SST=SST+(Y(i)-mean(Y))^2;  
    SSE=SSE+(Y(i)-Y1(i))^2;     
end
SSR=SST-SSE;
ft=length(X)-1;   
fe=length(X)-2;
fr=1;
F=(SSR/fr)/(SSE/fe);
Fa=4.016195493;
if F>Fa
    disp('Pass the F-test');
else
    disp('Do not pass the F-test');
end
%Goodness-of-fit test
RR=SSR/SST;
RRa=1-(SSE/fe)/(SST/ft);    
%Normal distribution test of Y
alpha=0.05;
[mu,sigma]=normfit(Y);
p1=normcdf(Y,mu,sigma);
[H1,s1]=kstest(Y,[Y,p1],alpha);
if H1==0
    disp('Y obeys the normal distribution.')
else
    disp('Y does not obey the normal distribution.')
end
%prediction
X_before=xlsread('PCV_Hebei.xlsx','B3:B5');
Y_pre_before=a+b*(X_before);
y_pre_before=exp(Y_pre_before)/10000

X_behind=xlsread('PCV_Hebei.xlsx','B63:B67');
Y_pre_behind=a+b*(X_behind);
y_pre_behind=exp(Y_pre_behind)/10000;
