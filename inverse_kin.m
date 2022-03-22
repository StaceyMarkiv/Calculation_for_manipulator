function f = inverse_kin(x,y,z,l1,l2)
  %Функция, выдающая решение обратной задачи кинематики
  
  d2 = z - l1;
  d3 = sqrt(x.^2 + y.^2) - l2;
  theta = rad2deg(atan2(y,x));
  
  f = [d2; d3; theta];