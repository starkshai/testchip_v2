function [Iout,Vout] = CurSteeringDAC_8b(Din,CurSource,R)
Iout=0;
for i=1:8
    Iout=Iout+Din(9-i)*CurSource(i);
end
Vout=Iout*R;
end