%% Manuel Abitia HW 1 MAE 144
% 2a)

b=RR_poly([-2 2 -5 5],1);
a=RR_poly([-1 1 -3 3 -6 6],1);
f_1=RR_poly([-1 -1 -3 -3 -6 -6],1)
[x_1,y_1] = RR_diophantine(a,b,f_1);
test_1=trim(a*x_1+b*y_1)
residual=norm(f_1-test_1);