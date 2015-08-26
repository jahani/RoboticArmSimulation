function [tN, tdN, tddP]=numIntTdd(tddEq,tP, tdP, tau, period)
% P==Present, N==Next, t==theta, td==theta_, tdd==theta__
syms t1 t2 t3 t1_ t2_ t3_ t1__ t2__ t3__
syms tav1 tav2 tav3

% Theta double dot
tddP= subs(tddEq, {t1, t2, t3, t1_, t2_, t3_, tav1, tav2, tav3}, {tP(1), tP(2), tP(3), tdP(1), tdP(2), tdP(3), tau(1), tau(2), tau(3)});

% Euler's Method
tdN=tdP+tddP*period;
tN = tP+tdP*period+0.5*tddP*period^2;


tN=double(tN);
tdN=double(tdN);
tddP=double(tddP);