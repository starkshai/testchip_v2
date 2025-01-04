clear all;
close all;
clc;
n=10;c_unit=1;v_ref=1;%initialization

e_conv=zeros(1,2^n);%pre-allocating
e_saving=zeros(1,2^n);
e_mono=zeros(1,2^n);
e_vcm=zeros(1,2^n);
e_sanyal1=zeros(1,2^n);
e_sanyal2=zeros(1,2^n);

for i=0:(2^n-1)%calculate each code
    b=mydec2bin(i,n);
    e_conv(i+1)=E_cal_conv(b,n,c_unit,v_ref);
    e_saving(i+1)=E_cal_saving(b,n,c_unit,v_ref);
    e_mono(i+1)=E_cal_mono(b,n,c_unit,v_ref);
    e_vcm(i+1)=E_cal_vcm(b,n,c_unit,v_ref);
    e_sanyal1(i+1)=E_cal_sanyal1(b,n,c_unit,v_ref);
    e_sanyal2(i+1)=E_cal_sanyal2(b,n,c_unit,v_ref);
end

e_avg_conv=sum(e_conv)/2^n;%cal. average E
e_avg_saving=sum(e_saving)/2^n;
e_avg_mono=sum(e_mono)/2^n;
e_avg_vcm=sum(e_vcm)/2^n;
e_avg_sanyal1=sum(e_sanyal1)/2^n;
e_avg_sanyal2=sum(e_sanyal2)/2^n;

per_conv=e_avg_conv/e_avg_conv*100;
per_saving=e_avg_saving/e_avg_conv*100;
per_mono=e_avg_mono/e_avg_conv*100;
per_vcm=e_avg_vcm/e_avg_conv*100;
per_sanyal1=e_avg_sanyal1/e_avg_conv*100;
per_sanyal2=e_avg_sanyal2/e_avg_conv*100;
%plot
hold on;
plot(0:(2^n-1),e_conv,'k-s','MarkerIndices',1:32:2^n);
plot(0:(2^n-1),e_saving,'r-x','MarkerIndices',1:32:2^n);
plot(0:(2^n-1),e_mono,'b-^','MarkerIndices',1:32:2^n);
plot(0:(2^n-1),e_vcm,'c-v','MarkerIndices',1:32:2^n);
plot(0:(2^n-1),e_sanyal1,'g-o','MarkerIndices',1:32:2^n);
plot(0:(2^n-1),e_sanyal2,'m-<','MarkerIndices',1:32:2^n);
hold off;

title('\fontname{Times New Roman}Switching Procedure Comparision');
xlabel('\fontname{Times New Roman}Output Code');
ylabel('\fontname{Times New Roman}Switching Energy [CV^2_{ref}]');
legend('Conventional','Energy-saving','Monotonic','Vcm-based','Sanyal I','Sanyal II');
set(gcf,'color','white');
set(gca,'FontSize',12);
set(gca,'FontName','Times New Roman');
set(gca,'XLim',[0 2^n-1]);
set(gca,'YLim',[0 max(e_conv)]);
grid off;
box off;