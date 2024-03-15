function animate(soln,speed,lmo_orbit,gmo_orbit,p,t)


%mrp   = zsol(1:3,:);
tend  = t(end);
R = p.R/1000;  %planet radious in km
image = imread('mars_map.tif');
%set(gcf,'Renderer','Zbuffer');

satellite = stlread("Voyager_17.stl");
satellite = 10*satellite.Points';
%satellite_p = satellite;
satellite_p1 = satellite;

axislimit = 1*lmo_orbit.radious/1000; %in km

count1 = 100;
r_lmo_plt = zeros(3,count1);
r_gmo_plt = zeros(3,count1);
for i = 1:count1

    r_lmo1 = r_rdot(100*i,lmo_orbit,p);
    r_lmo1 = r_lmo1(1:3)/1000;
    r_lmo_plt(:,i) = r_lmo1;

    r_gmo1 = r_rdot(1000*i,gmo_orbit,p);
    r_gmo1 = r_gmo1(1:3)/1000;
    r_gmo_plt(:,i) = r_gmo1;

end





scale = 1000;

[mx,my,mz] = sphere(50);


%
mx = R*mx;
my = R*my;
mz = R*mz;
%}

sx = 0.5*mx;
sy = (0.5*my)+20000;
sz = 0.5*mz;


n1=scale*[1,0,0]';
n2=scale*[0,1,0]';
n3=scale*[0,0,1]';

figure(3)
%whitebg([0,0,0])

hold on

tic
t1=toc*speed;

while t1 < tend

    clf
    hold on
    zsol = deval(soln,t1);
    mrp  = zsol(1:3,1);
    BN   = mrp2dcm(mrp);


    r = r_rdot(t1,lmo_orbit,p);
    r = r(1:3)/1000;   %in km

    r_gmo = r_rdot(t1,gmo_orbit,p);
    r_gmo = r_gmo(1:3)/1000;

   

    

    %%
    
    
    surface(mx,my,mz,flipud(image),'FaceColor','texturemap','EdgeColor','none');
    %surface(sx,sy,sz,'FaceColor','yellow','EdgeColor','none');
    

%%
    
    N1  = BN*n1;
    N2  = BN*n2;
    N3  = BN*n3;

    satellite_p = BN*satellite;

    %%
    %
    %imported satellite thing

    satellite_p1(1,:) = r(1) + satellite_p(1,:) ;
    satellite_p1(2,:) = r(2) + satellite_p(2,:) ;
    satellite_p1(3,:) = r(3) + satellite_p(3,:) ;
    %}


%%
    quiver3(r(1),r(2),r(3),N1(1),N1(2),N1(3),0.3,'r',LineWidth=1.5);
    quiver3(r(1),r(2),r(3),N2(1),N2(2),N2(3),0.3,'g','LineWidth',1.5);
    quiver3(r(1),r(2),r(3),N3(1),N3(2),N3(3),0.3,'b','LineWidth',1.5);

    quiver3(0,0,0,n1(1),n1(2),n1(3),4,'r',LineWidth=4);
    quiver3(0,0,0,n2(1),n2(2),n2(3),4,'g',LineWidth=4);
    quiver3(0,0,0,n3(1),n3(2),n3(3),4,'b',LineWidth=4);

    
    plot3(r_lmo_plt(1,:),r_lmo_plt(2,:),r_lmo_plt(3,:));
    plot3(satellite_p1(1,:),satellite_p1(2,:),satellite_p1(3,:),'b');

    %plot3(r_gmo_plt(1,:),r_gmo_plt(2,:),r_gmo_plt(3,:));
    %plot3(r_gmo(1),r_gmo(2),r_gmo(3),'r.','MarkerSize',20);
    
    %}


    xlim([-axislimit,axislimit])
    ylim([-axislimit,axislimit])
    zlim([-axislimit,axislimit])
    xlabel('x')
    ylabel('y')
    zlabel('z')
    
    
    axis("equal")

    %camtarget([N3(1),N3(2),N3(3)])
    campos([8*r(1),8*r(2),8*r(3)]);
    campos('manual')
   
    
    set(gca,'cameraviewanglemode','manual')
    %camproj('perspective')
    
    

    %view([135 25])
    %view([N3(1),N3(2),N3(3)])
    drawnow
    

    t1=toc*speed;



end