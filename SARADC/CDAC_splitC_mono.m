clear;
close all;
clc;
format long;
n=10;vref=1;%initialization
m=4;%point number in each step is 2^m
nin=n+m;
%vip=(0:1:2^nin-1)/2^nin*vref*512/511;%generate a ramp with uniformly distributed 2^nin voltage values
%vin=(2^nin:-1:1)/2^nin*vref*512/511;%bridge cap. enlarge the range with the gain of 512/511
vip=vref/2+(-2^(nin-1):1:2^(nin-1)-1)/2^nin*vref*512/511;%use new structure of ramp
vin=vref/2+(2^(nin-1):-1:-2^(nin-1)+1)/2^nin*vref*512/511;
cnor=[32 16 8 4 2 1 4 2 1 1];%6MSB 3LSB Cb
%sigc=1/100;%dC/C
sigc=0;%debug
num=1;%number of MC run times
cdev=zeros(num,n);%pre-allocation
D=zeros(num,2^nin);%pre-allocation
for j=1:num
    cdev(j,:)=sigc*sqrt(cnor).*randn(1,n);%refresh the cap. mismatch for each calculation
    cp=cdev(j,:)+cnor;
    cdev(j,:)=sigc*sqrt(cnor).*randn(1,n);
    cn=cdev(j,:)+cnor;
    for i=1:2^nin
        D(j,i)=SAR_splitC_mono(vref,vip(i),vin(i),cp,cn);%calculate digital code
    end
end