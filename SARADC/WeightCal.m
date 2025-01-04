clear all;
close all;
clc;
format long;

n=11; %原始二进制位数
error=0.125; %接受的误差量
range=2^n; %最大搜索范围
i=1;
while range>=2 %直到范围变为小于2结束
    w(i)=round(range/2*(1-error)-0.000001); %计算第i个权重，只有大于0.5才向上进位
    s(i)=range; %存储第i次搜索范围
    range=range-w(i); %计算第i+1次搜索范围
    i=i+1;
end
m=size(w,2); %采用冗余位后新的码值位数
r=2/(1+error); %采用冗余位后新的基数

%%%%使用权重验证12-bit SARADC模型%%%%
vref=2;
vcm=vref*0.5;
ts=1e-6;
fsignal=6103.516;
c_w=w;
c_tot=sum(c_w);
c_m=size(c_w,2);
lsb=2*vref/4096;
for j=1:4096
    b=0;
    vp=vcm+vcm*sin(2*pi*fsignal*j*ts);
    vn=vcm-vcm*sin(2*pi*fsignal*j*ts);
    vin(j)=vp-vn;
    for i=1:c_m+1
        if vp>vn
            b(i)=1;
        else
            b(i)=0;
        end

        %强制产生错误来验证冗余
        if i==1 && abs(vp-vn)<=255*lsb
            b(i)=~b(i);
        end
        if i==2 && abs(vp-vn)<=143*lsb
            b(i)=~b(i);
        end
        if i==3 && abs(vp-vn)<=81*lsb
            b(i)=~b(i);
        end
        if i==4 && abs(vp-vn)<=44*lsb
            b(i)=~b(i);
        end
        if i==5 && abs(vp-vn)<=24*lsb
            b(i)=~b(i);
        end
        if i==6 && abs(vp-vn)<=14*lsb
            b(i)=~b(i);
        end
        if i~=m+1
            vp=vp+(-2*b(i)+1)*vcm*c_w(i)/c_tot;
            vn=vn-(-2*b(i)+1)*vcm*c_w(i)/c_tot;
        end
    end
    dout(j)=(sum((-2*b(1:end-1)+1).*c_w)-b(end))*-1+sum(c_w);
end