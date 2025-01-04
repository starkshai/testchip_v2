clear all;
close all;
clc;
format long;
n=6;
% i_u=397.24*1e-9;
% i_sig=2.139*1e-9;%ASIC V1 MC output
i_u=400.2*1e-9;
i_sig=9*1e-9;
num=1000;%number of MC run times
for k=1:num
CurSource=zeros(1,n);
Iout=zeros(1,2^n);
Vout=zeros(1,2^n);
for i=1:n
    for j=1:(2^(i-1))
        CurSource(i)=CurSource(i)+normrnd(i_u,i_sig);
    end    
end
for i=1:2^n
    Dec=dec2bin(i-1,n);
    for j=1:n
        Din(j)=str2num(Dec(j));
    end
    [Iout(i),Vout(i)]=CurSteeringDAC_6b(Din,CurSource,8e3);
end

%calculate DNL/INL
dac_lsb=(Vout(end)-Vout(1))/(2^n-1);
for i=1:2^n-1
    dac_dnl(k,i)=(Vout(i+1)-Vout(i))/dac_lsb-1;
    %dac_inl(k,i)=sum(dac_dnl(1:i));
    dac_inl(k,i)=(Vout(i+1)-(i)*dac_lsb)/dac_lsb;
end

end

%find abs. max. DNL and INL
DNLmax=zeros(1,num);
INLmax=zeros(1,num);
for i=1:num
    if abs(max(dac_dnl(i,:)))>abs(min(dac_dnl(i,:)))
        DNLmax(1,i)=abs(max(dac_dnl(i,:)));
    else
        DNLmax(1,i)=abs(min(dac_dnl(i,:)));
    end
    if abs(max(dac_inl(i,:)))>abs(min(dac_inl(i,:)))
        INLmax(1,i)=abs(max(dac_inl(i,:)));
    else
        INLmax(1,i)=abs(min(dac_inl(i,:)));
    end
end
DNLrms=zeros(1,2^n-1);
INLrms=zeros(1,2^n-1);
for i=1:2^n-1
    DNLrms(i)=rms(dac_dnl(:,i));
    INLrms(i)=rms(dac_inl(:,i));
end
%plot
dec=0:63;
figure(1)
subplot(2,2,1);
histogram(DNLmax);
xlabel('MAX DNL (LSB)');
ylabel('Counts');
title('Current-steering DAC MC simulation');
subplot(2,2,2);
histogram(INLmax);
xlabel('MAX INL (LSB)');
ylabel('Counts');
subplot(2,2,3);
plot(dec(1:63),DNLrms,'b:.');
xlabel('decimal input');
ylabel('RMS DNL (LSB)');
subplot(2,2,4);
plot(dec(1:63),INLrms,'b:.');
xlabel('decimal input');
ylabel('RMS INL (LSB)');

function [Iout,Vout] = CurSteeringDAC_6b(Din,CurSource,R)
Iout=0;
for i=1:6
    Iout=Iout+Din(7-i)*CurSource(i);
end
Vout=Iout*R;
end