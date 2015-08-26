linkLen=[1,2,3];
linkMass=[0.5,0.5,1];
tauEq=tauEquation(linkMass,linkLen);
thetaddEq=thetaddEquation(tauEq);
% Uses numIntTdd function:     t__ Eq.    S, P, Period,   t0,        t_0,      tau
[t,td,tdd,time]=trajectoryData(thetaddEq, 0, 1, 0.01, deg2rad([-30;0;0]), [0;0;0], [0;0;0]);
[M,fps]=makeBotMovie(t, time, linkLen);

