function C=R3(theta)
%rotation matrix about z axis 
%eular angle to direction cosine matrix

C=[cos(theta),  -sin(theta),0 ;
   sin(theta),   cos(theta),0 ;
                        0,0,1];



end
