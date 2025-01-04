clear all;
close all;
clc;
format long;
t=pi*(0:0.05:4);
y1=cos(t);
y2=cos(t+2*pi/3);
y3=cos(t+4*pi/3);
tmp=size(t);
tsize=tmp(2);
c1=zeros(1,tsize);
c2=zeros(1,tsize);
c3=zeros(1,tsize);
c21=zeros(1,tsize);
c13=zeros(1,tsize);
c23=zeros(1,tsize);
rawcode=zeros(1,tsize);
for i=1:1:tsize
   if y1(i)>=0
        c1(i)=1;
   end
   if y2(i)>=0
        c2(i)=1;
   end
   if y3(i)>=0
        c3(i)=1;
   end
   if y2(i)>=y1(i)
        c21(i)=1;
   end
   if y1(i)>=y3(i)
        c13(i)=1;
   end
   if y2(i)>=y3(i)
        c23(i)=1;
   end
   rawcode(i)=append(string(c1(i)),string(c2(i)),string(c3(i)),string(c21(i)),string(c13(i)),string(c23(i)));
end

figure(1);
plot(t,y1,'r',t,y2,'y',t,y3,'g');
