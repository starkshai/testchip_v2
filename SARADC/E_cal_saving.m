function E_res=E_cal_saving(b,n,c_unit,v_ref)
    E_1=0;% first switch
    E_2=3*2^(n-3);% second switch
    part1=zeros(1,n);%initialization of the first term
    part2=zeros(1,n);%initialization of the second term
    E_step=zeros(1,n);%initialization of each E step
    E_step(1)=E_1;
    E_step(2)=E_2;

    for i=3:n %i-1 -> i switch
        a=zeros(1,n);
        for k=1:(i-1)
            a(k)=(2*b(i-1)-1)/2^(i-1)*2^(n-k-1)*(1-2*b(k));
        end
        part1(i)=sum(a);
        part2(i)=2^(n-i);
        E_step(i)=part1(i)+part2(i);
    end
    E_sum=sum(E_step);
    E_res=E_sum*c_unit*v_ref^2;
end