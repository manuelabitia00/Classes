function [D_z_result]=MAL_C2D_matched(D_s,h,omega)

s_poles=roots(D_s.den.poly); %Calculate s-domain poles
s_zeroes=roots(D_s.num.poly);%Calculate s-domain zeroes

z_poles=exp(s_poles*h); %Use equation z=e^(s*h) to map D(s) poles to D(z)
z_zeroes=exp(s_zeroes*h); %Use equation z=e^(s*h) to map D(s) zeroes to D(z)

l=length(z_poles)-length(z_zeroes); % #poles - #zeroes

for i=1:l %Add infinite zeroes by substracting #poles - #zeroes
    z_zeroes(end+1,1)=(-1); %Map l #zeroes to z=-1 in D(z)
end

l=length(z_poles)-length(z_zeroes);

if l>0 %If strictly causal
 
elseif l==0 % D(z) semi-causal
    %Take away one zero to make it strictly causal
    z_zeroes(end)=[];
else
end

s_numerator=RR_poly(s_zeroes, 1); 
s_denominator=RR_poly(s_poles, 1);
Ds=RR_tf(s_numerator,s_denominator);

z_numerator=RR_poly(z_zeroes, 1);
z_denominator=RR_poly(z_poles, 1);
Dz=RR_tf(z_numerator,z_denominator);

D_s_evaluate=RR_evaluate(Ds,1i*omega); %Evaluate s=i*omega as shown in (iii)
D_z_evaluate=RR_evaluate(Dz, exp(1i*omega*h)); %Evaluate z=exp(i*omega*h) as shown in (iii)

gain=abs(D_s_evaluate/D_z_evaluate); %Scale D(z) to equal D(s)
D_z_result=RR_tf(z_zeroes,z_poles,gain);
end



