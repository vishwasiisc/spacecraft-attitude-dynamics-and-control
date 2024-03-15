classdef orbit_lmo

    properties

        h=400e3;
        R=3396.19e3;        %radious of the planet
        r_lmo=R+h;          %lmo orbit radious
        right_ascension=deg2rad(20);
        inclination=deg2rad(30);
        theta=60;
    end

    methods

        function state=pos_vel_orbit(orbit_radious,right_ascension,inclination,true_anomaly,p)
        %%%%%%%%%%%%%%%%%%%%%%
        %Author : vishvas gajera
        %created :7 dec 2023
        %modified : 7 dec 2023
        %descereption : takes orbit parametrs and outputs position and velocity of
        %satelite in vector form in inertial frame
        %%%%%%%%%%%%%%%%%%%%%%
        
        n1=[1,0,0]'; n2=[0,1,0]'; n3=[0,0,1]';
        
        mu_mars=p.mu_mars;
        
        
        
        r1=orbit_radious*n1;
        
        omega_r1=sqrt(mu_mars/(orbit_radious^3));
        r1_dot=omega_r1*orbit_radious*n2;
        
        
        %%
        % inertial frame to body frame rotation matrix
        
        R3_asc=[cos(right_ascension),-sin(right_ascension),0;
                sin(right_ascension),cos(right_ascension),0;
                0,0,1];
        
        R1_inc=[cos(inclination),0,sin(inclination);
                                0,1,0;
                -sin(inclination),0,cos(inclination)];
        
        R3_tr_a=[cos(true_anomaly),-sin(true_anomaly),0;
                sin(true_anomaly),cos(true_anomaly),0;
                0,0,1];
        
        %%
        %return value
        r=R3_tr_a*R1_inc*R3_asc*r1;
        r_dot=R3_tr_a*R1_inc*R3_asc*r1_dot;
        state=[r,r_dot];
        end

        
    end


end
