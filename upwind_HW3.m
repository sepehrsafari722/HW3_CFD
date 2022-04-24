clc
clear
close all
...input data
a=input('a= ');
initial_condition=input('enter type of Initial Condition 1 , 2 or 3 = ');
t=input('Time= ');
...Number of pieces created on the length 
J=100;
dx=1/J;
...Time step
ta=0.00005;
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
hold on
plot(linspace(0,1,J+1),[u_0 u_n],'.')
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
plot(linspace(0,1,J+1),[u_0;u_n]','.')
xlabel('Length')
ylabel('Velocity')
legend('Initial Condition','profile @ Time=t')

            

       
    
