clear;  close all;  clc;
addpath(genpath('L:\00_Code_A\Util0'))
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for idxsg = 1                                                              % Image parameter set              
    Data_00_bit     = 16    ;                                              %get
    Data_00_maxval  = 2^Data_00_bit-1;
    Data_01_formIm  = '.tif';                                              %get
    Data_01_formVd  = '.avi';                                              %get
    Data_02_formDt  = '.mat';                                              %get
    Data_04_smoothn = 1;                                                   %Get?Recons_00_NUMd
    Data_04_Oper_sm = fspecial('gaussian',[Data_04_smoothn Data_04_smoothn],0.6);
end
for idxsg = 1	                                                           % Save path name   set             
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
    File_46_FLFPSF_ExpPro = [File_00_path,File_40_FLFImg,'_6',File_0b_exp,File_06_pro];

    File_50_FLFVid        = '5FLFVid'; 
    File_51_FLFVid_SimSav = [File_00_path,File_50_FLFVid,'_1',File_0a_sim,File_01_sav];mkdir(File_51_FLFVid_SimSav);
    File_52_FLFVid_ExpRaw = [File_00_path,File_50_FLFVid,'_2',File_0b_exp,File_02_raw];mkdir(File_52_FLFVid_ExpRaw);
    File_53_FLFVid_BkgRaw = [File_00_path,File_50_FLFVid,'_3',File_0c_bkg,File_02_raw];mkdir(File_53_FLFVid_BkgRaw);
    File_54_FLFVid_SimRec = [File_00_path,File_50_FLFVid,'_4',File_0a_sim,File_04_rec];
    File_55_FLFVid_ExpRec = [File_00_path,File_50_FLFVid,'_5',File_0b_exp,File_04_rec];
    File_56_FLFVid_ExpPro = [File_00_path,File_50_FLFVid,'_6',File_0b_exp,File_06_pro];

    File_90_RayTracingsav = [File_00_path,'\','90_Ray_Tracingsave'];mkdir(File_90_RayTracingsav);
    end

for idxsg = 1	                                                           % Paths name      set              
            	                                                           % WFM paths name  set            

    
    Vid_DataName = char(datetime('now','TimeZone','local','Format','yyyyMMdd_HHmm'));
    Vid_SavePath = [File_56_FLFVid_ExpPro,Vid_DataName];                   mkdir(Vid_SavePath)
end
for idxsg = 1                                                              % System parameter set 16X         
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
        Flag_Lenslet__Cen,Flag_Lens_All_use,...          
        Flag_Lens_Tra_Cir,Flag_Lens_Apt_Cir,...
        Flag_Aperture ] = F13_FLFsys_para_016XWV2_Sim();
        
        Para_Raytrace_step_xx = 0.05;
        Para_Raytrace_Ray_num = 35;
        Para_draw_axis        = 0;
