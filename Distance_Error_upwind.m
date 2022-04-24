clc
clear
close all
...input data
a=input('a= ');
initial_condition=input('enter type of Initial Condition 1 , 2 or 3 = ');
t=input('Time= ');
W=30;
g=zeros(1,W-1);
G=zeros(1,W-1);
for w=0:W
    if w>1
       ...Midpoint temperature: 
       m=u_n(0.5*(J+2),1);
       g(1,w-1)=dx; 
    end
...Number of pieces created on the length 
J=400+10*w;
dx=1/J;
...Time step
ta=0.0005;
t=0:ta:t;
...Calculation alfa & beta
alfa=1+(a*ta/dx);
beta=-(a*ta/dx);
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
u_n=u_n';
...Create coefficient matrix fot u_n
s=zeros(J);
for i=1:J
    for j=1:J
        if i==j
            s(i,j)=alfa;
        elseif  i==j+1
            s(i,j)=beta;
        end
    end
end
...Create boundary conditions matrix
q=[beta*u_0 zeros(1,J-1)]';
...Calculation of velocity distribution
for i=1:length(t)
u_n=linsolve(diag(ones(1,J)),s*u_n+q);
end   
...Calculation of successive error
if w>1
G(1,w-1)=abs(u_n(0.5*(J+2),1)-m);
end
end
figure(1)
loglog(g,G,'o')
xlabel('size of length step')
ylabel('Error')
figure(2)
slope=gradient(log(G))./gradient(log(g));
plot(g,slope,'o')
xlabel('size of length step')
ylabel('Slope')