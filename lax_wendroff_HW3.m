clc
clear
close all
...input data
a=input('a= ');
initial_condition=input('enter type of Initial Condition 1 , 2 or 3 = ');
t=input('Time= ');
...Number of pieces created on the length 
J=400;
dx=1/J;
...Time step
ta=0.0045;
t=0:ta:t;
...Calculation alfa & beta & c
alfa=(a*ta/(2*dx))+0.5*(a*ta/dx)^2;
beta=1-(a*ta/dx)^2;
c=-(a*ta/(2*dx))+0.5*(a*ta/dx)^2;
...Initial Condition
u_n=zeros(1,J);
for i=1:J
    if initial_condition==1
        if i*dx<0.25
            u_n(1,i)=1;
            u_0=1;
        end
    elseif initial_condition==2
         u_n(1,i)=sin(4*pi*i*dx);
         u_0=0;
    elseif initial_condition==3
        if 0.2<=i*dx && i*dx<0.3
            u_n(1,i)=1;
            u_0=0;
        end
    end
end
hold on
plot(linspace(0,1,J+1),[u_0 u_n],'.')
u_n=u_n';
...Create coefficient matrix fot u_n
s=zeros(J);
for i=1:J
    for j=1:J
    if i==J
        s(J,J-3)=-alfa;
        s(J,J-2)=2*alfa-beta;
        s(J,J-1)=2*beta-c;
        s(J,J)=2*c;
    else
        if i==j
            s(i,j)=beta;
        elseif i==j-1
            s(i,j)=c;
        elseif  i==j+1
            s(i,j)=alfa;
        end
    end
    end
end
...Create boundary conditions matrix
q=[alfa*u_0 zeros(1,J-1)]';
...Calculation of velocity distribution
for i=1:length(t)
u_n=linsolve(diag(ones(1,J)),s*u_n+q);
end   
...ploting
plot(linspace(0,1,J+1),[u_0;u_n]','.')
xlabel('Length')
ylabel('Velocity')
legend('Initial Condition','profile @ Time=t')
figure(2)
teta=zeros(1,J+1);
for m=0:J
    teta(1,m+1)=(2*pi*m/1)*dx;
end  
x=(alfa+c).*cos(teta)+beta;
y=(-alfa+c).*sin(teta);
plot(x,y)
axis([min(x),max(x),0,max(y),])
title('Depreciation Factor')