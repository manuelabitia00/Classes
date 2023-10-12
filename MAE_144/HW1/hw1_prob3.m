% 3)
syms z1 p1
z1=1;
p1=10;
y_s=[1 z1];
x_s=[1 p1 0];
h=0.01;
D_s=RR_tf(y_s,x_s);
omega=0.5;
D_z=MAL_C2D_matched(y_s,x_s,h,omega)