clear;
close all;
clc;
format long;
n=10;vref=1;%initialization
m=4;%point number in each step is 2^m
nin=n+m;
vip=(0:1:2^nin-1)/2^nin*vref;%generate a ramp with uniformly distributed 2^nin voltage values
vin=(2^nin:-1:1)/2^nin*vref;
cnor=[2.^(n-2:-1:0) 1];
sigc=2/100;%dC/C
%sigc=0;%debug
num=100;%number of MC run times
cdev=zeros(num,n);%pre-allocation
D=zeros(num,2^nin);%pre-allocation
for j=1:num
    cdev(j,:)=sigc*sqrt(cnor).*randn(1,n);%refresh the cap. mismatch for each calculation
    cp=cdev(j,:)+cnor;
    cdev(j,:)=sigc*sqrt(cnor).*randn(1,n);
    cn=cdev(j,:)+cnor;
    for i=1:2^nin
        D(j,i)=SAR_C_mono(vref,vip(i),vin(i),n,cp,cn);%calculate digital code
    end
end
%calculate dnl inl
dnl=zeros(num,2^n);
inl=zeros(num,2^n);
N=zeros(1,2^n);
for j=1:num
    for i=1:2^n
        A=(i-1)*ones(num,2^nin);%mask for step i
        E=D(j,:)-A(j,:);% the segment of 0 is the position of step i
        N(i)=2^nin-nnz(E);%length of step i
        dnl(j,i)=N(i)/2^m-1;
        inl(j,i)=sum(dnl(j,(1:i)));
    end
end

%find abs. max. DNL and INL
DNLmax=max(dnl);
DNLmin=min(dnl);
INLmax=max(inl);
INLmin=min(inl);
digout=zeros(1,2^n);
DNL=zeros(1,2^n);
INL=zeros(1,2^n);
DNLrms=zeros(1,2^n);
INLrms=zeros(1,2^n);
for i=1:2^n
    digout(i)=i-1;
    if abs(DNLmax(i)) < abs(DNLmin(i))
        DNL(i)=DNLmin(i);
    else
        DNL(i)=DNLmax(i);
    end
    if abs(INLmax(i)) < abs(INLmin(i))
        INL(i)=INLmin(i);
    else
        INL(i)=INLmax(i);
    end
    DNLrms(i)=rms(dnl(:,i));
    INLrms(i)=rms(inl(:,i));
end

%plot
subplot(2,2,1);
plot(digout,DNL);
xlabel('Digital output');
ylabel('DNL(LSBs)');
grid on;
subplot(2,2,2);
plot(digout,INL);
xlabel('Digital output');
ylabel('INL(LSBs)');
grid on;
subplot(2,2,3);
plot(digout,DNLrms);
xlabel('Digital output');
ylabel('RMS(DNL)(LSBs)');
grid on;
subplot(2,2,4);
plot(digout,INLrms);
xlabel('Digital output');
ylabel('RMS(INL)(LSBs)');
grid on;