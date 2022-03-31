function [Ma_06_Mic,Ma_06_FLF,fn_06_FLF                  ,...
          fn_06_sub,Ma_07_img                            ,...
          Theory_21_BakRd,Theory_22_NatRd,Theory_23_FouRd,...
          Theory_31_RatEl,Theory_31_NumEl                ,...
          Theory_41_ResNL,Theory_41_ResNA                ,...
          Theory_51_FWHML,Theory_52_FWHMA                ,...
          Theory_61_ResR0,Theory_62_ResZ0,Theory_63_ResZE,...
          Theory_71_FOVR0                                ,...
          Theory_72_DOFZ0,Theory_73_FOVZu,Theory_74_FOVZl,...
          Theory_32_NumEl,Theory_73_FOV_R,Theory_74_DOF_Z,...
          Theory_66_Res_R,Theory_67_Res_Z,Theory_68_ResZR] =  ...
          F30_FLFsys_Characters(Fl_01_obj,NA_01_obj,Ma_01_obj,...
                                Fl_01_tub,Fl_02_tub          ,...
                                Fl_03_ent,Fl_07_img          ,...
                                Fl_04_MLA,Dm_04_mic,Pi_04_MLA,...
                                fn_01_obj,fn_04_MLA,lambdaAir,...
                                del_05_mc,del_03_te,del_04_em,...
                                Object_34_Z_Ind)
    
    Ma_06_Mic = 1 / Fl_01_obj * Fl_01_tub ;
    Ma_06_FLF = 1 / Fl_01_obj * Fl_02_tub / Fl_03_ent * Fl_04_MLA;
    fn_06_FLF =     Fl_01_obj / Fl_02_tub * Fl_03_ent / Dm_04_mic;
    fn_06_sub =     Fl_01_obj / Fl_02_tub * Fl_03_ent / Pi_04_MLA;
    Ma_07_img = 1 / Fl_01_obj * Fl_02_tub / Fl_07_img * Fl_03_ent;
    
    Theory_21_BakRd = 2*NA_01_obj*Fl_01_obj                     ;          % Back aperture size
    Theory_22_NatRd =   Pi_04_MLA*Fl_03_ent/Fl_04_MLA           ;          % Native image plane size = FOV * M_nat
    Theory_23_FouRd = 2*NA_01_obj*Fl_01_obj*Fl_03_ent/Fl_02_tub ;          % Fourier      plane size 
    
    Theory_31_RatEl =       Theory_23_FouRd/Pi_04_MLA           ;          % Ratio of FP size and the MLA aperture
    Theory_31_NumEl = floor(Theory_31_RatEl)                    ;          % Theoretical number of elemental images
    
    Theory_41_ResNL = lambdaAir.*fn_01_obj;
    Theory_41_ResNA = lambdaAir.*fn_01_obj^2*4;
    Theory_51_FWHML = lambdaAir.*fn_04_MLA;
    Theory_52_FWHMA = lambdaAir.*fn_04_MLA^2*4;
    Theory_61_ResR0 = lambdaAir.*fn_06_FLF;
    Theory_62_ResZ0 = lambdaAir.*fn_06_FLF^2;
    Theory_63_ResZE = lambdaAir.*fn_06_FLF^2/fix((Theory_31_NumEl-1)/2);
    Theory_71_FOVR0 = Pi_04_MLA./Ma_06_FLF;
    Theory_72_DOFZ0 = lambdaAir.*fn_06_FLF^2*8/(1-(4*lambdaAir/1000*Fl_04_MLA/Fl_03_ent^2)^2);
    Theory_73_FOVZu =+lambdaAir.*fn_06_FLF^2*4/(1+ 4*lambdaAir/1000*Fl_04_MLA/Fl_03_ent^2);
    Theory_74_FOVZl =-lambdaAir.*fn_06_FLF^2*4/(1- 4*lambdaAir/1000*Fl_04_MLA/Fl_03_ent^2);
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Coe_00_RV    = Fl_03_ent^2./ Fl_03_ent^2;
    Coe_10_RV    = Fl_03_ent^2*(1+del_05_mc)/(Fl_03_ent^2-(-del_03_te)*del_04_em);
    Coe_11_RVNum =(1+(Object_34_Z_Ind.*Ma_01_obj/1000)          ./(Fl_02_tub  - Object_34_Z_Ind.*Ma_01_obj  /1000).*(1+Ma_01_obj)).*...
                  (1-(Object_34_Z_Ind.*Ma_01_obj/1000-del_03_te)./ Fl_03_ent).*...
                  (1-(Object_34_Z_Ind.*Ma_01_obj/1000)          ./ Fl_02_tub).*...
                  (1+(Object_34_Z_Ind.*Ma_01_obj/1000)          ./(Fl_03_ent  - Object_34_Z_Ind.*Ma_01_obj^2/1000).*(0+Ma_06_FLF).*(1+del_04_em./Fl_04_MLA));
    Coe_12_RVz   = Fl_03_ent^2*(1+del_05_mc)                    ./(Fl_03_ent^2-(Object_34_Z_Ind- del_03_te)*del_04_em);
    Coe_13_PSF   = 1+ Object_34_Z_Ind.*0.001;

    Theory_32_NumEl  = Theory_31_NumEl.*Coe_11_RVNum;
    Theory_73_FOV_R = Theory_71_FOVR0./Coe_12_RVz+(del_03_te*1000./Ma_01_obj^2-Object_34_Z_Ind)./fn_06_FLF;
    Theory_74_DOF_Z = Theory_72_DOFZ0./Coe_12_RVz+ del_03_te*1000./Ma_01_obj^2;
    Theory_66_Res_R = Theory_61_ResR0./Coe_12_RVz.*Coe_13_PSF;
    Theory_67_Res_Z = Theory_62_ResZ0./Coe_12_RVz.*Coe_13_PSF;
    Theory_68_ResZR = Theory_63_ResZE./Coe_12_RVz.*Coe_13_PSF;
end


































