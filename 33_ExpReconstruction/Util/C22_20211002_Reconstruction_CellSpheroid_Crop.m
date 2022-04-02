clear;  close all;  clc;
addpath(genpath('L:\00_Code_A\Util0'))
%% General Parameter Set============================================
    for idxsg = 1	                                                       % Save path name   set                 
        File_00_path = '..\';                                
        File_00_Dash = '\'; 
        File_00_Line = '_'; 
        File_01_sav = 'sav'; 
        File_02_raw = 'raw'; 
        File_04_rec = 'rec'; 
        File_06_pro = 'pro'; 
        File_0a_sim = 'sim'; 
        File_0b_exp = 'exp'; 
        File_0c_bkg = 'bkg'; 

        File_10_WFMPSF        = '1WFMPSF'; 
        File_11_WFMPSF_SimSav = [File_00_path,File_10_WFMPSF,'_1',File_0a_sim,File_01_sav];mkdir(File_11_WFMPSF_SimSav);
        File_12_WFMPSF_ExpRaw = [File_00_path,File_10_WFMPSF,'_2',File_0b_exp,File_02_raw];mkdir(File_12_WFMPSF_ExpRaw);
        File_13_WFMPSF_BkgRaw = [File_00_path,File_10_WFMPSF,'_3',File_0c_bkg,File_02_raw];mkdir(File_13_WFMPSF_BkgRaw);
        File_14_WFMPSF_SimRec = [File_00_path,File_10_WFMPSF,'_4',File_0a_sim,File_04_rec];mkdir(File_14_WFMPSF_SimRec);
        File_15_WFMPSF_ExpRec = [File_00_path,File_10_WFMPSF,'_5',File_0b_exp,File_04_rec];mkdir(File_15_WFMPSF_ExpRec);
        File_16_WFMPSF_ExpPro = [File_00_path,File_10_WFMPSF,'_6',File_0b_exp,File_06_pro];
        
        File_20_WFMImg        = '2WFMImg'; 
        File_21_WFMImg_SimSav = [File_00_path,File_20_WFMImg,'_1',File_0a_sim,File_01_sav];mkdir(File_21_WFMImg_SimSav);
        File_22_WFMImg_ExpRaw = [File_00_path,File_20_WFMImg,'_2',File_0b_exp,File_02_raw];mkdir(File_22_WFMImg_ExpRaw);
        File_23_WFMImg_BkgRaw = [File_00_path,File_20_WFMImg,'_3',File_0c_bkg,File_02_raw];mkdir(File_23_WFMImg_BkgRaw);
        File_24_WFMImg_SimRec = [File_00_path,File_20_WFMImg,'_4',File_0a_sim,File_04_rec];mkdir(File_24_WFMImg_SimRec);
        File_25_WFMImg_ExpRec = [File_00_path,File_20_WFMImg,'_5',File_0b_exp,File_04_rec];mkdir(File_25_WFMImg_ExpRec);
        File_26_WFMImg_ExpPro = [File_00_path,File_20_WFMImg,'_6',File_0b_exp,File_06_pro];
        
        File_30_FLFPSF        = '3FLFPSF'; 
        File_31_FLFPSF_SimSav = [File_00_path,File_30_FLFPSF,'_1',File_0a_sim,File_01_sav];mkdir(File_31_FLFPSF_SimSav);
        File_32_FLFPSF_ExpRaw = [File_00_path,File_30_FLFPSF,'_2',File_0b_exp,File_02_raw];mkdir(File_32_FLFPSF_ExpRaw);
        File_33_FLFPSF_BkgRaw = [File_00_path,File_30_FLFPSF,'_3',File_0c_bkg,File_02_raw];mkdir(File_33_FLFPSF_BkgRaw);
        File_34_FLFPSF_SimRec = [File_00_path,File_30_FLFPSF,'_4',File_0a_sim,File_04_rec];
        File_35_FLFPSF_ExpRec = [File_00_path,File_30_FLFPSF,'_5',File_0b_exp,File_04_rec];
        File_36_FLFPSF_ExpPro = [File_00_path,File_30_FLFPSF,'_6',File_0b_exp,File_06_pro];
        
        File_40_FLFImg        = '4FLFImg'; 
        File_41_FLFImg_SimSav = [File_00_path,File_40_FLFImg,'_1',File_0a_sim,File_01_sav];mkdir(File_41_FLFImg_SimSav);
        File_42_FLFImg_ExpRaw = [File_00_path,File_40_FLFImg,'_2',File_0b_exp,File_02_raw];mkdir(File_42_FLFImg_ExpRaw);
        File_43_FLFImg_BkgRaw = [File_00_path,File_40_FLFImg,'_3',File_0c_bkg,File_02_raw];mkdir(File_43_FLFImg_BkgRaw);
        File_44_FLFImg_SimRec = [File_00_path,File_40_FLFImg,'_4',File_0a_sim,File_04_rec];
        File_45_FLFImg_ExpRec = [File_00_path,File_40_FLFImg,'_5',File_0b_exp,File_04_rec];
        File_46_FLFImg_ExpPro = [File_00_path,File_40_FLFImg,'_6',File_0b_exp,File_06_pro];
        
        File_50_FLFVid        = '5FLFVid'; 
        File_51_FLFVid_SimSav = [File_00_path,File_50_FLFVid,'_1',File_0a_sim,File_01_sav];mkdir(File_51_FLFVid_SimSav);
        File_52_FLFVid_ExpRaw = [File_00_path,File_50_FLFVid,'_2',File_0b_exp,File_02_raw];mkdir(File_52_FLFVid_ExpRaw);
        File_53_FLFVid_BkgRaw = [File_00_path,File_50_FLFVid,'_3',File_0c_bkg,File_02_raw];mkdir(File_53_FLFVid_BkgRaw);
        File_54_FLFVid_SimRec = [File_00_path,File_50_FLFVid,'_4',File_0a_sim,File_04_rec];
        File_55_FLFVid_ExpRec = [File_00_path,File_50_FLFVid,'_5',File_0b_exp,File_04_rec];
        File_56_FLFVid_ExpPro = [File_00_path,File_50_FLFVid,'_6',File_0b_exp,File_06_pro];
        
        File_90_RayTracingsav = [File_00_path,'\','90_Ray_Tracingsave'];mkdir(File_90_RayTracingsav);
    end
    for idxsg = 1                                                          % Image  parameter set                 
        Data_00_bit     = 16    ;                                          %get
        Data_00_maxval  = 2^Data_00_bit-1;
        Data_01_formIm  = '.tif';                                          %get
        Data_01_formVd  = '.avi';                                          %get
        Data_02_formDt  = '.mat';                                          %get
        Data_04_smoothn = 3;                                               %Get?Recons_00_NUMd
        Data_04_Oper_sm = fspecial('gaussian',[Data_04_smoothn Data_04_smoothn],0.6);
    end
%% System parameter set 16X_NEW_300
    for idxsg = 1                                                          % System and simulate parameter 16XWV2 
                                                                           % System parameters                    
       [Fl_01_obj,Dm_01_obj,fn_01_obj          ,...
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
        dis_05_mc,dis_06_ti,dis_07_ec] = F13_FLFsys_para_016XWV2();
                                                                           % Simulation parameters                
	   [Step_NIP_Finetune,Step_Propergation,...
        Flag_WFMPSFOnly  ,Flag_Simulation  ,...
        Flag_simPSFfine  ,Flag_Profilesim  ,...
        P291_NIP_Size_Ext,P292_NIP_Size_Wav,P293_NIP_Size_Num,...
        P490_MLA_Beam_Rat,P491_MLA_lens_Num,...
        P492_MLA_lens_Ext,Flag_MLA_size_Odd,...
        Flag_MLA_grid_Hex,Flag_MLA_grid_Inv,...
        Flag_Lens_On_axis,Flag_Lens_All_use,...
        Flag_Lens_Tra_Cir,Flag_Lens_Apt_Cir,...
        Flag_Aperture ] = F13_FLFsys_para_016XWV2_Sim();
    end
    for idxsg = 1                                                          % Object parameters    set             
        Object_31_ZuFOV  = + 200.000*10^-6;                                % Get
        Object_31_ZlFOV  = - 200.000*10^-6;                                % Get
        Object_32_Z_stp  =   000.400*10^-6;                                % Get
        
       [Object_31_ZmFOV,Object_33_ZuNum,Object_33_ZlNum,...
        Object_33_ZdNum,Object_34_Z_Ind,Object_35_ZCoor] = S01_Coord_create_ud(...
        Object_31_ZuFOV,Object_31_ZlFOV,Object_32_Z_stp);
    end
%% System Charaterization===========================================
    for idxsg = 1                                                          % Ray tracing figure set and draw      
        Para_Raytrace_step_xx = 0.05;
        Para_Raytrace_Ray_num = 35;
        Para_draw_axis        = 0;
        
        Ini_coorr = 0.0;
        Ini_coorz = 0.5;
        F21_ray_tracing_CPU_20191221(dis_01_oo ,Fl_01_obj,Dm_01_obj,...
                                     dis_02_ot ,Fl_02_tub,Dm_02_tub,...
                                     dis_03_te ,Fl_03_ent,Dm_03_ent,...
                                     dis_04_em ,Fl_04_MLA,Dm_04_mic,...
                                     dis_05_mc ,Pi_04_MLA,Dm_04_MLA,...
                                     Ma_01_obj,NA_01_obj,Pi_05_cam,...
                                     Para_Raytrace_step_xx,Para_Raytrace_Ray_num,Ini_coorr,...
                                     Flag_Lens_On_axis    ,Para_draw_axis       ,Ini_coorz,...
                                     File_90_RayTracingsav,Data_01_formIm)
    end
    for idxta = 1                                                          % Theoretical predicted Character      
        %FLFM system AND FLFM system-imaging
       [Ma_06_Mic,Ma_06_FLF,fn_06_FLF                  ,...
        fn_06_sub,Ma_07_img                            ,...
        Theory_21_BakRd,Theory_22_NatRd                ,...
        Theory_23_FouRd,Theory_31_RatEl,Theory_31_NumEl,...
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
                              Object_34_Z_Ind);
        
       [Path_s010_objlam,Path_s020_FouLFM,Path_s040_zrange] = ...
        F31_FLFsys_para_Lable(Ma_01_obj,NA_01_obj,lambdaAir  ,...
                              Fl_02_tub,Fl_03_ent            ,...
                              Dm_04_mic,Pi_04_MLA,fn_04_MLA  ,...
                              Object_31_ZlFOV,Object_31_ZuFOV,Object_32_Z_stp);
    end
close all
%% CSF&PSF calculation and data storage=============================
    for idxsg = 1                                                          % Sampling parameter set               
        NIP_SegSZ = 600;
        Data_05_Refine = 2;
        Data_05_DownRT = 1;                                                % Downsampling ratio
                                                                           % Mic & MLA & FLP characterization  
       [Data_06_CCD_DN   ,Data_06_CCD_RF   ,...
        P27_NIP_RefAr_Odd,P27_NIP_RefAr_Eve,...
        P27_WFM_RefAd_Odd,P27_WFM_RefAd_Eve,...
        P35_Len_NumPd_DN ,P37_Len_NumPd_RF ,P37_Len_NumAd_RF,...
        P47_Fou_NumAd_RF ,P47_MLA_NumAdSim ,P47_MLA_NumAd_RF,...
        Path_s030Lsample                                    ]...
      = F32_FLFsys_SampleL(                                                     ...
        Ma_06_Mic, NA_01_obj, Pi_04_MLA, Dm_04_mic, Pi_05_cam, Num05_cam       ,...
        Data_05_DownRT   ,Data_05_Refine   ,Object_31_ZmFOV  ,                  ...
        Theory_22_NatRd  ,Theory_23_FouRd  ,Theory_31_NumEl  ,Theory_41_ResNL  ,...
        P291_NIP_Size_Ext,P292_NIP_Size_Wav,P293_NIP_Size_Num,P492_MLA_lens_Ext,...
        Flag_Simulation  ,Flag_WFMPSFOnly  ,Flag_simPSFfine  ,P491_MLA_lens_Num,Flag_MLA_size_Odd);
                                                                           % Mic & MLA & FLP characterization  
        disp(['Size of PSF   = ' num2str(P27_NIP_RefAr_Odd) 'X' num2str(P27_NIP_RefAr_Odd) '' ]);
        disp(['Size of IMAGE = ' num2str(P47_MLA_NumAdSim ) 'X' num2str(P47_MLA_NumAdSim ) '' ]);
        disp(['Numb of layers= ' num2str(Object_33_ZdNum)                                  '' ]);
    end
%% Reconstruction parameter set ====================================
        FLFRec_06_Iters = 30
        FLFRec_07_PSFpw = 1;
%         FLFRec_53cMdNum = 111;
        FLFRec_53cMdNum = 113;
%         FLFRec_53cMdNum = 141;
        Path_s090_IterPW = F34_FLFrec_para_Lable(FLFRec_06_Iters,FLFRec_07_PSFpw);
        
    for idxta = 1                                                          % Img  loading path time set                 
        Path_L259Time = '210716_1104';
        Path_L359Time = '210627_1357';
        Path_L449Time = '211003_1609';
        Path_L459Time = '211003_1609';
        Path_L559Time = '210716_1102';
    end
    
    for idxta = 1                                                          % Reconstruction parameter set               
        Recons_51_NumML_sim_x = 91;                                        %get
        Recons_51_NumML_sim_y = 91;                                        %get
        Recons_52_NumML_exp_x = 93;                                        %get
        Recons_52_NumML_exp_y = 93;                                        %get
        
        WFMImg_01_Flag = 25;                                               % 'Experiment  Img 25'
        
        
        FLFPSF_01_Flag = 32;                                               % 'Simulated   PSF 10'
                                                                           % 'SimulateCrp PSF 11'
                                                                           % 'Experiment  PSF 20'
                                                                           % 'Hybried     PSF 30'
                                                                           % 'HyRried_rez PSF 31'
                                                                           % 'HyRried_crp PSF 32'
        FLFImg_01_Flag = 47;                                               % 'Simulated  PSF  34'
                                                                           % 'Simulated  PSF  34'
                                                                           % 'Experiment PSF  35'
                                                                           % 'Simulated  Img  44'
                                                                           % 'Simulated  crp  46'
                                                                           % 'Experiment Img  45'
                                                                           % 'Experiment crp  47'
                                                                           % 'Simulated  Vid  54'
                                                                           % 'Experiment Vid  55'
                                                                           % 'Simulated  Vids 56'
                                                                           % 'Experiment Vids 57'
                                                                           
        FLFRec_01_Flag = 3;                                                % 'Single frame      1'
                                                                           % 'Volumetric stacks 2' 
                                                                           % 'Temperal   frames 3' 
        Recons_03_dzstr = 1e-9;
        Recons_03_zcstr = 50000;
        
        FLFPSF_31_ZlFOV = -150.000*10^-6;                                  %GET
        FLFPSF_31_ZuFOV = +150.000*10^-6;                                  %GET
        FLFPSF_32_Z_Stp = Object_32_Z_stp;                                 
        
        FLFImg_31_ZlFOV = -000.000*10^-6;                                  %GET
        FLFImg_31_ZuFOV = +000.000*10^-6;                                  %GET
        FLFImg_32_Z_Stp = Object_32_Z_stp;                                 
                
        FLFImg_31_ZlSeg = -000.000*10^-6;                                  %GET
        FLFImg_31_ZuSeg = +000.000*10^-6;                                  %GET
        FLFImg_31_Z_Seg = 1;                                               %GET
        
        FLFRec_31_ZuFOV = +150.000*10^-6;                                  %GET
        FLFRec_31_ZlFOV = -150.000*10^-6;                                  %GET
        FLFRec_32_Z_Stp = Object_32_Z_stp;                                     
        FLFRec_31_Z_Seg = 1;
        
        FLFImg_41_TlVid =  000.010;                                        %GET
        FLFImg_41_TuVid =  035.050;                                        %GET
        FLFImg_41_T_Stp =  000.010;                                        %GET
        
        FLFImg_41_TlSeg =  002.850;                                        %GET
        FLFImg_41_TuSeg =  008.500;                                        %GET
        FLFImg_41_T_Seg =  1;                                              %GET
        
%         Recons_11_FOVXX = Theory_05_FOVX0;                               %SET
%         Recons_21_FOVYY = Theory_05_FOVY0;                               %SET
        WFMImg_31_ZuFOV = +040.800*10^-6;                                  %GET
        WFMImg_31_ZlFOV = -040.800*10^-6;                                  %GET
        WFMImg_32_Z_Stp =  000.400*10^-6;                                  
        
        WFMImg_31_ZlSeg = -040.800*10^-6;                                  %GET
        WFMImg_31_ZuSeg = +040.800*10^-6;                                  %GET
        WFMImg_31_Z_Seg = 1;                                               %GET
        
        FLFRec_53_MdLen = 3;
        FLFRec_53_MrRat = 1.51; 
        FLFRec_53_MrNum = floor(FLFRec_53_MrRat);
        FLFRec_53_MdNum = FLFRec_53_MrNum*2+1;                             %GET
    end
    
    for idxta = 1                                                          % Reconstruction coordinates generate        
       [WFMImg_31_ZmFOV,WFMImg_31_ZuFOV,WFMImg_31_ZlFOV,WFMImg_33_ZdNum,WFMImg_34_Z_Ind,WFMImg_35_ZCoor,...
        WFMSeg_38_Z_Frm,                WFMSeg_33_ZcNum,WFMSeg_33_ZdNum,WFMSeg_34_Z_Ind,WFMSeg_35_ZCoor,...
        FLFPSF_31_ZmFOV,FLFPSF_33_ZuNum,FLFPSF_33_ZlNum,FLFPSF_33_ZdNum,FLFPSF_34_Z_Ind,FLFPSF_35_ZCoor,...
        FLFRec_38_Frm_Z,                FLFRec_33_ZcNum,FLFRec_33_ZdNum,FLFRec_34_Z_Ind,FLFRec_35_ZCoor,...
        FLFImg_31_ZmFOV,FLFImg_33_ZuNum,FLFImg_33_ZlNum,FLFImg_33_ZdNum,FLFImg_34_Ind_Z,FLFImg_35_ZCoor,...
        FLFSeg_38_Z_Frm,                FLFSeg_33_ZcNum,FLFSeg_33_ZdNum,FLFSeg_34_Z_Ind,FLFSeg_35_ZCoor,...
        FLFImg_41_TmFOV,FLFImg_43_TuNum,FLFImg_43_TlNum,FLFImg_43_TdNum,FLFImg_44_T_Ind,FLFImg_45_TCoor,...
        FLFSeg_48_T_Frm,                FLFSeg_43_TcNum,FLFSeg_43_TdNum,FLFSeg_44_T_Ind,FLFSeg_45_TCoor,...
        FLFRec_03_MRaxi,FLFRec_04_MRmax,FLFRec_04_MRmin,FLFRec_03_fnum ,...
        FLFRec_13_Xrnum,FLFRec_13_XrNum,Recons_13_NumXc,FLFRec_13_XdNum,FLFRec_14_X_Ind,FLFRec_10_XCoor,...
        FLFRec_23_Yrnum,FLFRec_23_YrNum,Recons_23_NumYc,FLFRec_23_YdNum,FLFRec_24_Y_Ind,FLFRec_20_YCoor,...
        FLFRec_54_M_Ind,Path_s050_zrange] = S07_Coordinates(...
            WFMImg_31_ZuFOV,WFMImg_31_ZlFOV,WFMImg_32_Z_Stp,...
            WFMImg_31_ZuSeg,WFMImg_31_ZlSeg,WFMImg_31_Z_Seg,...
            FLFPSF_31_ZuFOV,FLFPSF_31_ZlFOV,FLFPSF_32_Z_Stp,...
            FLFRec_31_ZuFOV,FLFRec_31_ZlFOV,FLFRec_31_Z_Seg,...
            FLFImg_31_ZuFOV,FLFImg_31_ZlFOV,FLFImg_32_Z_Stp,...
            FLFImg_31_ZuSeg,FLFImg_31_ZlSeg,FLFImg_31_Z_Seg,...
            FLFImg_41_TuVid,FLFImg_41_TlVid,FLFImg_41_T_Stp,...
            FLFImg_41_TuSeg,FLFImg_41_TlSeg,FLFImg_41_T_Seg,...
            FLFRec_53_MrNum,...
            Pi_05_cam,Pi_04_MLA,Ma_06_FLF,fn_06_FLF);
    end
    
    for idxsg = 1                                                          % Image croping - croping pattern simulation 
%         Recons_51_Stoper = I25_MLA_Modulation_SQU_Aperture_Num(                 ...
%                              Fl_04_MLA       , k0             ,Data_06_CCD_RF  ,...
%                              P37_Len_NumPd_RF,P37_Len_NumPd_RF,P37_Len_NumAd_RF,...
%                              P47_MLA_NumAd_RF,P47_Fou_NumAd_RF,P490_MLA_Beam_Rat,...
%                              Flag_LensTraCir,Flag_LensletCen,1,Flag_LensAlluse);
%         Recons_51_Stpcro = I25_MLA_Modulation_SQU_Aperture_Num(                 ...
%                              Fl_04_MLA       , k0             ,Data_06_CCD_RF  ,...
%                              P37_Len_NumPd_RF,P37_Len_NumPd_RF,P37_Len_NumAd_RF,...
%                              P47_MLA_NumAd_RF,P47_Fou_NumAd_RF,1.51            ,...
%                              1,Flag_LensletCen,1,0);
%         Recons_51_StoAbs = imbinarize(O10_pixelBinning(Recons_51_Stoper,Data_05_Rifine));imshow(Recons_51_StoAbs)
%         Recons_51_StcAbs = imbinarize(O10_pixelBinning(Recons_51_Stpcro,Data_05_Rifine));imshow(Recons_51_StcAbs)
%         Recons_51_StpAbs = xor(Recons_51_StcAbs,Recons_51_StoAbs)                       ;imshow(Recons_51_StpAbs)

%         Recons_50_CoorM = (abs(Recons_54_Ind_M)+1)'*(abs(Recons_54_Ind_M)+1);
%         Recons_51_StrAbs= kron(Recons_50_CoorM,ones(160));                 U60_Imshow_B16(Recons_51_StrAbs)
    end
    
    for idxta = 1                                                          % PSF  loading path                          
       [Path_L310_PSF,Path_L31C_PSF,Path_L31D_PSF                     ,...
        Path_L32A_PSF,Path_L32B_PSF,Path_L32C_PSF] = S08_Load_Name_PSF(...
        Path_s020_FouLFM,Path_s030Lsample,Path_s040_zrange            ,...
        FLFPSF_31_ZlFOV ,FLFPSF_31_ZuFOV ,FLFRec_53cMdNum             ,...
        File_31_FLFPSF_SimSav,File_32_FLFPSF_ExpRaw,Data_02_formDt);
    end
    for idxta = 1                                                          % Img  loading path set and generate         
       [Path_L572cEnd,...
        Path_L250_Uni,Path_L250_Img,...
        Path_L350_Uni,Path_L350_Img,...
        Path_L440_Uni,Path_L440_Img,Path_L460_Uni,Path_L460_Img,...
        Path_L450_Uni,Path_L450_Img,Path_L470_Uni,Path_L470_Img,...
        Path_L550_Uni,Path_L550_Img,Path_L570_Uni,Path_L570_Img,...
        Path_L570cUni,Path_L570cImg] = S08_Load_Name_Img(...
        Path_s020_FouLFM,Path_s030Lsample,...
        WFMImg_31_ZlFOV,WFMImg_31_ZuFOV  ,...
        FLFImg_31_ZlFOV,FLFImg_31_ZuFOV  ,...
        FLFImg_41_TlVid,FLFImg_41_TuVid,FLFImg_41_T_Stp,FLFSeg_44_T_Ind,...
        File_26_WFMImg_ExpPro,Path_L259Time,...
        File_36_FLFPSF_ExpPro,Path_L359Time,...
        File_41_FLFImg_SimSav,Path_L449Time,...
        File_46_FLFImg_ExpPro,Path_L459Time,...
        File_56_FLFVid_ExpPro,Path_L559Time,Data_02_formDt);
    end
    for idxta = 1                                                          % Reconstruction save path generate          
        switch WFMImg_01_Flag
            case 14
                    path_s060_FileSV = File_14_WFMPSF_SimRec;
            case 15
                    path_s060_FileSV = File_15_WFMPSF_ExpRec;
            case 24
                    path_s060_FileSV = File_24_WFMImg_SimRec;
            case 25
                    path_s060_FileSV = File_25_WFMImg_ExpRec;
            otherwise
        end
        switch FLFImg_01_Flag
            case 21
                    path_s050_FileSV = File_34_FLFPSF_SimRec;
            case 35
                    path_s050_FileSV = File_35_FLFPSF_ExpRec;
            case 44
                    path_s050_FileSV = File_44_FLFImg_SimRec;
            case 46
                    path_s050_FileSV = File_44_FLFImg_SimRec;
            case 45
                    path_s050_FileSV = File_45_FLFImg_ExpRec;
            case 47
                    path_s050_FileSV = File_45_FLFImg_ExpRec;
            case 54
                    path_s050_FileSV = File_54_FLFVid_SimRec;
            case 56
                    path_s050_FileSV = File_54_FLFVid_SimRec;
            case 55
                    path_s050_FileSV = File_55_FLFVid_ExpRec;
            case 57
                    path_s050_FileSV = File_55_FLFVid_ExpRec;
            otherwise
        end

        Path_s400neotime = char(datetime('now','TimeZone','local','Format','yyMMdd_HHmm'));
        Path_s001_update = [path_s050_FileSV,    Path_s400neotime]; mkdir(Path_s001_update);
        Path_s003_update = [path_s060_FileSV,    Path_s400neotime]; mkdir(Path_s003_update);
        Path_s002_unifor = [Path_s001_update,'\',Path_s020_FouLFM];
        Path_s004_unifor = [Path_s003_update,'\',Path_s010_objlam];
        
        Path_s41o_FLFCrp = [Path_s002_unifor,'_','o_FLFCrp'];
        Path_s41p_FLFRez = [Path_s002_unifor,'_','p_FLFRez'];
        Path_s41q_WFMPSF = [Path_s002_unifor,'_','q_WFMPSF'];
        Path_s41rsWFMPSF = [Path_s002_unifor,'_','rsWFMPSF'];
        Path_s41s_Hybper = [Path_s002_unifor,'_','s_Hybper'];
                
        Path_s407_Ground = [Path_s002_unifor,Path_s030Lsample,                 '_','6_Ground'];
        Path_s407_Grdrez = [Path_s002_unifor,Path_s030Lsample,                 '_','6_Grdrez'];
        
        Path_s407_WFMImg = [Path_s004_unifor,Path_s030Lsample,                 '_','7_WFMImg'];
        Path_s407_WFMdec = [Path_s004_unifor,Path_s030Lsample,Path_s090_IterPW,'_','7_WFMdec'];
        Path_s407_WFMreg = [Path_s004_unifor,Path_s030Lsample                 ,'_','7_WFMreg'];
        Path_s407_WFMcmp = [Path_s004_unifor,Path_s030Lsample,                 '_','7_WFMcmp'];
        Path_s407dWFMcmp = [Path_s004_unifor,Path_s030Lsample,Path_s090_IterPW,'_','7dWFMcmp'];
        
        Path_s406_FLFSub = [Path_s002_unifor,Path_s030Lsample,                 '_','6_FLFSub'];
        Path_s408_FLFLsp = [Path_s002_unifor,Path_s030Lsample,Path_s090_IterPW,'_','8_FLFLsp'];
        Path_s408_FLFRez = [Path_s002_unifor,Path_s030Lsample,Path_s090_IterPW,'_','8_FLFRez'];
        Path_s409_FLFHsp = [Path_s002_unifor,Path_s030Lsample,Path_s090_IterPW,'_','9_FLFHsp'];
        Path_s40a_HybImg = [Path_s002_unifor,Path_s030Lsample,Path_s090_IterPW,'_','a_HybImg'];
        Path_s40b_HydImg = [Path_s002_unifor,Path_s030Lsample,Path_s090_IterPW,'_','b_HydImg'];
        Path_s40c_Hydae8 = [Path_s002_unifor,Path_s030Lsample,Path_s090_IterPW,'_','c_Hydae8'];
        Path_s40d_Hydpe4 = [Path_s002_unifor,Path_s030Lsample,Path_s090_IterPW,'_','d_Hydpe4'];
        
        Path_s40y_Profil = [Path_s002_unifor,                                   '_','y_Profil'];
        Path_s40z_Analys = [Path_s002_unifor,                                   '_','z_Analys'];
        
        Text_s401_Rescale = '_Res';
        Text_s402_Cropped = '_crp';
    end
    close all;clc
%% Data imput: Using entire information====================================
    for idxta = 1                                                          % FLF PSF load and space characterization    
        switch FLFPSF_01_Flag
        case 10                                                            % 'Simulated   PSF 10'
            for idxsg = 1                                                  
                    load([Path_L310_PSF,'_','6_3DNDat_Down',Data_02_formDt]);   FLFPSF_64_NorCrp = P62_FLF_PSF3Dn_nor(:,:,FLFRec_38_Frm_Z);  U_Image_show_16(203,FLFPSF_64_NorCrp(:,:,FLFRec_33_ZcNum));     clear P62_FLF_PSF3Dn_nor;   
                FLFRec_13_RdNum  = P17_ParityMatch_Min(round(Pi_04_MLA*FLFRec_53_MdLen/Data_06_CCD_DN),size(RecRez_64_PSFunc,1));   % get
                if mod(FLFRec_13_RdNum,2)
                    load([Path_L310_PSF,'_','6_WFModd_Down',Data_02_formDt]);   WFMPSF_64_NorCrp = P62_WFM_PSFodd_nor(:,:,FLFRec_38_Frm_Z);	U_Image_show_16(201,WFMPSF_64_NorCrp(  :,:,FLFRec_33_ZcNum));   clear P62_WFM_PSFodd_nor;   
                else
                    load([Path_L310_PSF,'_','6_WFMeve_Down',Data_02_formDt]);   WFMPSF_64_NorCrp = P62_WFM_PSFeve_nor(:,:,FLFRec_38_Frm_Z);  U_Image_show_16(202,WFMPSF_64_NorCrp(  :,:,FLFRec_33_ZcNum));   clear P62_WFM_PSFeve_nor;   
                end
                RezRec_13_RdNum  = size(RecRez_64_PSFunc,1);                       Recons_15_RcNum = ceil(RezRec_13_RdNum/2);        
                FLFPSF_74_NorCrp = P35_Imgcrop_centerS(FLFPSF_64_NorCrp,FLFRec_13_RdNum);	clear RecFLF_64_PSFunc;
                RezPSF_74_NorCrp = P35_Imgcrop_centerS(RecRez_64_PSFunc,RezRec_13_RdNum);    U_Image_show_16(206,RezPSF_74_NorCrp(:,:,FLFRec_33_ZcNum));     clear RecRez_64_PSFunc;
                FLFRec_33_ZdNum  = size(FLFImg_74_NorCrp,3);
            end
        case 11                                                            % 'SimulateCrp PSF LS'
            for idxsg = 1                                                  
                load([Path_L31C_PSF,Data_02_formDt]);                      
                FLFPSF_74_NorCrp = FLF_SimPSF_bin_crp(:,:,:);              
                clear FLF_SimPSF_bin_crp;
            end
        case 12                                                            % 'SimulateCrp PSF HS'
            for idxsg = 1                                                  
                load([Path_L31D_PSF,Data_02_formDt]);                      
                FLFPSF_74_NorCrp = V40_NorGPU_one(FLF_SimPSF_rez_crp(:,:,:));
%                 RecFLF_64_PSFcrp = V40_NorGPU_one(FLF_SimPSF_rez_crp(:,:,:).*Recons_51_StrAbs);
                clear FLF_SimPSF_bin_crp;
            end
        case 30
            for idxsg = 1                                                  
                load([Path_L32A_PSF,Data_02_formDt]);                      
                FLFPSF_74_NorCrp = FLF_HybPSF_Nor(:,:,:);                  
                clear FLF_HybPSF_Nor;
            end
        case 31
            for idxsg = 1                                                  
                load([Path_L32B_PSF,Data_02_formDt]);                      
                FLFPSF_74_NorCrp = rescale(FLF_HyRPSF_Nor(:,:,:).^FLFRec_07_PSFpw);
                U65_Imshow_B16_MIP_3D_Fire(FLF_HyRPSF_Nor);                
                clear FLF_HyRPSF_Nor;
            end
        case 32
            for idxsg = 1                                                  
                load([Path_L32C_PSF,Data_02_formDt]);                      
                FLFPSF_74_NorCrp = rescale(FLF_HySPSF_Nor(:,:,FLFRec_38_Frm_Z).^FLFRec_07_PSFpw);
                U65_Imshow_B16_MIP_3D_Fire(FLF_HySPSF_Nor);                
                clear FLF_HySPSF_Nor;
            end
        otherwise
            
        end
    end
    
    for idxta = 1                                                          % FLF IMG load and Path choice               
        switch FLFImg_01_Flag
            case 21
                for idxsg = 1                                              % Reconstruction data load and crop - simulated  PSF  
                    load([Path_L31C_PSF,Data_02_formDt]);                      
                    FLFImg_74_Crpnor = FLF_SimPSF_bin_crp(:,:,:);              U65_Imshow_B16_3DMaxP_Fire(FLFImg_74_Crpnor);
                    FLFImg_74_NorCrp = single(V41_NorGPU_one_1b1(FLFImg_74_Crpnor(:,:,FLFSeg_38_Z_Frm)));
                                                                               U65_Imshow_B16_3DMaxP_Fire(FLFImg_74_NorCrp);
                    clear FLF_SimPSF_bin_crp;
                end
                for idxsg = 1                                              % Reconstruction data load and crop - simulated  PSFHS
                    load(Path_L31D_PSF);                      
                    FLFImg_74_Crpnor = FLF_SimPSF_rez_crp(:,:,:);              U65_Imshow_B16_3DMaxP_Fire(FLFImg_74_Crpnor);
                    FLFImg_74_NorCrp = single(V41_NorGPU_one_1b1((FLFImg_74_Crpnor(:,:,FLFSeg_38_Z_Frm))));
                                                                               U65_Imshow_B16_3DMaxP_Fire(FLFImg_74_NorCrp);
                    clear FLF_SimPSF_bin_crp;
                end
            case 35
                for idxsg = 1                                              % Reconstruction data load and crop - Experiment PSF  
                    load(Path_L350_Img);                                   U60_Imshow_B16(FLF_DnsPSF_Nor(:,:,end));
                    FLFImg_74_NorCrp = single(FLF_DnsPSF_Nor(:,:,FLFSeg_38_Z_Frm));
                    clear FLF_DnsPSF_Nor;
                end
            case 44
                for idxsg = 1                                              % Reconstruction data load and crop - simulated  Fix  
                    load(Path_L440_Img);                                   U60_Imshow_B16(ObjFLF_72_Orgnor(:,:,end));
                    FLFImg_74_NorCrp = single(ObjFLF_72_Orgnor(:,:,FLFSeg_38_Z_Frm));
                end
            case 45
                for idxsg = 1                                              % Reconstruction data load and crop - Experiment Fix  
                    load(Path_L450_Img);                                   U60_Imshow_B16(FLFimg_74_Crpnor(:,:,end));
                    FLFImg_74_NorCrp = single(FLFimg_74_Crpnor(:,:,FLFSeg_38_Z_Frm));
                    clear FLFimg_74_Crpnor;
                end
            case 46
                for idxsg = 1                                              % Reconstruction data load and crop - simulated  Fix  
                    load(Path_L460_Img);                                   U60_Imshow_B16(ObjFLF_72cOrgnor(:,:,end));
                    FLFImg_74_NorCrp = single(ObjFLF_72cOrgnor(:,:,FLFSeg_38_Z_Frm));
                    clear ObjFLF_82cOrgnor;
                end
            case 47
                for idxsg = 1                                              % Reconstruction data load and crop - simulated  Fix  
                    load(Path_L470_Img);                                   U60_Imshow_B16(FLFimg_74cCrpnor(:,:,end));
                    FLFImg_74_NorCrp = single(FLFimg_74cCrpnor(:,:,FLFSeg_38_Z_Frm));
                    clear FLFimg_74cCrpnor;
                end
            case 57    
                for idxsg = 1                                              % Reconstruction data load and crop - Experiment Fix  (19)_10_5000  
                    load(Path_L570_Img,'FLFimg_74cCrpnor');                U65_Imshow_B16_MIP_3D_Fire(FLFimg_74cCrpnor(:,:,end));
                    FLFImg_74_NorCrp = single(FLFimg_74cCrpnor);
                    clear FLFimg_74cCrpnor;
                end
            otherwise
        end
    end
    
    for idxta = 1                                                          % WFM IMG load and Path choice               
        switch WFMImg_01_Flag
            case 25
                for idxsg = 1                                              % Reconstruction data load and crop - simulated  PSF  
                    load([Path_L250_Img],'WFMimg_74_Flpnor');              U65_Imshow_B16_MIP_3D_Fire(WFMimg_74_Flpnor);
                    WFMImg_74_NorCrp = single(WFMimg_74_Flpnor(:,:,WFMSeg_38_Z_Frm));
                                                                           U65_Imshow_B16_MIP_3D_Fire(WFMImg_74_NorCrp);
                    clear WFMimg_74_Flpnor;
                end
            otherwise
        end
    end
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for idxta = 1                                                          % Reconstruction FLF OTF processing                  
        U65_Imshow_B16_MIP_3D_Fire(FLFPSF_74_NorCrp);                       
%        [FLFPSF_75_OTFunc, FLFPSF_75tOTFunc] = N32_DeconvRL_3D_APU_OTF_FLFM_NnTn( single( FLFPSF_74_NorCrp ) );gpuDevice;
       [FLFPSF_75_OTFunc, FLFPSF_75tOTFunc] = N32_DeconvRL_3D_APU_OTF_FLFM_N1T1( single( FLFPSF_74_NorCrp ) );gpuDevice;
                FLFPSF_70_VLsize = size(FLFPSF_74_NorCrp);
        clear FLFPSF_74_NorCrp;
    end
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for idxta = 1                                                          % FLForg and FLFrez Reconstruction and save          
                Recons_06_PSFIM  = 1e0;
        switch  FLFRec_01_Flag                                                
        case 1
            for idxz = 1                                                   % Reconstruction and save                            
                Path_L554_Index = 'Focal';
                
                figure,  histogram(FLFImg_74_NorCrp(FLFImg_74_NorCrp>0),200);
                FLFImg_74_CrpNos = 0.025;
                FLFImg_75_DnsNor = FLFImg_74_NorCrp - FLFImg_74_CrpNos;    FLFImg_75_DnsNor(FLFImg_75_DnsNor<0)=0;
                figure,  histogram(FLFImg_75_DnsNor(FLFImg_75_DnsNor>0));  U61_Imshow_B16_Fire(  FLFImg_75_DnsNor(:,:,end));
                
                FLFRec_37_ZcInd = 1:FLFRec_33_ZdNum;
                FLFRec_85_CrpNor = N36_DeconvRL_3D_APU_lite_FLFM(FLFPSF_75_OTFunc,FLFPSF_75tOTFunc,FLFImg_75_DnsNor,...
                                                                 FLFRec_06_Iters ,FLFRec_53cMdNum ,FLFRec_37_ZcInd ,...
                                                                 0.001^2         ,65535           , 0);    gpuDevice(1);
                                                                           U65_Imshow_B16_MIP_3D_Fire(FLFRec_85_CrpNor);
%                 FLFRec_85_CrpNor = P35_Imgcrop_centerS(FLFRec_85_CrpNor,FLFRec_53cMdNum);
%                                                                            U65_Imshow_B16_MIP_3D_Fire(FLFRec_85_CrpNor);
%                                                                            clear Rec_00_data;
                FLFRec_38_ZcInd  = (375:475)-146
                FLFRec_38_ZcInd  = (345:445)-115
                FLFRec_38_ZcInd  = (348:448)-117
                                                                           
                FLFRec_86_FlpNor = flip(rot90(FLFRec_85_CrpNor(:,:,FLFRec_38_ZcInd),3),2 );
                                                                           U65_Imshow_B16_MIP_3D_Fire(FLFRec_86_FlpNor);
                FLFRec_09_ColSat = 1.5;
                save(                      [Path_s408_FLFLsp,Path_L554_Index ,Data_02_formDt],'FLFRec_85_CrpNor','FLFRec_86_FlpNor','-v7.3');
                S60_Imsave_B16_Nor_Col(    [Path_s408_FLFLsp,Path_L554_Index],Data_01_formIm , FLFRec_86_FlpNor ,'fire',1);
                disp(['Layer' Path_L554_Index]);
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%                 FLFRec_32rZ_Stp = 0.4e-06;
%                 FLFRec_35rZCoor =      FLFRec_31_ZlFOV : FLFRec_32rZ_Stp : FLFRec_31_ZuFOV;
%                 FLFRec_33rZdNum = ceil(FLFRec_33_ZdNum * FLFPSF_32_Z_Stp / FLFRec_32rZ_Stp);
                FLFRec_96_RezFlp = rescale(imresize(FLFRec_86_FlpNor,Ma_01_obj/Ma_06_FLF));
                                                                           U65_Imshow_B16_MIP_3D_Fire(FLFRec_96_RezFlp);
                                                                           U69_Imshow_B16_DepthC_Col( FLFRec_96_RezFlp,211,FLFRec_09_ColSat,1);
                
                save(                     [Path_s408_FLFRez,Path_L554_Index ,Data_02_formDt],'FLFRec_96_RezFlp','-v7.3');
                S60_Imsave_B16_Nor_Col(   [Path_s408_FLFRez,Path_L554_Index],Data_01_formIm , FLFRec_96_RezFlp ,'fire' ,1);
                S65_Imsave_B16_MIP_3D_Col([Path_s408_FLFRez,Path_L554_Index],Data_01_formIm , FLFRec_96_RezFlp ,'green',1);
                S65_Imsave_B16_MIP_3D_Col([Path_s408_FLFRez,Path_L554_Index],Data_01_formIm , FLFRec_96_RezFlp ,'fire' ,1);
                S69_Imsave_B16_DepthC_Col([Path_s408_FLFRez,Path_L554_Index],Data_01_formIm , FLFRec_96_RezFlp ,241    ,1,FLFRec_09_ColSat,0);
                S69_Imsave_B16_DepthC_Col([Path_s408_FLFRez,Path_L554_Index],Data_01_formIm , FLFRec_96_RezFlp ,221    ,1,FLFRec_09_ColSat,0);
                S69_Imsave_B16_DepthC_Col([Path_s408_FLFRez,Path_L554_Index],Data_01_formIm , FLFRec_96_RezFlp ,211    ,1,FLFRec_09_ColSat,1);
                S69_Imsave_B16_DepthC_Col([Path_s408_FLFRez,Path_L554_Index],Data_01_formIm , FLFRec_96_RezFlp ,294    ,1,FLFRec_09_ColSat,1);
                close all;clc;
            end
            close all;clc
        case 2
        end
    end
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for idxta = 1                                                          % Reconstruction WFM OTF processing                  
        U08_Imshow_3D_MaxP_hot(WFMPSF_64_NorCrp)
       [RecWFM_64_OTFunc , RecWFM_64tOTFunc] = N30_DeconvRL_3D_GPU_OTF_CPU(single(          WFMPSF_64_NorCrp        ),...
                                                                           single(flip(flip(WFMPSF_64_NorCrp,1),2)  ),...
                                                                           single(          RecWFM_74_sumnor(:,:,1)));gpuDevice;
    end
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for idxta = 1                                                          % WFMimg rescale, resized and flip and save          
%         ObjWFI_74_rsfunc = normpdf(1:33,17,13);
%         ObjWFI_74_rsfunc = ones(1,33);
%         ObjWFI_74_rsfunc = imresize(RecRez_64_PSFmax,[1,33])

%         RecRez_67_PSFcen = P35_Imgcrop_centerS(RecRez_64_PSFcrp,101);
        
%         RecPSF_33_NumZd  = size(RecWFM_64_PSFunc,3);
%         RecWFI_33_NumZd  = size(RecWFM_74_Dnsnor,3);
%                                                                            figure;imshow(RecWFM_74_Dnsnor(:,:,RecWFM_75_Maxzz))
%                                                                            min(RecWFM_74_Dnsnor(:))
%                                                                            RecWFM_74_BKGorg = 0.0
%                                                                            
%        [RecWFM_64_PSFrsc,RecWFM_74_sumabs] = P50_WFMRes(RecWFM_64_PSFunc, (RecWFM_74_Dnsnor - RecWFM_74_BKGorg),RecFLF_64_PSFcrp);
%                                                                            figure;imshow(RecWFM_74_sumabs)
%         RecWFM_13_numRd_rez = ceil(RecWFM_13_NumRd_org*RecRez_97_Diamet/RecWFM_77_Diamet);
%         if  RecWFM_13_numRd_rez >= RecWFM_13_numRd
%             RecWFM_74_sumnor = V40_NorGPU_one( P35_Imgcrop_centerS(imresize(RecWFM_74_Dnsnor(:,:,RecWFM_75_Maxzz),[RecWFM_13_numRd_rez,RecWFM_13_numRd_rez]),RecWFM_13_numRd) );
%             imshow(RecWFM_74_sumnor)
%             
%             RecWFM_74_sumnor = V40_NorGPU_one( P35_Imgcrop_centerS(imresize(RecWFM_74_sumabs,[RecWFM_13_numRd_rez,RecWFM_13_numRd_rez]),RecWFM_13_numRd) );
%             RecWFM_74_Rezcrp = V40_NorGPU_one( P35_Imgcrop_centerS(imresize(RecWFM_74_Dnsnor,[RecWFM_13_numRd_rez,RecWFM_13_numRd_rez]),RecWFM_13_numRd) );
%         else
%             RecWFM_74_sumnor = V40_NorGPU_one( P20_Zeropad_centerS(imresize(RecWFM_74_sumabs,[RecWFM_13_numRd_rez,RecWFM_13_numRd_rez]),RecWFM_13_numRd) );
%             RecWFM_74_Rezcrp = V40_NorGPU_one( P20_Zeropad_centerS(imresize(RecWFM_74_Dnsnor,[RecWFM_13_numRd_rez,RecWFM_13_numRd_rez]),RecWFM_13_numRd) );
%         end
        
        RecWFM_74_Flpnor = flip(  RecWFM_74_Crpnor,3);
                                                                           U65_Imshow_B16_3DMaxP_Hot(RecWFM_74_Flpnor)
                                                                           U65_Imshow_B16_3DMaxP_Hot(RecWFM_74_Crpnor)
                                                                           U64_Imshow_B16_2DMaxP_Fire(RecWFM_74_Flpnor)
    end
    
    for idxta = 1                                                          % WFMimg Volume resize and saveing                   
%         RecWFM_31_FOVZl = -40e-06;
%         RecWFM_31_FOVZu = +40e-06;
%         RecWFM_35_StepZ = 1.0e-06;
%         RecWFMr35_StepZ = 0.4e-06;
%         RecWFM_35_CoorZ = RecWFM_31_FOVZl:RecWFM_35_StepZ:RecWFM_31_FOVZu;
%         RecWFMr35_CoorZ = RecWFM_31_FOVZl:RecWFMr35_StepZ:RecWFM_31_FOVZu;
%         RecWFM_79_Flpnor_Rez = V40_NorCPU_one(P50_Imresize_z(RecWFM_75_Flpnor,RecWFM_35_CoorZ,RecWFMr35_CoorZ));
        RecWFM_79_Flpnor_Rez = RecWFM_74_Flpnor;
                                                                           U65_Imshow_B16_3DMaxP_Hot(RecWFM_79_Flpnor_Rez)
        save(                           [Path_s407_WFMRez ,Data_02_formDt],'RecWFM_79_Flpnor_Rez','-v7.3');
        S65_Imsave_B16_3DMaxP_Fire_File([Path_s407_WFMRez],Data_01_formIm , RecWFM_79_Flpnor_Rez)
    end    
    
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for idxz = 1                                                           % Figure making                                      
        Path_L554_Index = 'Fig31';
                                                                           U65_Imshow_B16_MIP_3D_Fire(FLFRec_96_RezFlp);
        FLFRec_17_ZcInd = (159-18):(337+18);    disp(numel(FLFRec_17_ZcInd))
        FLFRec_27_ZcInd = (168-21):(340+21);    disp(numel(FLFRec_27_ZcInd))
        FLFRec_971RezFlp= FLFRec_96_RezFlp(FLFRec_27_ZcInd,FLFRec_17_ZcInd,:);
                                                                           U65_Imshow_B16_MIP_3D_Fire(FLFRec_971RezFlp);
                                                                           U69_Imshow_B16_DepthC_Col( FLFRec_971RezFlp,211,FLFRec_09_ColSat,1);

        save(                     [Path_s408_FLFRez,Path_L554_Index ,Data_02_formDt],'FLFRec_971RezFlp','-v7.3');
        S65_Imsave_B16_MIP_3D_Col([Path_s408_FLFRez,Path_L554_Index],Data_01_formIm , FLFRec_971RezFlp ,'green',1);
        S65_Imsave_B16_MIP_3D_Col([Path_s408_FLFRez,Path_L554_Index],Data_01_formIm , FLFRec_971RezFlp ,'fire' ,1);
        S69_Imsave_B16_DepthC_Col([Path_s408_FLFRez,Path_L554_Index],Data_01_formIm , FLFRec_971RezFlp ,241    ,1,FLFRec_09_ColSat,0);
        S69_Imsave_B16_DepthC_Col([Path_s408_FLFRez,Path_L554_Index],Data_01_formIm , FLFRec_971RezFlp ,221    ,1,FLFRec_09_ColSat,0);
        S69_Imsave_B16_DepthC_Col([Path_s408_FLFRez,Path_L554_Index],Data_01_formIm , FLFRec_971RezFlp ,211    ,1,FLFRec_09_ColSat,1);
        S69_Imsave_B16_DepthC_Col([Path_s408_FLFRez,Path_L554_Index],Data_01_formIm , FLFRec_971RezFlp ,294    ,1,FLFRec_09_ColSat,1);
        close all;clc;
        
        Path_L554_Index = 'Fig32';
                                                                           U65_Imshow_B16_MIP_3D_Fire(FLFRec_96_RezFlp);
        FLFRec_17_ZcInd = (159-11):(337+11);    disp(numel(FLFRec_17_ZcInd))
        FLFRec_27_ZcInd = (168-14):(340+14);    disp(numel(FLFRec_27_ZcInd))
        FLFRec_972RezFlp= FLFRec_96_RezFlp(FLFRec_27_ZcInd,FLFRec_17_ZcInd,:);
                                                                           U65_Imshow_B16_MIP_3D_Fire(FLFRec_972RezFlp);
                                                                           U69_Imshow_B16_DepthC_Col( FLFRec_972RezFlp,211,FLFRec_09_ColSat,1);
        save(                     [Path_s408_FLFRez,Path_L554_Index ,Data_02_formDt],'FLFRec_972RezFlp','-v7.3');
        S60_Imsave_B16_Nor_Col(   [Path_s408_FLFRez,Path_L554_Index],Data_01_formIm , FLFRec_972RezFlp ,'fire' ,1);
        
        
        Path_L554_Index = 'Fig33';
                                                                           U65_Imshow_B16_MIP_3D_Fire(FLFRec_96_RezFlp);
        FLFRec_17_ZcInd = (159-108):(337+108);    disp(numel(FLFRec_17_ZcInd))
        FLFRec_27_ZcInd = (168-111):(340+111);    disp(numel(FLFRec_27_ZcInd))
        FLFRec_973RezFlp= FLFRec_96_RezFlp(FLFRec_27_ZcInd,FLFRec_17_ZcInd,:);
                                                                           U65_Imshow_B16_MIP_3D_Fire(FLFRec_973RezFlp);
                                                                           U69_Imshow_B16_DepthC_Col( FLFRec_973RezFlp,211,FLFRec_09_ColSat,1);
        save(                     [Path_s408_FLFRez,Path_L554_Index ,Data_02_formDt],'FLFRec_973RezFlp','-v7.3');
        S60_Imsave_B16_Nor_Col(   [Path_s408_FLFRez,Path_L554_Index],Data_01_formIm , FLFRec_973RezFlp ,'fire' ,1);
    end

    
    for idxz = 1                                                           % Figure making                                      
        Path_L554_Index = 'FigWFM1';
                                                                           U65_Imshow_B16_MIP_3D_Fire(WFMImg_74_NorCrp);
        WFMImg_17_ZcInd = (228-17):(408+17);    disp(numel(WFMImg_17_ZcInd))
        WFMImg_27_ZcInd = (221-23):(389+23);    disp(numel(WFMImg_27_ZcInd))
        WFMImg_37_ZcInd = (696:796)-648    ;    disp(numel(WFMImg_37_ZcInd))
        
        WFMImg_741NorCrp = WFMImg_74_NorCrp(WFMImg_27_ZcInd,WFMImg_17_ZcInd,WFMImg_37_ZcInd);
                                                                           U65_Imshow_B16_MIP_3D_Fire(WFMImg_741NorCrp);
        save(                     [Path_s407_WFMImg,Path_L554_Index ,Data_02_formDt],'WFMImg_741NorCrp','-v7.3' );
        S65_Imsave_B16_MIP_3D_Col([Path_s407_WFMImg,Path_L554_Index],Data_01_formIm , WFMImg_741NorCrp ,'fire',1);
        
        
        
        Path_L554_Index = 'FigWFM2';
                                                                           U65_Imshow_B16_MIP_3D_Fire(WFMImg_74_NorCrp);
        WFMImg_17_ZcInd = (228-10):(408+10);    disp(numel(WFMImg_17_ZcInd))
        WFMImg_27_ZcInd = (221-16):(389+16);    disp(numel(WFMImg_27_ZcInd))
        WFMImg_37_ZcInd = (696:796)-648    ;    disp(numel(WFMImg_37_ZcInd))
        
        WFMImg_742NorCrp = WFMImg_74_NorCrp(WFMImg_27_ZcInd,WFMImg_17_ZcInd,WFMImg_37_ZcInd);
                                                                           U65_Imshow_B16_MIP_3D_Fire(WFMImg_742NorCrp);
        save(                     [Path_s407_WFMImg,Path_L554_Index ,Data_02_formDt],'WFMImg_742NorCrp','-v7.3' );
        S60_Imsave_B16_Nor_Col(   [Path_s407_WFMImg,Path_L554_Index],Data_01_formIm , WFMImg_742NorCrp ,'fire',1);
    
    
        Path_L554_Index = 'FigWFM3';
                                                                           U65_Imshow_B16_MIP_3D_Fire(WFMImg_74_NorCrp);
        WFMImg_17_ZcInd = (228-107):(408+107);    disp(numel(WFMImg_17_ZcInd))
        WFMImg_27_ZcInd = (221-113):(389+113);    disp(numel(WFMImg_27_ZcInd))
        WFMImg_37_ZcInd = (696:796)-648    ;    disp(numel(WFMImg_37_ZcInd))
        
        WFMImg_743NorCrp = WFMImg_74_NorCrp(WFMImg_27_ZcInd,WFMImg_17_ZcInd,WFMImg_37_ZcInd);
                                                                           U65_Imshow_B16_MIP_3D_Fire(WFMImg_743NorCrp);
        save(                     [Path_s407_WFMImg,Path_L554_Index ,Data_02_formDt],'WFMImg_743NorCrp','-v7.3' );
        S60_Imsave_B16_Nor_Col(   [Path_s407_WFMImg,Path_L554_Index],Data_01_formIm , WFMImg_743NorCrp ,'fire',1);
        
        close all;clc;
    end

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    