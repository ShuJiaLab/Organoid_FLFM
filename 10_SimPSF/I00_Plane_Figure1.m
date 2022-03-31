function I00_Plane_Figure1(Diameter,step,Axial_coordinate,strf)
%

%%
        Img_y = linspace(-Diameter/2,     +Diameter/2,... 
                  length(-Diameter/2:step:+Diameter/2));
        Img_x = ones(length(Img_y)).*Axial_coordinate;
        plot(Img_x, Img_y,'b');
        text(Axial_coordinate,-Diameter*0.6,strf,'FontSize',20);
