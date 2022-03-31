function I10_Lens_Figure_1(Focallength,Diameter,Axial_coordinate,Center_coordinate,Lens_name)
%
%%
    % Plot the Entrance lens
    Le_a = Diameter/2;
    Le_b = Diameter*0.15;

    Nume = 21;
    Lexx = linspace(-Le_b,     Le_b,Nume);
    Le_u =  + sqrt(1-Lexx.^2./Le_b^2)*Le_a + Center_coordinate;
    Le_l =  - sqrt(1-Lexx.^2./Le_b^2)*Le_a + Center_coordinate;        

    Le_x = Lexx + Axial_coordinate;
    plot(Le_x,Le_u,'k');
    plot(Le_x,Le_l,'k');
    
    strf = ['f_{', Lens_name, '}= ',num2str(Focallength,'%.2f'),'mm'];
    text(Axial_coordinate,Diameter*0.6,strf,'FontSize',20);
    