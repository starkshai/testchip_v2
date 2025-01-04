%create a waveform of the start for ring-oscillator-based TDC DNL/INL test
clear all;
tp=300*1e-12;%rising or falling time
td=10e-12;%delay bin
t=zeros(1,805);%201 trials, delay=[0,2ns] with 10ps bin
s1=zeros(1,805);
offset=19.5e-9;
t(1)=0;
s1(1)=0;
for i =0:1:200
   t(4*i+2)=i*80e-9 + td*i + offset;
   t(4*i+3)=i*80e-9 + td*i + tp + offset;
   t(4*i+4)=i*80e-9 + td*i + 10e-9 + offset;
   t(4*i+5)=i*80e-9 + td*i + 10e-9 + tp + offset;
   s1(4*i+2)=0;
   s1(4*i+3)=1.8;
   s1(4*i+4)=1.8;
   s1(4*i+5)=0;
end
so=[t' s1'];
save -ascii pwl4ROTDC.txt so;