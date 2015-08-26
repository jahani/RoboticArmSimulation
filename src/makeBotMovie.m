function [M,fps]=makeBotMovie(theta, time, linkLen, saveVid)

if (nargin<4)
    saveVid=0;
end
% Config
maxFPS=30;

framesNum = length(time);
totalTime = time(framesNum)-time(1);
fps = ceil(framesNum/totalTime);

n=ceil(fps/maxFPS);
fps = ceil(framesNum/totalTime/n);

clear M;
M(length(1:n:framesNum)) = struct('cdata',[],'colormap',[]); % Inital Zero Set
j=1;
for i=1:n:framesNum
    robotPlot(theta(:,i),linkLen);
    M(j)=getframe;
    j=j+1;
end
close(figure(1));

if (saveVid==1)
    movie2avi(M, 'myBotMovie.avi', 'compression', 'None', 'fps', fps);
end