end
    FLF_Load_FlagImbkg = 1 
    WFM_Load_FlagImbkg = 1 
    FLF_Load_FlagVdbkg = 0 

    FLF_Save_Flag__Crp = 1;
    Recons_43_NumEd    = 3;
    Index_Col          = 'green';
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for idxsg = 1                                                              % FLFimg and Sub Crop range set    
    FLF_Location = imread([File_00_path,'\','FLF_Location.tif']);          U40_Imshow_Sat(FLF_Location, 2)
    
    FLF_ExpImg_range_y = 278:1780;  disp(length(FLF_ExpImg_range_y))
    FLF_ExpImg_range_x = 281:1783;  disp(length(FLF_ExpImg_range_x))
                                                                           U40_Imshow_Sat(FLF_Location(FLF_ExpImg_range_y,FLF_ExpImg_range_x), 2)
    FLF_ExpSub_range_y = 780:1280;  disp(length(FLF_ExpSub_range_y))
    FLF_ExpSub_range_x = 775:1275;  disp(length(FLF_ExpSub_range_x))       
    Sub_Location_org   =           FLF_Location(FLF_ExpSub_range_y,FLF_ExpSub_range_x)      ;
                                                                           U40_Imshow_Sat(Sub_Location_org, 2)
    Sub_Location_ort   =flip(rot90(FLF_Location(FLF_ExpSub_range_y,FLF_ExpSub_range_x),3),2);
                                                                           U40_Imshow_Sat(Sub_Location_ort, 2)
end
close all;clc
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FLFimg crop PSF
for idxsg = 1                                                              % FLFimg read and save name set    
    FLF_Load_Lable_Pre  = 'dcam_';
    FLF_Load_Lable_End  = '_1'   ;
    
    FLF_Load_Index_Ini  = 50000;
    FLF_Load_Index_End  = 50000;
    FLF_Load_Index_Stp  = 1000;
    FLF_Load_Index_cen  = 50000;
    
    FLF_Load_ImshowMag = 3
    FLF_ExpSub_crp_rad = 56;
    FLF_PSFSub_crp_sfx = -23;
    FLF_PSFSub_crp_sfy = 68;
    
    -(423-28-350)/2
    -(423-82-406)/2
    
    S24_DataSave_FLF_CropTest(File_42_FLFImg_ExpRaw,File_43_FLFImg_BkgRaw             ,...
                              File_32_FLFPSF_ExpRaw                                   ,...
                              Data_02_formDt,Recons_43_NumEd,Index_Col                ,...
                              FLF_ExpImg_range_y,FLF_ExpImg_range_x                   ,...
                              FLF_ExpSub_range_y,FLF_ExpSub_range_x                   ,...
                              FLF_Load_Lable_Pre,FLF_Load_Lable_End                   ,...
                              FLF_Load_Index_Ini,FLF_Load_Index_End,FLF_Load_Index_Stp,...
                              FLF_Load_FlagImbkg,FLF_Load_ImshowMag                   ,...
                              FLF_ExpSub_crp_rad,FLF_PSFSub_crp_sfy,FLF_PSFSub_crp_sfx)
    
    S24_DataSave_FLF(File_42_FLFImg_ExpRaw,File_43_FLFImg_BkgRaw             ,...
                     File_32_FLFPSF_ExpRaw,File_46_FLFPSF_ExpPro             ,...
                     Data_01_formIm,Data_02_formDt,Recons_43_NumEd,Index_Col ,...
                     FLF_ExpImg_range_y,FLF_ExpImg_range_x                   ,...
                     FLF_ExpSub_range_y,FLF_ExpSub_range_x                   ,...
                     FLF_Load_Lable_Pre,FLF_Load_Lable_End,FLF_Load_Index_cen,...
                     FLF_Load_Index_Ini,FLF_Load_Index_End,FLF_Load_Index_Stp,...
                     FLF_Load_FlagImbkg,FLF_Save_Flag__Crp,FLF_Load_ImshowMag,...
                     FLF_ExpSub_crp_rad,FLF_PSFSub_crp_sfy,FLF_PSFSub_crp_sfx)
end
close all;clc
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% WFMimg crop 
for idxsg = 1                                                              % WFMImg read and save name set    
    WFM_Location = imread([File_22_WFMImg_ExpRaw,'\','andor_50000_1.tif']);
                                                                           U40_Imshow_Sat(WFM_Location, 3)
%     WFM_ImCrop_RadiusR = 2048
%     WFM_ImCrop_CenterX = 1024
%     WFM_ImCrop_CenterY = 1024
    
    WFM_ImCrop_DiametR = ceil((FLF_ExpSub_crp_rad*2+1)/3.6*16)
    WFM_ImCrop_CenterX = 1305
    WFM_ImCrop_CenterY = 0935
    
    -(WFM_ImCrop_DiametR-222-403)/2
    -(WFM_ImCrop_DiametR-172-347)/2
    
    U40_Imshow_Sat(P36_Imgcrop_coordsS(WFM_Location,WFM_ImCrop_CenterX,WFM_ImCrop_CenterY,WFM_ImCrop_DiametR), 2)    
    WFM_Load_Lable_Pre = 'andor_';
    WFM_Load_Lable_End = '_1';
    
    WFM_Save_Index_Cen  = 50000;
    WFM_Load_Index_Ini  = 09200;
    WFM_Load_Index_End  = 90800;
    WFM_Load_Index_Stp  = 00400;
    
    S22_DataSave_WFM(File_22_WFMImg_ExpRaw,File_23_WFMImg_BkgRaw           ,...
                                           File_26_WFMImg_ExpPro           ,...
                     Data_01_formIm    ,Data_02_formDt    ,Index_Col       ,...
                     WFM_ImCrop_CenterX,WFM_ImCrop_CenterY,WFM_ImCrop_DiametR,...
                     WFM_Load_Lable_Pre,WFM_Load_Lable_End,WFM_Save_Index_Cen,...
                     WFM_Load_Index_Ini,WFM_Load_Index_End,WFM_Load_Index_Stp,...
                     WFM_Load_FlagImbkg,2)
end
close all;clc
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Video crop 
for idxsg = 1                                                              % FLFimg read and save name set    
    FLF_Load_Lable_Pre = 'rec00004_';
    FLF_Load_Lable_End = ''   ;
    
    FLF_Load_Index_Ini = 1;
    FLF_Load_Index_End = 3505;
    FLF_Load_Index_Stp = 1;
    FLF_Load_Index_Seg = 1;
    FLF_Load_FrameRate = 0.01;
    
    FLF_Load_ImshowMag = 3    
    FLF_ExpSub_crp_rad = 140;
    FLF_PSFSub_crp_sfx = -15;
    FLF_PSFSub_crp_sfy = -16;
    
    S27_DataSave_Video_CropTest(File_52_FLFVid_ExpRaw,File_32_FLFPSF_ExpRaw,...
                                FLF_ExpImg_range_y,FLF_ExpImg_range_x      ,...
                                FLF_Load_Lable_Pre,FLF_Load_Lable_End      ,...
                                FLF_Load_Index_Ini,FLF_Load_Index_End,FLF_Load_Index_Seg,...
                                Recons_43_NumEd   ,Data_02_formDt    ,FLF_Load_ImshowMag,...
                                FLF_PSFSub_crp_sfy,FLF_PSFSub_crp_sfx,FLF_ExpSub_crp_rad);
    
    Index_Col          = 'green';
    Flag_Vid           = 1;
    FLF_save_Index_Ini = 1;
    FLF_save_Index_End = 3505;
    S27_DataSave_Video_Crop1b1(File_52_FLFVid_ExpRaw,File_53_FLFVid_BkgRaw             ,...
                               File_32_FLFPSF_ExpRaw,File_56_FLFVid_ExpPro             ,...
                               Data_01_formIm,Data_02_formDt,Recons_43_NumEd,Index_Col ,...
                               FLF_ExpImg_range_y,FLF_ExpImg_range_x                   ,...
                               FLF_Load_Lable_Pre,FLF_Load_Lable_End,FLF_Load_FrameRate,...
                               FLF_Load_Index_Ini,FLF_Load_Index_End,FLF_Load_Index_Stp,...
                               FLF_save_Index_Ini,FLF_save_Index_End,FLF_Load_FlagVdbkg,...
                               FLF_ExpSub_crp_rad,FLF_PSFSub_crp_sfy,FLF_PSFSub_crp_sfx)
                           
    FLF_save_Index_Ini = 1;
    FLF_save_Index_End = 3505;
    FLF_ExpVid_Ind_Stp = 1
    FLF_ExpVid_Frameps = 100;
    S27_DataSave_Video_Make(File_56_FLFVid_ExpPro,'20210630_1811'                   ,...
                            Data_01_formVd,Data_02_formDt,Index_Col                 ,...
                            FLF_Load_Index_Ini,FLF_Load_Index_End,FLF_Load_Index_Stp,...
                            FLF_save_Index_Ini,FLF_save_Index_End,FLF_ExpVid_Ind_Stp,...
                            FLF_ExpSub_crp_rad,FLF_Load_FrameRate,FLF_ExpVid_Frameps)
end
close all;clc















































