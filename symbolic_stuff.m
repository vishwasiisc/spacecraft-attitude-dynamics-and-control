clc;
clear;


syms theta       real
syms a b         real
syms i j k


%
i = [1,0,0]';
j = [0,1,0]';
k = cross(i,j);
%}

% bframe mapping

er     =  cos(theta)*i + sin(theta)*j;
etheta = -sin(theta)*i + cos(theta)*j;

E = [er,etheta,k];

r = E*[a,b,0]';
