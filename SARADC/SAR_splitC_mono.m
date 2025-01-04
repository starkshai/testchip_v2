function Dout=SAR_splitC_mono(vref,vip,vin,cp,cn)
    n=10;%10-bit,6MSB,3LSB
    cpmsb=cp(1)+cp(2)+cp(3)+cp(4)+cp(5)+cp(6);%total cap. of MSB array
    cnmsb=cn(1)+cn(2)+cn(3)+cn(4)+cn(5)+cn(6);
    cplsb=cp(7)+cp(8)+cp(9);%total cap. of LSB array
    cnlsb=cn(7)+cn(8)+cn(9);
    cpb=cp(10);%bridge cap.
    cnb=cn(10);
    cpp=cplsb*cpb/(cplsb+cpb);%cplsb//cpb
    cnp=cnlsb*cnb/(cnlsb+cnb);%cnlsb//cnb
    D=zeros(1,n);
    vp=vip;%sampling
    vn=vin;
    if vp>vn % MSB comp.
        D(1)=1;
    else
        D(1)=0;
    end
    Dout=2^(n-1)*D(1);%digital output in dec. format

    vp=vip+(-cp(1)*D(1))/(cpmsb+cpp)*vref;% 1 settling
    vn=vin+(D(1)-1)*cn(1)/(cnmsb+cnp)*vref;
    if vp>vn % MSB-1 comp.
        D(2)=1;
    else
        D(2)=0;
    end
    Dout=Dout+2^(n-2)*D(2);

    vp=vip+(-cp(1)*D(1)-cp(2)*D(2))/(cpmsb+cpp)*vref;% 2 settling
    vn=vin+((D(1)-1)*cn(1)+(D(2)-1)*cn(2))/(cnmsb+cnp)*vref;
    if vp>vn % MSB-2 comp.
        D(3)=1;
    else
        D(3)=0;
    end
    Dout=Dout+2^(n-3)*D(3);  

    vp=vip+(-cp(1)*D(1)-cp(2)*D(2)-cp(3)*D(3))/(cpmsb+cpp)*vref;% 3 settling
    vn=vin+((D(1)-1)*cn(1)+(D(2)-1)*cn(2)+(D(3)-1)*cn(3))/(cnmsb+cnp)*vref;
    if vp>vn % MSB-3 comp.
        D(4)=1;
    else
        D(4)=0;
    end
    Dout=Dout+2^(n-4)*D(4); 

    vp=vip+(-cp(1)*D(1)-cp(2)*D(2)-cp(3)*D(3)-cp(4)*D(4))/(cpmsb+cpp)*vref;% 4 settling
    vn=vin+((D(1)-1)*cn(1)+(D(2)-1)*cn(2)+(D(3)-1)*cn(3)+(D(4)-1)*cn(4))/(cnmsb+cnp)*vref;
    if vp>vn % MSB-4 comp.
        D(5)=1;
    else
        D(5)=0;
    end
    Dout=Dout+2^(n-5)*D(5); 

    vp=vip+(-cp(1)*D(1)-cp(2)*D(2)-cp(3)*D(3)-cp(4)*D(4)-cp(5)*D(5))/(cpmsb+cpp)*vref;% 5 settling
    vn=vin+((D(1)-1)*cn(1)+(D(2)-1)*cn(2)+(D(3)-1)*cn(3)+(D(4)-1)*cn(4)+(D(5)-1)*cn(5))/(cnmsb+cnp)*vref;
    if vp>vn % MSB-5 comp.
        D(6)=1;
    else
        D(6)=0;
    end
    Dout=Dout+2^(n-6)*D(6);

    vp=vip+(-cp(1)*D(1)-cp(2)*D(2)-cp(3)*D(3)-cp(4)*D(4)-cp(5)*D(5)-cp(6)*D(6))/(cpmsb+cpp)*vref;% 6 settling
    vn=vin+((D(1)-1)*cn(1)+(D(2)-1)*cn(2)+(D(3)-1)*cn(3)+(D(4)-1)*cn(4)+(D(5)-1)*cn(5)+(D(6)-1)*cn(6))/(cnmsb+cnp)*vref;
    if vp>vn % LSB comp.
        D(7)=1;
    else
        D(7)=0;
    end
    Dout=Dout+2^(n-7)*D(7);

    vp=vip+(-cp(1)*D(1)-cp(2)*D(2)-cp(3)*D(3)-cp(4)*D(4)-cp(5)*D(5)-cp(6)*D(6)-cp(7)*D(7)*cp(10)/(cp(10)+cplsb))/(cpmsb+cpp)*vref;% 7 settling
    vn=vin+((D(1)-1)*cn(1)+(D(2)-1)*cn(2)+(D(3)-1)*cn(3)+(D(4)-1)*cn(4)+(D(5)-1)*cn(5)+(D(6)-1)*cn(6)+(D(7)-1)*cn(7)*cn(10)/(cn(10)+cnlsb))/(cnmsb+cnp)*vref;
    if vp>vn % LSB comp.
        D(8)=1;
    else
        D(8)=0;
    end
    Dout=Dout+2^(n-8)*D(8);  

    vp=vip+(-cp(1)*D(1)-cp(2)*D(2)-cp(3)*D(3)-cp(4)*D(4)-cp(5)*D(5)-cp(6)*D(6)-cp(7)*D(7)*cp(10)/(cp(10)+cplsb)-cp(8)*D(8)*cp(10)/(cp(10)+cplsb))/(cpmsb+cpp)*vref;% 8 settling
    vn=vin+((D(1)-1)*cn(1)+(D(2)-1)*cn(2)+(D(3)-1)*cn(3)+(D(4)-1)*cn(4)+(D(5)-1)*cn(5)+(D(6)-1)*cn(6)+(D(7)-1)*cn(7)*cn(10)/(cn(10)+cnlsb)+(D(8)-1)*cn(8)*cn(10)/(cn(10)+cnlsb))/(cnmsb+cnp)*vref;
    if vp>vn % LSB-1 comp.
        D(9)=1;
    else
        D(9)=0;
    end
    Dout=Dout+2^(n-9)*D(9); 

    vp=vip+(-cp(1)*D(1)-cp(2)*D(2)-cp(3)*D(3)-cp(4)*D(4)-cp(5)*D(5)-cp(6)*D(6)-cp(7)*D(7)*cp(10)/(cp(10)+cplsb)-cp(8)*D(8)*cp(10)/(cp(10)+cplsb)-cp(9)*D(9)*cp(10)/(cp(10)+cplsb))/(cpmsb+cpp)*vref;% 9 settling
    vn=vin+((D(1)-1)*cn(1)+(D(2)-1)*cn(2)+(D(3)-1)*cn(3)+(D(4)-1)*cn(4)+(D(5)-1)*cn(5)+(D(6)-1)*cn(6)+(D(7)-1)*cn(7)*cn(10)/(cn(10)+cnlsb)+(D(8)-1)*cn(8)*cn(10)/(cn(10)+cnlsb)+(D(9)-1)*cn(9)*cn(10)/(cn(10)+cnlsb))/(cnmsb+cnp)*vref;
    if vp>vn % LSB-2 comp.
        D(10)=1;
    else
        D(10)=0;
    end
    Dout=Dout+2^(n-10)*D(10); 
end