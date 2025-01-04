clear all;
close all;
clc;
format long;
fid=fopen('ROTDC1.matlab');
nline=0;
Nwaveform=1;%number of the waveforms

while ~feof(fid)
   a{nline+1}=fgets(fid);
   nline=nline+1;
end
fclose(fid);
datain=zeros(nline-1,2*Nwaveform);
for i=1:1:nline-1
   raw=str2double(strsplit(a{1,i+1},','));
   for j=1:1:Nwaveform
    datain(i,2*j-1)=raw(1,2*j-1);
    datain(i,2*j)=raw(1,2*j);
   end
end

datainlen=size(datain);

%pick up stages
j=1;
tshift=20e-9;
flag=1;%indicate 20ns addition
for i=1:1:(datainlen(1,1)-1)
    if abs(datain(i,1)-((80e-9)*j)+tshift)< 1e-11
        tmp=round(datain(i,2));
        if (tmp>1000) && (flag==1)%find the transition
            tshift=0;
            flag=0;
        else
            V(j)=tmp;
            j=j+1;
        end
    end
end
%separate MSB and LSB
MSB=zeros(1,201);
HALF=zeros(1,201);
LSB=zeros(1,201);
for i=1:201
    MSB(i)=fix(V(i)/128);
    HALF(i)=fix(V(i)/64-2*MSB(i));
    bintmp=mod(V(i),64);
    LSB(i)=bintmp;
end

x1=0:1:200;
subplot(3,1,1);
plot(x1,LSB);
subplot(3,1,2);
histogram(LSB);
subplot(3,1,3);
%plotyy(x1,MSB,x1,HALF,'plot');
yyaxis left
plot(x1,MSB);
yyaxis right
plot(x1,HALF);