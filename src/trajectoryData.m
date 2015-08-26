function [t, td, tdd, time]=trajectoryData(tddEq, startTime, endTime, period, t0, t_0, tau)

h = waitbar(0,'Calculating trajectory data...');

time=startTime:period:endTime;
% Initializing Output Matrices
t=zeros(3,length(time));
td=t;
tdd=t;

t(:,1)=t0;
td(:,1)=t_0;

for i=1:length(time)-1
    [t(:,i+1), td(:,i+1), tdd(:,i)]=numIntTdd(tddEq, t(:,i), td(:,i), tau, period);
    waitbar(i/length(time),h);
end
[~,~,tdd(:,length(time))]=numIntTdd(tddEq, t(:,length(time)), td(:,length(time)), tau, period);

waitbar(1,h);

close(h);