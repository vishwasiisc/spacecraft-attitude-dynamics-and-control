function C = R1(theta)

%rotation matrix about x axis 
%eular angle to direction cosine matrix

C=[1,           0,               0;
   0,     cos(theta),   -sin(theta);
   0,     sin(theta),    cos(theta)];

end