function vec = add_mrp(mrp1,mrp2)

s1 = mrp1;
s2 = mrp2;

S1 = s1'*s1;
S2 = s2'*s2;

%%%%%check for short rotation mrp

vec = ((1-S1)*s2 + (1-S2)*s1 - 2*cross(s1,s2))/(1 + S1*S2 - 2*dot(s2,s1));
denom = norm(1+S1*S2-2*dot(s2,s1));


if denom < 1e-16
    %disp(denom)
    vec = [0,0,0]';
end


if norm(vec)>=1
    %disp('vec >1')
    vec = -vec./(vec'*vec);   
end



end