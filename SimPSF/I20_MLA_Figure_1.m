function I20_MLA_Figure_1(~,Diameter,Axial_coordinate,...
                          Pitch,Aperture ,flag_center,...
                          axis_xl,axis_xr,flag_axis)
%tst
% Diameter        = G_Dl_04_MLA
% step            = step_rh
% Axial_coordinate= Node_rh(8)
% Pitch           = G_Pi_04_MLA
% Aperture        = G_Dm_04_mic
%%
    mic_numrad = floor(Diameter/Pitch/2) + 0.5*(flag_center+1);
    mic_center = (-mic_numrad:+mic_numrad)*Pitch;
    Lens_n = 21;
    Apet_n = 100;
    
    for idxal = 1:length(mic_center)    
        % Plot the Entrance lens
        Length_y = Aperture/2;
        Length_x = Aperture*1;

        Lens_x = linspace(-Length_x,Length_x,Lens_n);
        Lens_u =  + sqrt(1-Lens_x.^2./Length_x^2)*Length_y + mic_center(idxal);
        Lens_l =  - sqrt(1-Lens_x.^2./Length_x^2)*Length_y + mic_center(idxal);        
        
        % Plot a microlens
        Lensxx = Lens_x + Axial_coordinate;
        plot(Lensxx,Lens_u,'k');
        plot(Lensxx,Lens_l,'k');
        
        % Plot the aperture of a microlens
        Apet_x = Axial_coordinate * ones( 1 ,Apet_n);
        Apet_u = linspace(+Length_y,+Pitch/2,Apet_n) + mic_center(idxal);
        Apet_l = linspace(-Length_y,-Pitch/2,Apet_n) + mic_center(idxal);
        plot(Apet_x, Apet_u,'k:');
        plot(Apet_x, Apet_l,'k:');
                
        if(flag_axis)
            axis_xx = axis_xl:step:axis_xr;
            axis_yy =  ones(1,length(axis_xx)) * mic_center(idxal);
            	plot(axis_xx, axis_yy,'k:');
        end
    end

%     strf = ['f = ',num2str(Focallength,'%.2f'),'mm'];
%     text(Axial_coordinate,Diameter*0.6,strf,'FontSize',12);
    