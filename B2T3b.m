clear all;
Barr=[0 0 0;0 0 1;0 1 0;0 1 1;...
    1 0 0;1 0 1;1 1 0;1 1 1];
Tarr=zeros(8,7);
for i=1:8
    Tarr(i,7)=Barr(i,3)|Barr(i,2)|Barr(i,1);
    Tarr(i,6)=Barr(i,2)|Barr(i,1);
    Tarr(i,5)=(Barr(i,3)&Barr(i,2))|Barr(i,1);
    Tarr(i,4)=Barr(i,1);
    Tarr(i,3)=Barr(i,1)&(Barr(i,3)|Barr(i,2));
    Tarr(i,2)=Barr(i,1)&Barr(i,2);
    Tarr(i,1)=Barr(i,3)&Barr(i,2)&Barr(i,1);
end