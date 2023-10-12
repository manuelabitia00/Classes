function [D_z_result]=MAL_C2D_matched(num,den,h,omega)

s_poles=roots(den); %Calculate s-domain poles
s_zeroes=roots(num);%Calculate s-domain zeroes

z_poles=exp(s_poles*h); %Use equation z=e^(s*h) to map D(s) poles to D(z)
z_zeroes=exp(s_zeroes*h); %Use equation z=e^(s*h) to map D(s) zeroes to D(z)
l=length(z_poles)-length(z_zeroes);

for i=1:l %Add infinite zeroes by substracting #poles - #zeroes (
    z_zeroes(end+1,1)=(-1); %Map l #zeroes to z=-1 in D(z)
end

l=length(z_poles)-length(z_zeroes);

if l>0 %If strictly causal
    if isinf(z_poles) 
        z_zeroes(end)=inf;  %Map 1 zero to z=inf in D(z)
    end
elseif l==0 % D(z) semi-causal
    z_zeroes(end)=[]; %Take away one zero to make it strictly causal
else
end
s_numerator=poly(s_zeroes); 
s_denominator=poly(s_poles);
Ds=RR_tf(s_numerator,s_denominator);

z_numerator=poly(z_zeroes);
z_denominator=poly(z_poles);
D_z=RR_tf(z_numerator,z_denominator);

D_s_evaluate=RR_evaluate(Ds,1i*omega); %Evaluate s=i*omega as shown in (iii)
D_z_evaluate=RR_evaluate(D_z, exp(1i*omega*h)); %Evaluate z=exp(i*omega*h) as shown in (iii)

gain=D_s_evaluate/D_z_evaluate; %Scale D(z) to equal D(s)
D_z_result=gain*D_z;
end

