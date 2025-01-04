function E_res=E_cal_sanyal2(b,n,c_unit,v_ref)
% 2^(n-2) cap., top panel of the last cap. is changed to vcm.
    E_1=0;% first switch
    E_2=0;% second switch
    part1=zeros(1,n);%initialization of the first term
    part2=zeros(1,n);%initialization of the second term
    E_step=zeros(1,n);%initialization of each E step
    E_step(1)=E_1;
    E_step(2)=E_2;
    for i=3:(n-1) %i-1 -> i switch
        a=zeros(1,n);
        for k=1:(i-1)
            a(k)=1/2^i*2^(n-k-1)*b(k)+1/2^i*b(i-1)*2^(n-k-1)*(1-2*b(k));
        end
        part1(i)=sum(a);
        part2(i)=2^(n-2*i);
        E_step(i)=part1(i)+part2(i);
    end
    %n-1 -> n switch
    a=zeros(1,n);
    for k=1:(n-2)
        a(k)=2^(n-k-2)*((1-b(k))*b(n-1)/2^(n-1)+b(k)*(1-b(n-1))/2^(n-1));
    end
    part1(n)=sum(a);
    part2(n)=1/2^n-1/4;
    E_step(n)=part1(n)+part2(n);

    E_sum=sum(E_step);
    E_res=E_sum*c_unit*v_ref^2;
end