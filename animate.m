function animate(soln,speed,lmo_orbit,gmo_orbit,p,t,save)



tend  = t(end);
R = p.R/1000;  %planet radious in km
image = imread('mars_map.tif');

%set(gcf,'Renderer','Zbuffer');


%%
%importing satellite stl filr
%gm = fegeometry("satellite_2.stl");

satellite = stlread("satellite_3.stl");
satellite = 600*satellite.Points';   %500 for my satellite_2.stl 10 for vo
%satellite_p = satellite;
satellite_p1 = satellite;

%%

axislimit = gmo_orbit.radious/1000; %in km


%%
%%extracting orbit co--ordinates
count1 = 100;
r_lmo_plt = zeros(3,count1);
r_gmo_plt = zeros(3,count1);



for i = 1:count1

    r_lmo1 = r_rdot(100*i,lmo_orbit,p);
    r_lmo1 = r_lmo1(1:3)/1000;
    r_lmo_plt(:,i) = r_lmo1;

    r_gmo1 = r_rdot(1000*i,gmo_orbit,p);
    r_gmo1 = r_gmo1(1:3)/1000;       %%%%%%%%%remove 0.1
    r_gmo_plt(:,i) = r_gmo1;

end


%%
%sphere for plotting 
scale = 1000;

[mx,my,mz] = sphere(600);


%
mx = R*mx;
my = R*my;
mz = R*mz;
%}

sx = 0.5*mx;
sy = (0.5*my)+20000;
sz = 0.5*mz;

%%
%n1 n2 n3 inertial frame base vector for plotting

n1=scale*[1,0,0]';
n2=scale*[0,1,0]';
n3=scale*[0,0,1]';

figure(3)
movegui('northwest')

figure(4)
hold on
%movegui('northwest')
%
if save
    fh = figure(4);
    fh.WindowState = 'fullscreen';
    %figure('units','pixels','position',[0 0 1920 1080])
end
%}

whitebg([0,0,0])

hold on

tic
t1=toc*speed;

%%
%main animation loop
i=1;
while t1 < tend

    clf
    hold on
    zsol = deval(soln,t1);
    mrp  = zsol(1:3,1);
    BN   = mrp2dcm(mrp);
    NB  = BN';


    r = r_rdot(t1,lmo_orbit,p);
    r = r(1:3)/1000;   %in km

    r_gmo = r_rdot(t1,gmo_orbit,p);
    r_gmo = r_gmo(1:3)/1000;     %%%%%%%%removie 0.5

   

    

    %%
    
    
    surface(mx,my,mz,flipud(image),'FaceColor','texturemap','EdgeColor','none');
    %surface(sx,sy,sz,'FaceColor','yellow','EdgeColor','none');
    

%%
%N1 N2 N3 body frame vectors
    
    b1  = NB*n1;
    b2  = NB*n2;
    b3  = NB*n3;

    satellite_p = NB*satellite;

    %%
    %
    %imported satellite thing

    satellite_p1(1,:) = r(1) + satellite_p(1,:) ;
    satellite_p1(2,:) = r(2) + satellite_p(2,:) ;
    satellite_p1(3,:) = r(3) + satellite_p(3,:) ;
    %}


%%
    quiver3(r(1),r(2),r(3),b1(1),b1(2),b1(3),0.5,'r',LineWidth=1.5);
    quiver3(r(1),r(2),r(3),-b1(1),-b1(2),-b1(3),0.4,'w',LineWidth=1,ShowArrowHead='off');
    quiver3(r(1),r(2),r(3),b2(1),b2(2),b2(3),0.5,'g','LineWidth',1.5);
    quiver3(r(1),r(2),r(3),b3(1),b3(2),b3(3),0.5,'b','LineWidth',1.5);   %b

    quiver3(0,0,0,n1(1),n1(2),n1(3),4,'r',LineWidth=4);
    quiver3(0,0,0,n2(1),n2(2),n2(3),4,'g',LineWidth=4);
    quiver3(0,0,0,n3(1),n3(2),n3(3),4,'b',LineWidth=4);

    
    plot3(r_lmo_plt(1,:),r_lmo_plt(2,:),r_lmo_plt(3,:),'c');
    plot3(satellite_p1(1,:),satellite_p1(2,:),satellite_p1(3,:),'b');

    plot3(r_gmo_plt(1,:),r_gmo_plt(2,:),r_gmo_plt(3,:),'c');
    plot3(r_gmo(1),r_gmo(2),r_gmo(3),'r.','MarkerSize',20);
    
    %}
%%

    xlim([-axislimit,axislimit])
    ylim([-axislimit,axislimit])
    zlim([-axislimit,axislimit])
    xlabel('x')
    ylabel('y')
    zlabel('z')
    %axis("equal")

    %%
    %camtarget([b3(1),b3(2),b3(3)])
    
    %lightangle(-180,0);
    light("Style","infinite","Position",[0 99999999999999 0]);
    campos([13*r(1),13*r(2),13*r(3)]);
    campos('manual')
   
    
    set(gca,'cameraviewanglemode','manual')
    %camproj('perspective')
    
    

    %view([0 25])
    %view([N3(1),N3(2),N3(3)])
    drawnow
    

    t1=toc*speed;

    if save
        F(i) = getframe(gcf);
    end
    i=i+1;



end






hold off
    if save
        filename = 'test1.avi';
        writerObj = VideoWriter(filename);
        writerObj.FrameRate = 30;
        % set the seconds per image
        % open the video writer
        open(writerObj);
        % write the frames to the video
        for i=1:length(F)
            % convert the image to a frame
            frame = F(i) ;    
            writeVideo(writerObj, frame);
        end
        % close the writer object
        close(writerObj);
    end
end
