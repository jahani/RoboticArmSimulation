function [h]=robotPlot(theta, linkLen)

% Calc data
data=zeros(2,4);
data(:,1)=[0;0];
data(:,2)=data(:,1)+[linkLen(1)*cos(theta(1));linkLen(1)*sin(theta(1))];
data(:,3)=data(:,2)+[linkLen(2)*cos(theta(1)+theta(2));linkLen(2)*sin(theta(1)+theta(2))];
data(:,4)=data(:,3)+[linkLen(3)*cos(theta(1)+theta(2)+theta(3));linkLen(3)*sin(theta(1)+theta(2)+theta(3))];

% Plot
figure(1)
hold off;
h=plot(data(1,:),data(2,:),'.-r',...
    'LineWidth',4,...
    'MarkerSize',20,...
    'MarkerEdgeColor','b',...
    'MarkerFaceColor','r');

axis equal;
maxL=sum(linkLen);
% axis([xmin xmax ymin ymax])
axis([-maxL maxL -maxL maxL]);
hold on;
plot(0,0,'+k','MarkerSize',30);
grid on;