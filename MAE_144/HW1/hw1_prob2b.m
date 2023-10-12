%% Manuel Abitia HW 1 MAE 144

% 2b)
%The controller determined in 2a) is improper since the degree ...
% of the numerator y_1 (5) exceeds the degree of the numerator x_1 (3).
b=RR_poly([-2 2 -5 5],1);
a=RR_poly([-1 1 -3 3 -6 6],1);
f_2=RR_poly([-1 -1 -3 -3 -6 -6 -20 -20 -20 -20 -20 -20],1);
[x_2,y_2] = RR_diophantine(a,b,f_2)
test_2=trim(a*x_2+b*y_2)
residual=norm(f_2-test_2)
% After inputting K = 6 we get a proper controller where the order of the ...
% numerator y_2 (5) does not exceed the degree of the numerator x_2 (6).