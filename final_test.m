clc, clear all
close all

%�������������� ��������� ������������ � ������:
l1 = 1;
l2 = 1;
d2_max = 0.49;    %������������ ����� ����� d2
d3_max = 0.75;    %������������ ����� ����� d2

t = [0:0.01:10];
%����� �������� ������������ (����� D)
r = 0.05*t;
x = r.*cos(pi*t);
y = 1.5 + r.*sin(pi*t);
z = 1.5 - r;

%�������� ���������� ���������� d2, d3 � theta: 
f = inverse_kin(x,y,z,l1,l2);
d2 = f(1,:);
d3 = f(2,:);
theta = f(3,:);

%��������, ��������� �� �������������� ��������� ������������ �������� ����������� �� �������� ����������
d2_out = [];    %����� ������ �� ��������� ����� d2
t_out1 = [];
d3_out = [];    %����� ������ �� ��������� ����� d3
t_out2 = [];
%���������� ����� ������ �� ��������� ����� d2:
x_out1 = [];
y_out1 = [];
z_out1 = [];
%���������� ����� ������ �� ��������� ����� d3:
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
title("���������� �������� ����� D", 'fontsize',15);
legend({"���������� ����� D - ������"}, 'location', 'northeastoutside', 'fontsize',12);
xlab = xlabel('��� x');
ylab = ylabel('��� y');
zlab = zlabel('��� z');
grid on
grid minor on
axis equal

hold on
figure(1)
plot3(x_out1, y_out1, z_out1, 'mo', 'markersize',3, x_out2, y_out2, z_out2, 'ro', 'markersize',3);
legend({"���������� ����� D - ������", "���������� ����� D - ���������� ��� ����� d2", "���������� ����� D - ���������� ��� ����� d3"}, 'location', 'northeastoutside', 'fontsize',12);
hold off

figure(2);
plot(t,d2, 'g', 'linewidth',1, t_out1,d2_out, 'ro', 'markersize',2);
title("����������� �������� d2 �� �������", 'fontsize',15);
legend({"�������� d2 - ������", "�������� d2 - ����������"}, 'location', 'northeastoutside', 'fontsize',12);
xlab = xlabel('t (�)');
ylab = ylabel('d2 (�)');
grid on
grid minor on

figure(3);
plot(t,d3, 'c', 'linewidth',1, t_out2,d3_out, 'ro', 'markersize',2);
title("����������� �������� d3 �� �������", 'fontsize',15);
legend({"�������� d3 - ������", "�������� d3 - ����������"}, 'location', 'northeastoutside', 'fontsize',12);
xlab = xlabel('t (�)');
ylab = ylabel('d3 (�)');
grid on
grid minor on

figure(4);
plot(t,theta, 'm', 'linewidth',1);
title("����������� ���� �������� theta �� ������� ", 'fontsize',15);
xlab = xlabel('t (�)');
ylab = ylabel('theta (����.)');
grid on
grid minor on
