% 3)
syms z1 p1 
y_s=[1 z1];
x_s=[1 p1 0];
h=0.01;
D_s=RR_tf(y_s,x_s);
omega=0.5;
D_z=MAL_C2D_matched(D_s,h,omega);
[p,d,k,n]=RR_partial_fraction_expansion(D_z);
p= eval(subs(p,p1,10))
d= eval(subs(d,[z1 p1],[1 10]))
disp(k)
system=RR_tf(0,1);
for i=1:length(p)
    transfer_fraction=RR_tf(d(i),[1, -p(i)]);
    system=system+transfer_fraction;
end

disp(system)

sys=tf([1 1],[1 10 0]);
Dz_proof = c2d(sys,h,'matched')

