function [thetaddEq]=thetaddEquation(tauEq)

h = waitbar(0,'Calculating theta double dot...');

syms t1 t2 t3 t1_ t2_ t3_ t1__ t2__ t3__
tau1=tauEq(1);
tau2=tauEq(2);
tau3=tauEq(3);
syms tav1 tav2 tav3

theta1__ = solve(tav1==tau1, t1__);
waitbar(0.2,h);
theta2__ = solve( subs(tav2==tau2, t1__, theta1__) , t2__);
waitbar(0.4,h);
theta3__ = solve( subs(subs(tav3==tau3, t1__, theta1__),t2__,theta2__) , t3__);
waitbar(0.6,h);
theta2__ = subs(theta2__, t3__, theta3__);
waitbar(0.7,h);
theta1__ = subs( subs(theta1__, t2__, theta2__) , t3__, theta3__);
waitbar(0.8,h,'Simplifying theta double dot...')

theta1__ = simplify(theta1__);
waitbar(0.9,h);
theta2__ = simplify(theta2__);
waitbar(0.95,h);
theta3__ = simplify(theta3__);
waitbar(1,h);

thetaddEq=[theta1__; theta2__; theta3__];
close(h);