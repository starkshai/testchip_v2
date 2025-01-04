clear all;
close all;
clc;
format long;
%%ns unit
CellDelay=zeros(1,63);
%d_u=0.1;%100ps LSB
d_u_odd=normrnd(47.27e-3,2.542e-3);
d_u_even=normrnd(45.78e-3,2.757e-3);
d_sig=0.6e-3;
MC_run_numb=200;
RiseTime=0:0.01:20;
tdiff=20-RiseTime;

for k=1:MC_run_numb
for i=1:32
    CellDelay(2*i-1)=normrnd(d_u_odd,d_sig);
end
for i=1:31
    CellDelay(2*i)=normrnd(d_u_even,d_sig);
end

TOA_T=zeros(length(RiseTime),64);
for i=1:length(RiseTime)
    [TOA_r,CNT]=DelayLine1(CellDelay,RiseTime(i));
    TOA_T(i,1:63)=TOA_r;
    TOA_T(i,64)=CNT;
end
%thermometer code convert to decimal code
TOA_D=zeros(length(RiseTime),3);
for i=1:length(RiseTime)
    for j=1:63
        if xor(TOA_T(i,j),TOA_T(i,j+1))==1
            TOA_D(i,1)=j;
            break
        end
        TOA_D(i,1)=0;
    end
    TOA_D(i,2)=TOA_T(i,64);
    if TOA_D(i,2)>0
        if TOA_D(i,1)>31
            TOA_D(i,3)=TOA_D(i,1)+63*(TOA_D(i,2)-1);
        else
            TOA_D(i,3)=TOA_D(i,1)+63*TOA_D(i,2);
        end
    else
        TOA_D(i,3)=TOA_D(i,1);
    end
end
%transfer function
%plot(tdiff,TOA_D(:,3));
%calculate DNL & INL
bin_numb=max(TOA_D(:,3))-min(TOA_D(:,3))+1;
binarr(1,k)=bin_numb;
tdc_lsb=(RiseTime(end)-RiseTime(1))/bin_numb;
t_tmp=tdiff(1,end);
i=1;
for j=(length(RiseTime)-1):-1:1
    if TOA_D(j+1,3) ~= TOA_D(j,3)
       tdc_dnl(k,i)=(tdiff(1,j)-t_tmp)/tdc_lsb-1;
       tdc_inl(k,i)=(tdiff(1,j)-i*tdc_lsb)/tdc_lsb;
       i=i+1;
       t_tmp=tdiff(1,j);
    end
end
tdc_dnl(k,i)=(tdiff(1,1)-t_tmp)/tdc_lsb-1;
%tdc_inl(1,i)=sum(tdc_dnl(1,(1:i)));
tdc_inl(k,i)=(tdiff(1,1)-i*tdc_lsb)/tdc_lsb;
% subplot(1,2,1)
% plot(1:1:bin_numb,tdc_dnl,'b:.','MarkerSize',15);
% xlabel('Digital output');
% ylabel('DNL(LSBs)');
% grid on;
% subplot(1,2,2)
% plot(1:1:bin_numb,tdc_inl,'b:.','MarkerSize',15);
% xlabel('Digital output');
% ylabel('INL(LSBs)');
% grid on;
TOA_Darr(:,k)=TOA_D(:,3);
end
figure(1)
histogram(binarr);
xlabel('bin number');
ylabel('counts');
figure(2)
for i=1:MC_run_numb
    plot(1:1:max(binarr),tdc_dnl(i,:),'b:.','MarkerSize',15);
    grid on
    hold on
end
xlabel('Digital output');
ylabel('DNL(LSBs)');
figure(3)
for i=1:MC_run_numb
    plot(1:1:max(binarr),tdc_inl(i,:),'b:.','MarkerSize',15);
    grid on
    hold on
end
xlabel('Digital output');
ylabel('INL(LSBs)');
