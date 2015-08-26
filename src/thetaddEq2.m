function [tdd]=thetaddEq2(Mass,Len,Viscosity,Coulomb,Tau)

h = waitbar(0,'Calculating tau equation...');

l1=Len(1);
l2=Len(2);
l3=Len(3);
m1=Mass(1);
m2=Mass(2);
m3=Mass(3);

g=9.8;

c1I=[0 0 0;
    0 m1*l1^2/12 0;
    0 0 m1*l1^2/12]; % Icenter=m*L^2/12
c2I=[0 0 0;
    0 m2*l2^2/12 0;
    0 0 m2*l2^2/12];
c3I=[0 0 0;
    0 m3*l3^2/12 0;
    0 0 m3*l3^2/12];

syms t1 t2 t3 t1_ t2_ t3_ t1__ t2__ t3__

M11=m3*l1^2+2*m3*l1*l3*cos(t2+t3)+m2*l1^2+2*m3*l1*l2*cos(t2)+2*m2*l1*l2*cos(t2)+m1*l1^2+m2*l2^2+m3*l3^2+m3*l2^2+2*m3*l2*l3*cos(t3); 
M12=m3*l1*l3*cos(t2+t3)+m3*l1*l2*cos(t2)+m2*l1*l2*cos(t2)+m2*l2^2+m3*l3^2+m3*l2^2+2*m3*l3*l2*cos(t3);
M13=m3*l1*l3*cos(t2+t3)+m3*l3^2+m3*l3*l2*cos(t3);

M21=m3*l1*l3*cos(t2+t3)+m3*l1*l2*cos(t2)+m2*l1*l2*cos(t2)+m2*l2^2+m3*l3^2+m3*l2^2+2*m3*l3*l2*cos(t3);
M22=m2*l2^2+m3*l3^2+m3*l2^2+2*m3*l2*l3*cos(t3);
M23=m3*l3^2+m3*l2*l3*cos(t3);

M31=m3*l1*l3*cos(t2+t3)+m3*l3^2+m3*l3*l2*cos(t3);
M32=m3*l3^2+m3*l2*l3*cos(t3);
M33=m3*l3^2;

M=[M11 M12 M13;
    M21 M22 M23;
    M31 M32 M33];

waitbar(0.2,h);

V1=-m3*l1*l3*(t1_+t2_+t3_)^2*sin(t2+t3)-m3*l1*l2*(t1_+t2_)^2*sin(t2)-m2*l1*l2*(t1_+t2_)^2*sin(t2)+m2*l1*l2*(t1_)^2*sin(t2)-m3*l1*l3*(t1_)^2*sin(t2+t3)-m3*l2*l3*(t1_+t2_)^2*sin(t3)-m3*l2*l3*(t1_+t2_+t3_)^2*sin(t3)+m3*l1*l2*(t1_)^2*sin(t2);
V2=m2*l1*l2*(t1_)^2*sin(t2)-m3*l1*l3*(t1_)^2*sin(t2+t3)-m3*l2*l3*(t1_+t2_)^2*sin(t3)-m3*l2*l3*(t1_+t2_+t3_)^2*sin(t3)+m3*l1*l2*(t1_)^2*sin(t2);
V3=-m3*l1*l3*(t1_)^2*sin(t2+t3)+m3*l2*l3*(t1_+t2_)^2*sin(t3); 

V=[V1;V2;V3];

G1=(m1+m2+m3)*g*l1*cos(t1)+(m2+m3)*g*l2*cos(t1+t2)+m3*g*l3*cos(t1+t2);
G2=(m2+m3)*g*l2*cos(t1+t2)+m3*g*l3*cos(t1+t2);
G3=m3*g*l3*cos(t1+t2+t3);

G=[G1;G2;G3];

F=[Viscosity*t1_+Coulomb*sign(t1_);
   Viscosity*t2_+Coulomb*sign(t2_);
   Viscosity*t3_+Coulomb*sign(t3_)];

waitbar(0.8,h);


tdd=(M^-1)*(Tau-V-G-F);


waitbar(1,h);
close(h);