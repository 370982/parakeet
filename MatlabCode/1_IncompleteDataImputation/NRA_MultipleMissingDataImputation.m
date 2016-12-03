clc;clear;close all;
x=xlsread('demo.xls','B2:B61');     %population
y=xlsread('demo.xls','C2:C61');     %missing value data
figure(1);
plot(x,y,'r.');    
xlabel('Population(10000 persons)');ylabel('PTH(million person- km)');
%----------------------------------------------------------------------
X=xlsread('demo.xls','B2:B61');     %population
Y=xlsread('demo.xls','D2:D61');     %convert missing value data 
figure(2);
plot(X,Y,'r.');    
xlabel('Population(10000 persons)');ylabel('ln(100000*PTH)');
%parameter（a，b）---------------------------------------------------------
lxx=0;
lxy=0;
for i=1:length(X)      
      lxx=lxx+(X(i)-mean(X))^2;        
      lxy=lxy+(X(i)-mean(X))*(Y(i)-mean(Y));  
end
b=lxy/lxx; 
a=mean(Y)-b*mean(X); 
%error-------------------------------------------------------------------
for k = 1:length(X) 
      Y1(k,1) = a+b*X(k);         
      error(k,1) = Y(k)-Y1(k);      
      relaerror(k,1)=abs(error(k,1)/Y(k,1));  
end
figure(3); 
plot(relaerror);
xlabel('Time');ylabel('Relative Error');
%F-test-----------------------------------------------
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
Fa=4.006872886;   %F分布在显著性水平alpha=0.05下的临界值，对照F分布表找，看fe
if F>Fa
    disp('通过检验,回归方程在alpha=0.05的水平下显著。');
else
    disp('不通过检验');
end
%拟合优度的检验-------------------------------------------------------------
RR=SSR/SST;
RRa=1-(SSE/fe)/(SST/ft);    
%前提假设条件的检验(因变量Y正态分布检验）-------------------------------------
alpha=0.05;     %正态分布判断
[mu,sigma]=normfit(Y);
p1=normcdf(Y,mu,sigma);
[H1,s1]=kstest(Y,[Y,p1],alpha);
if H1==0
    disp('该数据服从正态分布。')
else
    disp('该数据不服从正态分布。')
end
%predict------------------------------------------------------------------
X_behind=xlsread('demo.xls','B62:B66');
Y_pre_behind=a+b*(X_behind);
y_pre_behind=exp(Y_pre_behind)/100000;
