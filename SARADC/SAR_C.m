function Dout=SAR_C(vref,vin,n,cdev)
    cnor=[2.^(n-1:-1:0) 1];%ideal cap. array, unit c is 1
    cact=cnor+cdev;%actual cap.
    ctot=sum(cact);%total cap. of array
    D=zeros(1,n);
    Dout=0;
    vs=-vin;%sampling
    
    for i=1:n
        vx=vs+vref*cact(i)/ctot;%voltage difference
        if vx<0 % compare
            D(i)=1;
            vs=vx;
        else
            D(i)=0;
        end
        Dout=Dout+2^(n-i)*D(i);%digital output in dec. format
    end
    
end