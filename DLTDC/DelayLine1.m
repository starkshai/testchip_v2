function [TOA_r,CNT] = DelayLine1(CellDelay,RiseTime) %clk50M & clk200M, 63 cells with dnl=100ps
t_prop=20-RiseTime;
t_cycle=sum(CellDelay(1,1:63));
%%initialization
TOA_r=zeros(1,63);
for i=1:32
    TOA_r(2*i-1)=1;
end
%%calculate counter number
cycle_numb=fix(t_prop/t_cycle);
t_res=t_prop-cycle_numb*t_cycle;
if t_res>sum(CellDelay(1,1:32))
    CNT=cycle_numb+1;
else 
    CNT=cycle_numb;
end
%%calculate cell output
if mod(cycle_numb,2)==0
    for i=1:63
        if t_res<sum(CellDelay(1,1:i))
            break
        end
        TOA_r(i)=~TOA_r(i);
    end
else
    TOA_r=~TOA_r;
    for i=1:63
        if t_res<sum(CellDelay(1,1:i))
            break
        end
        TOA_r(i)=~TOA_r(i);
    end
end
%convert to thermometer code
for i=1:32
    TOA_r(2*i-1)=~TOA_r(2*i-1);
end
end