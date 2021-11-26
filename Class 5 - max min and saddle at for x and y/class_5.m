clc
clear
syms x y real
f = input("Enter the function of x and y");
fx = diff(f, x);
fy = diff(f,y);
[ax, ay] = solve(fx, fy);
fxx = diff(fx,x);
fxy = diff(fx,y);
fyy = diff(fy, y);
r = 1;

D = fxx*fyy-(fxy^2);
for k=1:size(ax)
    if (imag(ax(k))==0 && imag(ay(k))==0)
ptx(r) = ax(k);
pty(r)= ay(k);
r=r+1;
    end
end
a1=max(double(ax));
a2=min(double(ax));
b1=max(double(ay));
b2=min(double(ay));
ezsurf(f, [a2-0.5, a1+0.5, b2-0.5, b1+0.5]);
colormap(summer(10));
shading interp
hold on
for r1=1:(r-1)
    T1=subs(subs(D, x, ptx(r1)),y, pty(r1));
    T2=subs(subs(fxx, x, ptx(r1)), y, pty(r1));
    if (double(T1))==0
        sprintf("The point is undistinugishable, need further investigation");
    elseif (double(T1)<0)
        T3 = subs(subs(f,x, ptx(r1)), y, pty(r1));
        sprintf("The given point (%d, %d ) is a saddle point ", double(ptx(r1)), double(ptx(r1)))
        plot3(double(ptx(r1)), double(pty(r1)), double(T3), 'b',  'markersize', 30);
    else
        if double(T2)<0
            sprintf('The point is a maximum (%d, %d)',double(ptx(r1)), double(ptx(r1)))
            T3 = subs(subs(f,x, ptx(r1)), y, pty(r1));
            plot3(double(ptx(r1)), double(pty(r1)), double(T3), 'r+',  'markersize', 30);
        else
            sprintf("The point is a minimum (%d, %d)", double(ptx(r1)), double(pty(r1)))
            T3 = subs(subs(f,x, ptx(r1)), y, pty(r1));
            sprintf("The value is (%d)", double(T3));
            plot3(double(ptx(r1)), double(pty(r1)), double(T3), 'm*',  'markersize', 30);
        end
    end
end