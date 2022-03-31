function [Ray_coords] = F20_optical_system_FLFM( ...
                             F_ds_01_oo,F_Fl_01_obj,F_Dm_01_obj,...
                             F_ds_02_ot,F_Fl_02_tub,F_Dm_02_tub,...
                             F_ds_03_te,F_Fl_03_ent,F_Dm_03_ent,...
                             F_ds_04_em,F_Fl_04_mla,F_Dm_04_mic,...
                             F_ds_05_mc,F_Pi_04_MLA,F_Dm_04_MLA,...
                             Node   ,step   ,...
                             Nod_num,Ray_num,...
                             Rho_ini,Ang_ini,...
                             Line_color,flag_center)
% 
% F_ds_01_oo = G_ds_01_oo ; F_Fl_01_obj = G_Fl_01_obj ; F_Dm_01_obj = G_Dm_01_obj ;
% F_ds_02_ot = G_ds_02_ot ; F_Fl_02_tub = G_Fl_02_tub ; F_Dm_02_tub = G_Dm_02_tub ;
% F_ds_03_te = G_ds_03_te ; F_Fl_03_ent = G_Fl_03_ent ; F_Dm_03_ent = G_Dm_03_ent ;
% F_ds_04_em = G_ds_04_em ; F_Fl_04_mla = G_Fl_04_mla ; F_Dm_04_mic = G_Dm_04_mic ;
% F_ds_05_mc = G_ds_05_mc ; F_Pi_04_MLA = G_Pi_04_MLA ; F_Dm_04_MLA = G_Dm_04_MLA ;
% Node = Node_rh;
% step = step_rh;
% Nod_num = Nod_num_rh;
% Ray_num = Ray_num;
% Rho_ini = Ray_rh_ini;
% Ang_ini = Ray_th_ini;
% Line_color = [1.00,0.00,0.00];
% flag_center = point_cenlenslet

% Bunch of rays tracing
% initialization
    Oddoreven = 0.5*(1-flag_center);
    for idxta = 1                                                          
        Ray_coords = zeros(Ray_num*2,Nod_num);
        Ray_coords(1:2:end,1) = Rho_ini;
        Ray_coords(2:2:end,1) = Ang_ini;
        RatiaMLA =         F_Dm_04_mic/F_Pi_04_MLA;
    end
    for idxrn = 1:Ray_num                                                  
        idxrh = 2*idxrn-1;
        idxth = 2*idxrn  ;
        
        % Free space before fo
            Ray_coords(idxrh:idxth,2) = P1_freespace(Ray_coords(idxrh:idxth,1), F_ds_01_oo);
        % Lens fo
        if( abs(Ray_coords(  idxrh,2))< F_Dm_01_obj/2)
            Ray_coords(idxrh:idxth,3) = P2_lens(     Ray_coords(idxrh:idxth,2), F_Fl_01_obj);
        else        
            Ray_coords(idxrh:idxth,3) = P1_freespace(Ray_coords(idxrh:idxth,2), 0);
        end
        
        % Free space before ft
            Ray_coords(idxrh:idxth,4) = P1_freespace(Ray_coords(idxrh:idxth,3), F_ds_02_ot);
        % Lens ft
        if( abs(Ray_coords(  idxrh,4))< F_Dm_02_tub/2)
            Ray_coords(idxrh:idxth,5) = P2_lens(     Ray_coords(idxrh:idxth,4), F_Fl_02_tub);
        else        
            Ray_coords(idxrh:idxth,5) = P1_freespace(Ray_coords(idxrh:idxth,4), 0);
        end
        
        % Free space before fe
            Ray_coords(idxrh:idxth,6) = P1_freespace(Ray_coords(idxrh:idxth,5), F_ds_03_te);
        % Lens fe
        if( abs(Ray_coords(  idxrh,6))< F_Dm_03_ent/2)
            Ray_coords(idxrh:idxth,7) = P2_lens(     Ray_coords(idxrh:idxth,6), F_Fl_03_ent);
        else        
            Ray_coords(idxrh:idxth,7) = P1_freespace(Ray_coords(idxrh:idxth,6), 0);
        end
        
        % Free space before MLA
            Ray_coords(idxrh:idxth,8) = P1_freespace(Ray_coords(idxrh:idxth,7), F_ds_04_em);
        % Microlens array and Free space after fm
            Lens_rat = Ray_coords(idxrh,8)/F_Pi_04_MLA;
            Lens_num = Lens_rat + sign(Lens_rat)*Oddoreven;
            Lens_ind = round(Lens_num);
            Lens_cen = Lens_ind - sign(Lens_num)*Oddoreven;
            Lens_edg = abs(  Lens_num - Lens_ind);
        if((abs(Ray_coords(  idxrh,8))> F_Dm_04_MLA) || Lens_edg > RatiaMLA/2)
            Ray_coords(idxrh:idxth,9) = P1_freespace(Ray_coords(idxrh:idxth,8), 0);
            Ray_coords(idxrh:idxth,10)=              Ray_coords(idxrh:idxth,9)    ;
        else        
            ray_temp_rh               = Ray_coords(idxrh,8) - Lens_cen*F_Pi_04_MLA;
            Ray_coords(idxrh:idxth,9) = P2_lens([ray_temp_rh,Ray_coords(idxth,8)]',F_Fl_04_mla);
            Ray_coords(idxrh      ,9) = Ray_coords(idxrh,9) + Lens_cen*F_Pi_04_MLA ;
            Ray_coords(idxrh:idxth,10)= P1_freespace(Ray_coords(idxrh:idxth,9), F_ds_05_mc);
        end
        for idxnd = 1:Nod_num-4                                           
            stp_num = length(   Node(idxnd) : step : Node(  idxnd+1)        );
            xx      = linspace( Node(idxnd) ,        Node(  idxnd+1),stp_num);
            yy      = (xx                    -Node(         idxnd))...
                   .*(Ray_coords(idxrh,idxnd+1)-Ray_coords(idxrh,idxnd))...
                   ./(Node(            idxnd+1)-Node(            idxnd))...
                    + Ray_coords(idxrh,idxnd);
            plot( xx, yy, 'Color',Line_color);
        end
        
            flagcente = Lens_edg||flag_center;
        if((abs(Ray_coords(  idxrh,8))> F_Dm_04_MLA) || Lens_edg > RatiaMLA/2 || flagcente == 0)
        else
            for idxnd = Nod_num-4:Nod_num-1
                stp_num = length(   Node(idxnd) : step : Node(  idxnd+1)        );
                xx      = linspace( Node(idxnd) ,        Node(  idxnd+1),stp_num);
                yy      = (xx                    -Node(         idxnd))...
                       .*(Ray_coords(idxrh,idxnd+1)-Ray_coords(idxrh,idxnd))...
                       ./(Node(            idxnd+1)-Node(            idxnd))...
                        + Ray_coords(idxrh,idxnd);
                plot( xx, yy, 'Color',Line_color);
            end
        end
    end
%         Rho_end = Ray_coords(1:2:end,:);
%         Ang_end = Ray_coords(2:2:end,:);
end


































