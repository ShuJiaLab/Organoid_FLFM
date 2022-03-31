function [Fl_01_obj,Dm_01_obj,fn_01_obj          ,...
          Fl_01_tub,Ma_01_obj,NA_01_obj,Ind01_obj,...
          Fl_02_tub,Dm_02_tub,fn_02_tub          ,...
          Fl_03_ent,Dm_03_ent,fn_03_ent          ,...
          Fl_04_MLA,Dm_04_MLA,fn_04_MLA,det_08MLA,...
          Fl_04bMLA,Dm_04_mic,Pi_04_MLA,Ind04_MLA,...
          Num05_cam,Dm_05_cam,Pi_05_cam          ,...
          Fl_07_img,Dm_07_img,fn_07_img          ,...
          lambdaAir,lambdaLen,k0       ,kn       ,...
          del_01_oo,del_02_ot,del_03_te,del_04_em,...
          del_05_mc,dell05_mc,del_06_ti,del_07_ec,...
          dis_01_oo,dis_02_ot,dis_03_te,dis_04_em,...
          dis_05_mc,dis_06_ti,dis_07_ec] = F13_FLFsys_para_016XWV2_680nm()
      
        Ma_01_obj = 016         ;          NA_01_obj = 0.80        ;       %get
        Ind01_obj = 1.330       ;                                          %get
        fn_01_obj = 1/2/NA_01_obj;         Fl_01_tub = 200*1e-3;
                                           Fl_01_obj = Fl_01_tub/Ma_01_obj;%get
        Dm_01_obj = Fl_01_obj*NA_01_obj*2;  
        %tube lens
        Dm_02_tub = 50 *1e-3;              Fl_02_tub = 300*1e-3;           %get
        fn_02_tub = Fl_02_tub/Dm_02_tub;        
        %entrance lens
        Dm_03_ent = 50*1e-3 ;              Fl_03_ent = 200*1e-3;           %get
        fn_03_ent = Fl_03_ent/Dm_03_ent;   
        %Microlens array
        Ind04_MLA = 1.515   ;              det_08MLA = 4.4*1e-3;
        Dm_04_MLA = 25*1e-3 ;              
        
        Dm_04_mic = 1300*1e-6;             Pi_04_MLA = 3300*1e-6;
        fn_04_MLA = 23;                    Fl_04_MLA = Dm_04_mic*fn_04_MLA;%get
                                           Fl_04bMLA = 27.0*1e-3;          %get
        %Camera
        Num05_cam = 2048;                  Pi_05_cam = 6.5*1e-6;           %get
        Dm_05_cam = Pi_05_cam*Num05_cam;                                   
        %Image lense
        Dm_07_img = 50*1e-3 ;              Fl_07_img = 150*1e-3;           %get
        fn_07_img = Fl_07_img/Dm_07_img;
        %Wavelengh and beadsize
        lambdaAir =  680*1e-9;                                             % 
        lambdaLen =  lambdaAir/Ind04_MLA;
        k0        =  2*pi*1        /lambdaAir;                             % k
        kn        =  2*pi*Ind01_obj/lambdaAir;                             % k
        
        % Diviation para       set             
        del_01_oo = 0;                                                     %get
        del_02_ot = 0;                                                     %get
        del_03_te = 0;                                                     %get
        del_04_em = 0;                                                     %get
        del_05_mc = 0;                                                     %get
        dell05_mc  = del_05_mc/Fl_04_MLA;                                    
        del_06_ti = 0;                                                     %get
        del_07_ec = 0;                                                     %get
        %Distance
        dis_01_oo  = del_01_oo + Fl_01_obj;                                %get
        dis_02_ot  = del_02_ot + Fl_01_obj + Fl_02_tub;                    %get
        dis_03_te  = del_03_te + Fl_02_tub + Fl_03_ent;                    %get
        dis_04_em  = del_04_em + Fl_03_ent;                                %get
        dis_05_mc  = del_05_mc + Fl_04bMLA;                                %get
        dis_06_ti  = del_06_ti + Fl_02_tub + Fl_07_img;                    %get
        dis_07_ec  = del_07_ec + Fl_03_ent;                                %get
end


































