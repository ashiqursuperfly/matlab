function out = quad_spline_interpolation( x, y,p )
N   =   length(x)-1;
V   =   [0;zeros(2*N,1);zeros(N-1,1)];
Z   =   zeros(length(V),length(V));
j=1;
f=1;
for i=2:2:2*N    
    Z(i,f:f+2)          =   [x(j)^2 x(j) 1];
    V(i)                =   y(j);
    j                   =   j+1;
    Z(i+1,f:f+2)        =   [x(j)^2 x(j) 1];  
    V(i+1)              =   y(j);
    f                   =   f+3;
end
j=1;
l=2;
for i=2*N+2:3*N
    
    Z(i,j:j+1)            =   [2*x(l) 1];
    Z(i,j+3:j+4)          =   [-2*x(l) -1];
    j                     =   j+3;
    l                     =   l+1;
end

Z(1,1)=1;
Coeff = Z\V;
j=1;
hold on;

for i=1:N
   curve=@(l) Coeff(j)*l.^2+Coeff(j+1)*l+Coeff(j+2);
     if (p<=x(i)&&p>=x(i+1))||(p>=x(i)&&p<=x(i+1))
        constants=[Coeff(j+2) Coeff(j+1) Coeff(j)];
        out = polyValue(constants,p);
      end
    fplot(curve,[x(i),x(i+1)]);
    hndl=get(gca,'Children');
    set(hndl,'LineWidth',2);
    hold on
    j=j+3;
end

%scatter(x,y,50,'r','filled')
grid on;
xlim([min(x)-2 max(x)+2]);
ylim([min(y)-2 max(y)+2]);
xlabel('x');
ylabel('y');
title('Quadratic Spline')
end


