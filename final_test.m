clc, clear all
close all

%Геометрические параметры манипулятора в метрах:
l1 = 1;
l2 = 1;
d2_max = 0.49;    %максимальная длина звена d2
d3_max = 0.75;    %максимальная длина звена d2

t = [0:0.01:10];
%закон движения эндэффектора (точки D)
r = 0.05*t;
x = r.*cos(pi*t);
y = 1.5 + r.*sin(pi*t);
z = 1.5 - r;

%Получаем обобщенные координаты d2, d3 и theta: 
f = inverse_kin(x,y,z,l1,l2);
d2 = f(1,:);
d3 = f(2,:);
theta = f(3,:);

%Проверка, позволяют ли геометрические параметры манипулятора провести эндэффектор по заданной траектории
d2_out = [];    %точки выхода за параметры звена d2
t_out1 = [];
d3_out = [];    %точки выхода за параметры звена d3
t_out2 = [];
%Координаты точек выхода за параметры звена d2:
x_out1 = [];
y_out1 = [];
z_out1 = [];
%Координаты точек выхода за параметры звена d3:
x_out2 = [];
y_out2 = [];
z_out2 = [];

for i = [1:length(t)]
  if d2(i) > d2_max
    d2_out(end+1) = d2(i);
    t_out1(end+1) = t(i);
    x_out1(end+1) = x(i);
    y_out1(end+1) = y(i);
    z_out1(end+1) = z(i);
  elseif d2(i) < 0
    d2_out(end+1) = d2(i);
    t_out1(end+1) = t(i);
    x_out1(end+1) = x(i);
    y_out1(end+1) = y(i);
    z_out1(end+1) = z(i);   
  endif
  if d3(i) > d3_max
    d3_out(end+1) = d3(i);
    t_out2(end+1) = t(i);
    x_out2(end+1) = x(i);
    y_out2(end+1) = y(i);
    z_out2(end+1) = z(i);    
  elseif d3(i) < 0
    d3_out(end+1) = d3(i);
    t_out2(end+1) = t(i);
    x_out2(end+1) = x(i);
    y_out2(end+1) = y(i);
    z_out2(end+1) = z(i);    
  endif
endfor
  
figure(1)
plot3(x, y, z, 'b', 'linewidth', 1);
title("Траектория движения точки D", 'fontsize',15);
legend({"Траектория точки D - расчет"}, 'location', 'northeastoutside', 'fontsize',12);
xlab = xlabel('ось x');
ylab = ylabel('ось y');
zlab = zlabel('ось z');
grid on
grid minor on
axis equal

hold on
figure(1)
plot3(x_out1, y_out1, z_out1, 'mo', 'markersize',3, x_out2, y_out2, z_out2, 'ro', 'markersize',3);
legend({"Траектория точки D - расчет", "Траектория точки D - превышение для звена d2", "Траектория точки D - превышение для звена d3"}, 'location', 'northeastoutside', 'fontsize',12);
hold off

figure(2);
plot(t,d2, 'g', 'linewidth',1, t_out1,d2_out, 'ro', 'markersize',2);
title("Зависимость смещения d2 от времени", 'fontsize',15);
legend({"Смещение d2 - расчет", "Смещение d2 - превышение"}, 'location', 'northeastoutside', 'fontsize',12);
xlab = xlabel('t (с)');
ylab = ylabel('d2 (м)');
grid on
grid minor on

figure(3);
plot(t,d3, 'c', 'linewidth',1, t_out2,d3_out, 'ro', 'markersize',2);
title("Зависимость смещения d3 от времени", 'fontsize',15);
legend({"Смещение d3 - расчет", "Смещение d3 - превышение"}, 'location', 'northeastoutside', 'fontsize',12);
xlab = xlabel('t (с)');
ylab = ylabel('d3 (м)');
grid on
grid minor on

figure(4);
plot(t,theta, 'm', 'linewidth',1);
title("Зависимость угла поворота theta от времени ", 'fontsize',15);
xlab = xlabel('t (с)');
ylab = ylabel('theta (град.)');
grid on
grid minor on
