function b_res=mydec2bin(d,n)
   b=zeros(1,n);
   for i=n:-1:1
       if d>(2^n-1) || (d<0)
            disp("wrong d");
            break;
       end
       tmp=2^(i-1);
       if d>=tmp
           b(n-i+1)=1;
           d=d-tmp;
       else
           b(n-i+1)=0;
       end
   end
   b_res=b;
end