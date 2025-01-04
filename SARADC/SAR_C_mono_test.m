clear;
close all;
clc;
format long;
n=10;
vref=1;
vip=3/2^n*vref;
vin=(2^n-3)/2^n*vref;
cnor=[2.^(n-2:-1:0) 1];
sigc=0;
cp=sigc*sqrt(cnor).*randn(1,n)+cnor;
cn=sigc*sqrt(cnor).*randn(1,n)+cnor;
cptot=sum(cp);%total cap. of array
cntot=sum(cn);
D=zeros(1,n);
swp=ones(1,n);%cap. switch
swn=ones(1,n);
vp=vip;%sampling
vn=vin;
if vp>vn % MSB comp.
        D(1)=1;
        swp(1)=0;
else
        D(1)=0;
        swn(1)=0;
end
Dout=2^(n-1)*D(1);
for i=2:n
        vp=((cp*swp')/cptot-1)*vref+vip;
        vn=((cn*swn')/cntot-1)*vref+vin;
    if vp>vn
            D(i)=1;
            swp(i)=0;
    else
            D(i)=0;
            swn(i)=0;
    end
    Dout=Dout+2^(n-i)*D(i);%digital output in dec. format
end