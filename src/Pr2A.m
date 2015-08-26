%function [z]=Pr2A(tau, period, theta, thetadot)

syms t1 t2 t3 t1_ t2_ t3_ t1__ t2__ t3__
tau1=(29*t1__)/10 + (37*t2__)/40 + t3__/10 + (1617*cos(t1 + t2))/100 + (3871*cos(t1))/100 - (33*t2_^2*sin(t2))/40 + (33*t1__*cos(t2))/20 + (33*t2__*cos(t2))/40 - (33*t1_*t2_*sin(t2))/20;
tau2=(33*sin(t2)*t1_^2)/40 + (37*t1__)/40 + (37*t2__)/40 + t3__/10 + (1617*cos(t1 + t2))/100 + (33*t1__*cos(t2))/40;
tau3=t1__/10 + t2__/10 + t3__/10;
syms tav1 tav2 tav3

theta1__ = solve(tav1==tau1, t1__);
theta2__ = solve( subs(tav2==tau2, t1__, theta1__) , t2__);
theta3__ = solve( subs(subs(tav3==tau3, t1__, theta1__),t2__,theta2__) , t3__);
theta2__ = subs(theta2__, t3__, theta3__);
theta1__ = subs( subs(theta1__, t2__, theta2__) , t3__, theta3__);

theta1__ = simple(theta1__);
theta2__ = simple(theta2__);
theta3__ = simple(theta3__);

subs(theta1__,{t1,t2,t3,t1_,t2_,t3_},{0,0,0,0,0,0})

