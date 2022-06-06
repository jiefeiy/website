clear,clc % tensor product of piecewise linear basis interpolation
%% grid points
l1 = 4; l2 = 4;
N1 = pow2(l1); N2 = pow2(l2);
h1 = 1/N1; h2 = 1/N2;
x = h1:h1:1-h1; y = h2:h2:1-h2;
[X,Y] = meshgrid(x,y);
%% plot points
xx = 0:0.02:1; yy = 0:0.01:1;
[XX,YY] = meshgrid(xx,yy);
%% piecewise linear basis
f1 = zeros(length(xx),N1-1);      % for x
for i = 1:(N1-1)
f1(:,i) = (1-abs((xx-i*h1)/h1)).*(xx>=(i-1)*h1).*(xx<=(i+1)*h1);
end
f2 = zeros(length(yy),N2-1);      % for y
for i = 1:(N2-1)
f2(:,i) = (1-abs((yy-i*h2)/h2)).*(yy>=(i-1)*h2).*(yy<=(i+1)*h2);
end
base = zeros(length(yy),length(xx),N1-1,N2-1);
for i = 1:N1-1                    % tensor product 
    for j = 1:N2-1
        base(:,:,i,j) = f2(:,j)*(f1(:,i)');
         mesh(XX,YY,base(:,:,i,j)); hold on; 
    end
end
%% true plot
% g = sin(2*pi*XX).*sin(pi*YY);
% mesh(XX,YY,g); xlabel('x'); ylabel('y');
%% interpolation using tensor product of piecewise linear functions
gint = sin(2*pi*X).*sin(pi*Y);     % value on grid points
value = zeros(length(yy),length(xx));
for k = 1:N1-1
    for l = 1:N2-1
        value = value + base(:,:,k,l)*gint(l,k);
    end
end
hold off; mesh(XX,YY,value,'DisplayName','interpolation mesh'); 
xlabel('x'); ylabel('y'); 
title('2D interpolation using tensor product of piecewise linear basis');
hold on; plot3(X,Y,gint,'.r');    % interpolation points




