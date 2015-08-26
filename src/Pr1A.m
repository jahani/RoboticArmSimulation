l1=0.5;
l2=0.5;
m1=4.6;
m2=2.3;
m3=1;
g=9.8;

c3I=[0.05 0 0;
    0 0.1 0;
    0 0 0.1];

syms t1 t2 t3 t1_ t2_ t3_ t1__ t2__ t3__
s1=sin(t1);
s2=sin(t2);
s3=sin(t3);
c1=cos(t1);
c2=cos(t2);
c3=cos(t3);

n=3; % numebr of links
fieldSize=n+2;

% index=1 --> i=0
% index=2 --> i=1
% index=n+1 --> i=n
field1 = 'w';  value1 = {zeros(1,fieldSize)};
field2 = 'w_';  value2 = {zeros(1,fieldSize)};
field3 = 'v_';  value3 = {zeros(1,fieldSize)};
field4 = 'vC_';  value4 = {zeros(1,fieldSize)};
field5 = 'F';  value5 = {zeros(1,fieldSize)};
field6 = 'N';  value6 = {zeros(1,fieldSize)};
field7 = 'f';  value7 = {zeros(1,fieldSize)};
field8 = 'n';  value8 = {zeros(1,fieldSize)};
field9 = 'tau';  value9 = {zeros(1,fieldSize)};
field10 = 'Pc';  value10 = {zeros(1,fieldSize)};
field11 = 'R';  value11 = {zeros(1,fieldSize)}; % R from i(btm) to i-1(up)
field12 = 'cI';  value12 = {zeros(1,fieldSize)};
field13 = 'P';  value13 = {zeros(1,fieldSize)}; % Joint i in frame {i-1}
field14 = 'm';  value14 = {zeros(1,fieldSize)};
data = struct(field1,value1,field2,value2,field3,value3,field4,value4,...
    field5,value5,field6,value6,field7,value7,field8,value8,...
    field9,value9,field10,value10,field11,value11,field12,value12,...
    field13,value13,field14,value14);

% Mass Center Point relative to Link Joint
data(1+1).Pc=[l1;0;0];
data(2+1).Pc=[l2;0;0];
data(3+1).Pc=[0;0;0];
% Mass Center Interia
data(1+1).cI=zeros(3);
data(2+1).cI=zeros(3);
data(3+1).cI=c3I;
% No force on end effector
data(n+1).f=zeros(3,1);
data(n+1).n=zeros(3,1);
data(n+1+1).f=zeros(3,1); % Bug Fix G1
data(n+1+1).n=zeros(3,1); % Bug Fix G1
% Base is fixed
data(0+1).w=zeros(3,1);
data(0+1).w_=zeros(3,1);
% Gravity
data(0+1).v_=[0;g;0];
% Rotational Matrices
for i=1:n
    data(i+1).R=[eval(['c' num2str(i)]) eval(['-s' num2str(i)]) 0;
        eval(['s' num2str(i)]) eval(['c' num2str(i)]) 0;
        0 0 1];
end
data(4+1).R=eye(3); % Bug Fix G1

% Joints Relation
data(1+1).P=[0;0;0]; % Joint 1 in frame {0}
data(2+1).P=[l1;0;0];
data(3+1).P=[l2;0;0];
data(4+1).P=[0;0;0]; % TODO
% Link Mass
data(1+1).m=m1;
data(2+1).m=m2;
data(3+1).m=m3;


% Outward Iterations i:0->n-1
for i=0:n-1
    data(i+1+1).w=transpose(data(i+1+1).R)*data(i+1).w+[0;0;eval(['t' num2str(i+1) '_'])];
    data(i+1+1).w_=transpose(data(i+1+1).R)*data(i+1).w_+cross(transpose(data(i+1+1).R)*data(i+1).w,[0;0;eval(['t' num2str(i+1) '_'])])+[0;0;eval(['t' num2str(i+1) '__'])];
    data(i+1+1).v_=transpose(data(i+1+1).R)*(cross(data(i+1).w_,data(i+1+1).P)+cross(data(i+1).w,cross(data(i+1).w,data(i+1+1).P))+data(i+1).v_);
    data(i+1+1).vC_=cross(data(i+1+1).w_,data(i+1+1).Pc)+cross(data(i+1+1).w,cross(data(i+1+1).w,data(i+1+1).Pc))+data(i+1+1).v_;
    data(i+1+1).F=data(i+1+1).m*data(i+1+1).vC_;
    data(i+1+1).N=data(i+1+1).cI*data(i+1+1).w_+cross(data(i+1+1).w,data(i+1+1).cI*data(i+1+1).w);
end

for i=n:-1:1
    data(i+1).f=data(i+1+1).R*data(i+1+1).f+data(i+1).F;
    data(i+1).n=data(i+1).N+data(i+1+1).R*data(i+1+1).n+cross(data(i+1).Pc,data(i+1).F)+cross(data(i+1+1).P,data(i+1+1).R*data(i+1+1).f);
    data(i+1).tau=transpose(data(i+1).n)*[0;0;1];
end

tau1 = simple(data(1+1).tau)
tau2 = simple(data(2+1).tau)
tau3 = simple(data(3+1).tau)