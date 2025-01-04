function Dout=SAR_C_vcm(vref,vcm,vip,vin,n,cp,cn)
    cptot=sum(cp);%total cap. of array
    cntot=sum(cn);
    D=zeros(1,n);
    vp=vip;%sampling
    vn=vin;
    if vp>vn % MSB comp.
        D(1)=1;
    else
        D(1)=0;
    end
    Dout=2^(n-1)*D(1);
    for i=2:n
        tmp1=0;
        tmp2=0;
        for k=1:i-1
            tmp1=tmp1+cp(k)*(1-D(k))*vref-cp(k)*vcm;
            tmp2=tmp2+cn(k)*D(k)*vref-cn(k)*vcm;
        end
        vp=vip+tmp1/cptot;
        vn=vin+tmp2/cntot;
        if vp>vn
            D(i)=1;
        else
            D(i)=0;
        end
        Dout=Dout+2^(n-i)*D(i);%digital output in dec. format
    end
    
end