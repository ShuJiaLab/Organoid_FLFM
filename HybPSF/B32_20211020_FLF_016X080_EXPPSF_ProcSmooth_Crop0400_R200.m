clear;  close all;  clc;
addpath(genpath('E:\00_Matlab_Code'))
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for idxsg = 1                                                              % Save path name   set                   
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
for idxsg = 1                                                              % Image  parameter  set                  
    Data_00_bit     = 16    ;                                              %get
    Data_00_maxval  = 2^Data_00_bit-1;
    Data_01_formIm  = '.tif';                                              %get
    Data_01_formVd  = '.tiff';                                             %get
    Data_02_formDt  = '.mat';                                              %get
    Data_04_smoothn = 1;                                                   %Get?Recons_00_NUMd
    Data_04_Oper_sm = fspecial('gaussian',[Data_04_smoothn Data_04_smoothn],0.6);
end

for idxsg = 1	                                                           % Save path name    set                  
    File_02_Time        = char(datetime('now','TimeZone','local','Format','yyMMdd_HHmm'));
    FLF_SimPSF_LoadPath = [File_31_FLFPSF_SimSav                 ];      
    FLF_ExpPSF_LoadPath = [File_32_FLFPSF_ExpRaw                 ];      
    FLF_ExpBKG_LoadPath = [File_33_FLFPSF_BkgRaw                 ];      
    FLF_SimPSF_Savepath = [File_31_FLFPSF_SimSav                 ];      
    FLF_HybPSF_SavePath = [File_36_FLFPSF_ExpPro,'_',File_02_Time];      mkdir(FLF_HybPSF_SavePath)
    FLF_HybPSF_SavePath = [File_36_FLFPSF_ExpPro,'_',File_02_Time];      mkdir(FLF_HybPSF_SavePath)
end
for idxsg = 1	                                                           % Save file name    set                  
    Name_Sub = 'Sub'
    Name_Crp = 'Crp'
    Name_Bin = 'Bin'
    Name_Org = 'Org'
    Name_Rez = 'Rez'
end
    FLF_Load_Image_bkg  = 0 
    WFM_Load_Image_bkg  = 1 
    FLF_Load_Video_bkg  = 1 
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for idxsg = 1                                                              % FLF subPSF cropped size para set       
    Recons_43_NumEd = 3;                                                   % FLF ExpPSF cropped size para set    
    Recons_43_NumEr = floor((Recons_43_NumEd-1)/2);
    Recons_44_Index = -Recons_43_NumEr:Recons_43_NumEr;
    
%     FLF_SubPSF_crp_dia = FLF_SubPSF_crp_rad*2+1;
%     FLF_SubPSF_crp_Int =-FLF_SubPSF_crp_rad:FLF_SubPSF_crp_rad;
    
    FLF_SimPSF_Bin_Num = 2;                                                % FLF SimPSF fine number para set    
    FLF_HybPSF_crp_rad = 250;                                              % FLF SimPSF fine one crop range set    
    FLF_HybPSF_crp_Int =-FLF_HybPSF_crp_rad:FLF_HybPSF_crp_rad             
    
    FLF_SimPSF_Rez_Num = 10;                                               % FLF SimPSF resize number para set    
    FLF_HyRPSF_crp_rad = floor( (FLF_HybPSF_crp_rad*2+1) * (FLF_SimPSF_Rez_Num/FLF_SimPSF_Bin_Num) /2 );
    FLF_HyRPSF_crp_Ind = -FLF_HyRPSF_crp_rad:+FLF_HyRPSF_crp_rad;          % FLF SimPSF resize crop range set    
end
for idxsg = 1                                                              % SimPSF load name set                   
    FLF_SimPSF_LoadNamePr1 = 'FLF_016XNA0.80_La525nm_ft300mm_fe200mm_MLA-S1300P3300f23_zMmd-';
    FLF_SimPSF_LoadNamePr2 = '-200_200um_400nm';
    FLF_SimPSF_LoadNamePr3 = '_P6.5um_RF2DN1SPD400_5_CCDCSF_Fine_';
    FLF_SimPSF_LoadNamePre = [FLF_SimPSF_LoadNamePr1,FLF_SimPSF_LoadNamePr2,FLF_SimPSF_LoadNamePr3];
    FLF_SimPSF_Loadnameend = 'um.mat';
    
    FLF_SimPSF_Sim_Stp = 0.4;
    FLF_SimPSF_Sim_Ini = -200;
    FLF_SimPSF_Sim_End = +200;
   [FLF_SimPSF_Sim_Dep,FLF_SimPSF_Sim_Int,FLF_SimPSF_Sim_Ind,...
    FLF_SimPSF_Sim_len,~                 ,FLF_SimPSF_Sim_Cet] = S03_Coord_Processed(...
    FLF_SimPSF_Sim_Stp,FLF_SimPSF_Sim_Ini,FLF_SimPSF_Sim_End)

    FLF_SimPSF_Use_Seg = 1
    FLF_SimPSF_Use_Ini = -200;
    FLF_SimPSF_Use_End = +200;
   [~                 ,~                 ,~                 ,~                 ,FLF_SimPSF_Use_Dep] = S02_Coord_Used(...
    FLF_SimPSF_Use_Ini,FLF_SimPSF_Use_End,FLF_SimPSF_Use_Seg,FLF_SimPSF_Sim_Ind,FLF_SimPSF_Sim_Dep);
end
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for idxsg = 1                                                              % ExpPSF load and save name and Crop range set
    FLF_ExpPSF_LoadLable_Ini = 'dcam_'   ;
    FLF_ExpPSF_LoadLable_End = '_1'      ;
    
    FLF_ExpPSF_LoadSti = 10000;
    FLF_ExpPSF_LoadStf = 90000;
    FLF_ExpPSF_LoadStc = 50000;
    FLF_ExpPSF_LoadStp = 00400;
    
    FLF_Location = imread(['..\','FLF_Location.tif']);
    U40_Imshow_Sat(FLF_Location, 2)
    U61_Imshow_B16_Col(exp(rescale(single(FLF_Location),0,1)).^20,254);
    
    FLF_ExpPSF_range_y = 270+(1:1503);  disp(length(FLF_ExpPSF_range_y))
    FLF_ExpPSF_range_x = 293+(1:1503);  disp(length(FLF_ExpPSF_range_x))
    
    U40_Imshow_Sat(                        FLF_Location(FLF_ExpPSF_range_y,FLF_ExpPSF_range_x), 2) 
    U40_Imshow_Sat(     exp(rescale(single(FLF_Location(FLF_ExpPSF_range_y,FLF_ExpPSF_range_x)),0,1)).^20,1e4) 
    U61_Imshow_B16_Col(exp(rescale(single(FLF_Location(FLF_ExpPSF_range_y,FLF_ExpPSF_range_x)),0,1)).^20,254);
    
    FLF_SubPSF_fit_rad = 100;                                               % FLF SubPSF original one fit range set   
end
for idxsg = 1                                                              % ExpPSF load and save name and Crop          
    [FLF_ExpPSF_Fit_len,FLF_ExpPSF_FitHalf,...
     FLF_ExpPSF_Fit_Dep,FLF_ExpPSF_Fit_Int,...
     FLF_ExpPSF_Rho_dia,FLF_ExpPSF_Sub_Dia,FLF_DnsPSF_Fit] = S21_DataSave_FLF_ExpPSF(...
                                      FLF_ExpPSF_LoadPath,...
                                      FLF_ExpBKG_LoadPath,...
                                      FLF_HybPSF_SavePath,...
                                      FLF_ExpPSF_LoadLable_Ini             ,...
                                      FLF_ExpPSF_LoadLable_End             ,...
                                      FLF_ExpPSF_LoadSti,FLF_ExpPSF_LoadStf,...
                                      FLF_ExpPSF_LoadStc,FLF_ExpPSF_LoadStp,...
                                      FLF_Load_Image_bkg,Recons_43_NumEd   ,...
                                      FLF_ExpPSF_range_y,FLF_ExpPSF_range_x,...
                                      Data_01_formIm     ,Data_02_formDt   ,FLF_SubPSF_fit_rad);
end
close all;clc
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% DnsPSF max position fitting and HybPSF position fitting
for idxsg = 1                                                              % ExpPSF subPSF Org & Rez max position   
    % use FLF_DnsPSF_Mod instead of FLF_DnsPSF_Nor
   [FLF_ExpPSF_sub_Xmax,FLF_ExpPSF_sub_Ymax,FLF_ExpPSF_sub_Zmax,...
    FLF_ExpPSF_sub_Xpos,FLF_ExpPSF_sub_Ypos,FLF_ExpPSF_sub_Zcen] = H94_CalcPSF_Exp_CenterFit(...
    FLF_DnsPSF_Fit     ,1                 , Recons_43_NumEd                       ,...
    FLF_ExpPSF_Fit_len ,FLF_SimPSF_Sim_len, FLF_ExpPSF_Fit_Int, FLF_SimPSF_Sim_Int,...
    FLF_ExpPSF_Sub_Dia ,FLF_SubPSF_fit_rad, FLF_HybPSF_SavePath,Data_01_formIm);
    
    save([FLF_HybPSF_SavePath,'\','FLFM_PSF_MaxintCoordinates_sub','.mat'],...
            'FLF_ExpPSF_sub_Xmax','FLF_ExpPSF_sub_Ymax','FLF_ExpPSF_sub_Zmax','-v7.3');
    save([FLF_HybPSF_SavePath,'\','FLFM_PSF_CenterCoordinates_bin','.mat'],...
            'FLF_ExpPSF_sub_Xpos','FLF_ExpPSF_sub_Ypos','FLF_ExpPSF_sub_Zcen','-v7.3');
    
   [FLF_ExpPSF_bin_Xmax,FLF_ExpPSF_bin_Ymax,FLF_ExpPSF_bin_Zmax,...
    FLF_ExpPSF_bin_Xpos,FLF_ExpPSF_bin_Ypos,FLF_ExpPSF_bin_Zcen] = H94_CalcPSF_Exp_CenterFit(...
    FLF_DnsPSF_Fit     ,FLF_SimPSF_Bin_Num, Recons_43_NumEd                       ,...
    FLF_ExpPSF_Fit_len ,FLF_SimPSF_Sim_len, FLF_ExpPSF_Fit_Int, FLF_SimPSF_Sim_Int,...
    FLF_ExpPSF_Sub_Dia ,FLF_SubPSF_fit_rad, FLF_HybPSF_SavePath,Data_01_formIm);
    
    save([FLF_HybPSF_SavePath,'\','FLFM_PSF_MaxintCoordinates_bin','.mat'],...
            'FLF_ExpPSF_bin_Xmax','FLF_ExpPSF_bin_Ymax','FLF_ExpPSF_bin_Zmax','-v7.3');
    save([FLF_HybPSF_SavePath,'\','FLFM_PSF_CenterCoordinates_bin','.mat'],...
            'FLF_ExpPSF_bin_Xpos','FLF_ExpPSF_bin_Ypos','FLF_ExpPSF_bin_Zcen','-v7.3');
        
   [FLF_ExpPSF_rez_Xmax,FLF_ExpPSF_rez_Ymax,FLF_ExpPSF_rez_Zmax,...
    FLF_ExpPSF_rez_Xpos,FLF_ExpPSF_rez_Ypos,FLF_ExpPSF_rez_Zcen] = H94_CalcPSF_Exp_CenterFit_Rez(...
    FLF_DnsPSF_Fit     ,FLF_SimPSF_Rez_Num ,Recons_43_NumEd                       ,...
    FLF_ExpPSF_Fit_len ,FLF_SimPSF_Sim_len ,FLF_ExpPSF_Fit_Dep, FLF_SimPSF_Sim_Dep,...
    FLF_ExpPSF_Sub_Dia ,FLF_SubPSF_fit_rad, FLF_HybPSF_SavePath,Data_01_formIm    );
    
    save([FLF_HybPSF_SavePath,'\','FLFM_PSF_MaxintCoordinates_rez','.mat'],...
            'FLF_ExpPSF_rez_Xmax','FLF_ExpPSF_rez_Ymax','FLF_ExpPSF_rez_Zmax','-v7.3');
    save([FLF_HybPSF_SavePath,'\','FLFM_PSF_CenterCoordinates_rez','.mat'],...
            'FLF_ExpPSF_rez_Xpos','FLF_ExpPSF_rez_Ypos','FLF_ExpPSF_rez_Zcen','-v7.3');
end
close all;clc
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% HybPSF parameter set
for idxsg = 1                                                              % HybPSF parameter set                   
%     FLF_ExpPSF_bin_Ztep = FLF_ExpPSF_bin_Zcen
%     FLF_ExpPSF_bin_Zcen = FLF_ExpPSF_bin_Ztep
%     FLF_ExpPSF_rez_Zcen = FLF_ExpPSF_bin_Ztep
    FLF_ExpPSF_bin_Zcen = zeros(3)
    FLF_ExpPSF_rez_Zcen = zeros(3)
    
    disp(FLF_ExpPSF_bin_Zcen);
    disp(FLF_ExpPSF_rez_Zcen);
    
    FLF_PSFhyb_Use_Ini = -150;
    FLF_PSFhyb_Use_End = +150;

    FLF_PSFhyb_Use_Ini = -200;
    FLF_PSFhyb_Use_End = +200;

   [FLF_PSFhyb_Use_Frm,FLF_PSFhyb_Use_Int,FLF_PSFhyb_Use_Ind,...
    FLF_PSFhyb_Use_len,FLF_PSFhyb_UseHalf,FLF_PSFhyb_Use_Cet] = S03_Coord_Processed(...
    FLF_SimPSF_Sim_Stp,FLF_PSFhyb_Use_Ini,FLF_PSFhyb_Use_End);
    
    FLF_PSFhyb_Use_Ind  = FLF_SimPSF_Sim_Cet  + FLF_PSFhyb_Use_Int;
    FLF_ExpPSF_sub_Zini = FLF_ExpPSF_bin_Zcen + FLF_PSFhyb_Use_Ind( 1 );
    FLF_ExpPSF_rez_Zini = FLF_ExpPSF_rez_Zcen + FLF_PSFhyb_Use_Ind( 1 );
    FLF_ExpPSF_sub_Zend = FLF_ExpPSF_bin_Zcen + FLF_PSFhyb_Use_Ind(end);
    FLF_ExpPSF_rez_Zend = FLF_ExpPSF_rez_Zcen + FLF_PSFhyb_Use_Ind(end);
    
    disp(FLF_ExpPSF_sub_Zini);    disp(FLF_SimPSF_Sim_len-FLF_ExpPSF_sub_Zend);
    disp(FLF_ExpPSF_rez_Zini);    disp(FLF_SimPSF_Sim_len-FLF_ExpPSF_rez_Zend);
    
    FLF_HybPSF_saveDept = ['_',num2str(FLF_PSFhyb_Use_Ini,'%+08.3f'),...
                           '_',num2str(FLF_PSFhyb_Use_End,'%+08.3f')];
    FLF_HybPSF_saveUniN = [FLF_HybPSF_SavePath,'\','FLF_HybPSF',FLF_HybPSF_saveDept];
    FLF_HyRPSF_saveUniN = [FLF_HybPSF_SavePath,'\','FLF_HyRPSF',FLF_HybPSF_saveDept];
    FLF_HySPSF_saveUniN = [FLF_HybPSF_SavePath,'\','FLF_HySPSF',FLF_HybPSF_saveDept];
end
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for idxsg = 1                                                              % HyRPSF generation                      
    tic
    FLF_SimPSF_Par_Seg = 50
    FLF_HyRPSF_Bin_Dia = FLF_ExpPSF_Rho_dia/Recons_43_NumEd   ;
    FLF_HyRPSF_Sub_Dia = FLF_HyRPSF_Bin_Dia*FLF_SimPSF_Rez_Num;
                                                                           % HyRPSF matrix create    
    FLF_HyRPSF_Bin = zeros(FLF_ExpPSF_Rho_dia , FLF_ExpPSF_Rho_dia , FLF_PSFhyb_Use_len);
    for idxet = 1:Recons_43_NumEd                                          % SimPSF SubRez load eleimg by eleimg     
    for idxxi = 1:Recons_43_NumEd                                          % SimPSF SubRez load eleimg by eleimg
        FLF_PSFhyb_Ele_Ini = FLF_ExpPSF_rez_Zini(idxet,idxxi);
        FLF_PSFhyb_Ele_End = FLF_ExpPSF_rez_Zend(idxet,idxxi);
        
       [FLF_SimPSF_Par_Ind,FLF_HybPSF_Par_Ini,FLF_HybPSF_Par_End] = S02_Coord_Used_Partition(        ...
        FLF_SimPSF_Sim_Ind,FLF_PSFhyb_Ele_Ini,FLF_PSFhyb_Ele_End,FLF_SimPSF_Par_Seg,FLF_SimPSF_Sim_Dep);
        
        for idxfs = FLF_HybPSF_Par_Ini:(FLF_HybPSF_Par_End-1)              % SimPSF SubRez load part by frame       

                                                                           % SimPSF SubRez load frame for part idxfs
                                                                           % idxfs = FLF_HybPSF_Par_Ini     % Test
                                                                           % idxfs = FLF_HybPSF_Par_Ini     % Test
                                                                           % idxfs = FLF_HybPSF_Par_End-1   % Test
            FLF_HyRPSF_Seg_Frm = max(FLF_SimPSF_Par_Ind(idxfs)    , FLF_PSFhyb_Ele_Ini):...
                                 min(FLF_SimPSF_Par_Ind(idxfs+1)-1, FLF_PSFhyb_Ele_End);  
            FLF_SimPSF_Seg_Ind = max(FLF_SimPSF_Par_Ind(idxfs)    , FLF_SimPSF_Par_Ind(001)):...
                                 min(FLF_SimPSF_Par_Ind(idxfs+1)-1, FLF_SimPSF_Par_Ind(end));
            
            FLF_HyRPSF_Rez         = zeros( FLF_HyRPSF_Sub_Dia , FLF_HyRPSF_Sub_Dia , length(FLF_HyRPSF_Seg_Frm));
            
            FLF_SimPSF_LoadNameDep = [num2str(FLF_SimPSF_Use_Dep(FLF_SimPSF_Seg_Ind( 1 )),'%+06.1f'),'_'       ,...
                                      num2str(FLF_SimPSF_Use_Dep(FLF_SimPSF_Seg_Ind(end)),'%+06.1f'),'um_400nm',];
            FLF_SimPSF_LoadNameSeg = [FLF_SimPSF_LoadNamePr1,FLF_SimPSF_LoadNameDep,FLF_SimPSF_LoadNamePr3];
                                                                           % SimPSF SubRez cropped part save
            load([FLF_SimPSF_Savepath,'\',FLF_SimPSF_LoadNameSeg,Name_Sub,Name_Rez,...
                                      '_',num2str(Recons_44_Index(idxet),'%+d'),...
                                      '_',num2str(Recons_44_Index(idxxi),'%+d'),'.mat'])
%             U65_Imshow_B16_MIP_3D_Hot(FLF_SimPSF_sub_rez);
            for idxfr = FLF_HyRPSF_Seg_Frm                                 % SimPSF SubPSF embeded                  
                FLF_HyRPSF_Rez( FLF_ExpPSF_rez_Ypos(idxet,idxxi,idxfr) - (idxet-1)*FLF_HyRPSF_Sub_Dia + FLF_HyRPSF_crp_Ind,...
                                FLF_ExpPSF_rez_Xpos(idxet,idxxi,idxfr) - (idxxi-1)*FLF_HyRPSF_Sub_Dia + FLF_HyRPSF_crp_Ind,...
                                                                idxfr  +  1       -FLF_HyRPSF_Seg_Frm(1)                )= ...
                FLF_SimPSF_sub_rez(:,:,                         idxfr  - (idxfs-1)*FLF_SimPSF_Par_Seg);           disp(idxfr);
            end
            U65_Imshow_B16_MIP_3D_Hot(FLF_HyRPSF_Rez);
            FLF_HyRPSF_Bin((idxet-1)*FLF_HyRPSF_Bin_Dia +(1:FLF_HyRPSF_Bin_Dia),...
                           (idxxi-1)*FLF_HyRPSF_Bin_Dia +(1:FLF_HyRPSF_Bin_Dia),...
                                     FLF_HyRPSF_Seg_Frm + 1-FLF_PSFhyb_Ele_Ini  ) = O12_pixelBinning_3D(FLF_HyRPSF_Rez,FLF_SimPSF_Rez_Num);
            
%             U65_Imshow_B16_MIP_3D_Hot(FLF_HyRPSF_Bin);                     % HyRPSF imshow: 3Dmax projection show
            close all;
        end
        
        for idxfs = FLF_HybPSF_Par_End                                     % SimPSF SubRez load part by frame       
                                                                           % SimPSF SubRez load frame for part idxfs   
                                                                           % idxfs = FLF_HybPSF_Par_Ini     % Test
                                                                           % idxfs = FLF_HybPSF_Par_Ini     % Test
                                                                           % idxfs = FLF_HybPSF_Par_End-1   % Test
            if (FLF_SimPSF_Par_Ind(FLF_HybPSF_Par_End) == FLF_PSFhyb_Ele_End)
                
                FLF_HyRPSF_Seg_Frm = FLF_SimPSF_Par_Ind(idxfs);  
                FLF_SimPSF_Seg_Ind = FLF_SimPSF_Par_Ind(idxfs);

                FLF_HyRPSF_Rez         = zeros( FLF_HyRPSF_Sub_Dia , FLF_HyRPSF_Sub_Dia );
                
                FLF_SimPSF_LoadNameDep = [num2str(FLF_SimPSF_Use_Dep(FLF_SimPSF_Seg_Ind( 1 )),'%+06.1f'),'_'       ,...
                                          num2str(FLF_SimPSF_Use_Dep(FLF_SimPSF_Seg_Ind(end)),'%+06.1f'),'um_400nm',];
                FLF_SimPSF_LoadNameSeg = [FLF_SimPSF_LoadNamePr1,FLF_SimPSF_LoadNameDep,FLF_SimPSF_LoadNamePr3];
                                                                               % SimPSF SubRez cropped part save
                load([FLF_SimPSF_Savepath,'\',FLF_SimPSF_LoadNameSeg,Name_Sub,Name_Rez,...
                                          '_',num2str(Recons_44_Index(idxet),'%+d'),...
                                          '_',num2str(Recons_44_Index(idxxi),'%+d'),'.mat'])
    %             U65_Imshow_B16_MIP_3D_Hot(FLF_SimPSF_sub_rez);
                for idxfr = FLF_HyRPSF_Seg_Frm                                 % SimPSF SubPSF embeded
                    FLF_HyRPSF_Rez( FLF_ExpPSF_rez_Ypos(idxet,idxxi,idxfr) - (idxet-1)*FLF_HyRPSF_Sub_Dia + FLF_HyRPSF_crp_Ind,...
                                    FLF_ExpPSF_rez_Xpos(idxet,idxxi,idxfr) - (idxxi-1)*FLF_HyRPSF_Sub_Dia + FLF_HyRPSF_crp_Ind,...
                                                                    idxfr  +  1       -FLF_HyRPSF_Seg_Frm(1)                )= ...
                    FLF_SimPSF_sub_rez(:,:,                         idxfr  - (idxfs-1)*FLF_SimPSF_Par_Seg  );         disp(idxfr);
                end
                U65_Imshow_B16_MIP_3D_Hot(FLF_HyRPSF_Rez);
                FLF_HyRPSF_Bin((idxet-1)*FLF_HyRPSF_Bin_Dia +(1:FLF_HyRPSF_Bin_Dia),...
                               (idxxi-1)*FLF_HyRPSF_Bin_Dia +(1:FLF_HyRPSF_Bin_Dia),...
                                         FLF_HyRPSF_Seg_Frm + 1-FLF_PSFhyb_Ele_Ini  ) = O12_pixelBinning_3D(FLF_HyRPSF_Rez,FLF_SimPSF_Rez_Num);
            end
%             U65_Imshow_B16_MIP_3D_Hot(FLF_HyRPSF_Bin);                     % HyRPSF imshow: 3Dmax projection show
            close all;
        end
    end
    end
    toc
end
for idxsg = 1                                                              % HyRPSF save                            
    FLF_HyRPSF_Nor = rescale(FLF_HyRPSF_Bin);
    U65_Imshow_B16_MIP_3D_Hot(FLF_HyRPSF_Nor);
    S65_Imsave_B16_MIP_3D(    FLF_HyRPSF_saveUniN           ,Data_01_formIm , FLF_HyRPSF_Nor ,1);
    S69_Imsave_B16_DepthC_Col(FLF_HybPSF_saveUniN           ,Data_01_formIm , FLF_HyRPSF_Nor ,294,0   ,2,0);
                     save(   [FLF_HyRPSF_saveUniN,'_','Nor' ,Data_02_formDt],'FLF_HyRPSF_Nor','-v7.3');
end
close all;clc
clear FLF_SimPSF_sub_rez;
clear FLF_HyRPSF_Rez;
clear FLF_HyRPSF_Bin;
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for idxsg = 1                                                              % FLF HybPSF FOV limited one crop range set 
    FLF_SubPSF_crp_sft = 16;                                               % FLF HybPSF FOV limited one crop range set
    FLF_SubPSF_crp_rad = 55+floor(FLF_SubPSF_crp_sft/2);                   % FLF HybPSF FOV limited one crop range set
    S21_DataSave_FLF_HySPSF(FLF_HySPSF_saveUniN,FLF_HyRPSF_Nor     ,...
                            Data_01_formIm     ,Data_02_formDt     ,...
                            FLF_SubPSF_crp_rad ,Recons_43_NumEd    ,...
                            FLF_ExpPSF_sub_Ymax,FLF_ExpPSF_sub_Xmax,...
                            FLF_ExpPSF_FitHalf)
    close all;clc
    
    FLF_SubPSF_showrat = 1
    FLF_SubPSF_crp_sft = 16;                                               % FLF HybPSF FOV limited one crop range set
    FLF_SubPSF_crp_rad = 55+floor(FLF_SubPSF_crp_sft/2);                   % FLF HybPSF FOV limited one crop range set
    S21_DataSave_FLF_HySPSF_Image(FLF_HySPSF_saveUniN,FLF_HyRPSF_Nor     ,Data_01_formIm    ,...
                                  FLF_ExpPSF_sub_Ymax,FLF_ExpPSF_sub_Xmax,FLF_ExpPSF_FitHalf,...
                                  Recons_43_NumEd    ,FLF_SubPSF_crp_rad ,FLF_SubPSF_showrat,...
                                  294,2,0)
    close all;clc
end
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for idxsg = 1                                                              % FLF HybPSF FOV limited one crop range set 
    FLF_SubPSF_crp_sft = 31;                                               % FLF HybPSF FOV limited one crop range set
    FLF_SubPSF_crp_rad = 55+floor(FLF_SubPSF_crp_sft/2);                   % FLF HybPSF FOV limited one crop range set
    S21_DataSave_FLF_HySPSF(FLF_HySPSF_saveUniN,FLF_HyRPSF_Nor     ,...
                            Data_01_formIm     ,Data_02_formDt     ,...
                            FLF_SubPSF_crp_rad ,Recons_43_NumEd    ,...
                            FLF_ExpPSF_sub_Ymax,FLF_ExpPSF_sub_Xmax,...
                            FLF_ExpPSF_FitHalf)
    close all;clc
    
    FLF_SubPSF_crp_sft = 90;                                               % FLF HybPSF FOV limited one crop range set
    FLF_SubPSF_crp_rad = 55+floor(FLF_SubPSF_crp_sft/2);                   % FLF HybPSF FOV limited one crop range set
    S21_DataSave_FLF_HySPSF(FLF_HySPSF_saveUniN,FLF_HyRPSF_Nor     ,...
                            Data_01_formIm     ,Data_02_formDt     ,...
                            FLF_SubPSF_crp_rad ,Recons_43_NumEd    ,...
                            FLF_ExpPSF_sub_Ymax,FLF_ExpPSF_sub_Xmax,...
                            FLF_ExpPSF_FitHalf)
    close all;clc
    
    FLF_SubPSF_crp_sft = 140;                                              % FLF HybPSF FOV limited one crop range set
    FLF_SubPSF_crp_rad = 55+floor(FLF_SubPSF_crp_sft/2);                   % FLF HybPSF FOV limited one crop range set
    S21_DataSave_FLF_HySPSF(FLF_HySPSF_saveUniN,FLF_HyRPSF_Nor     ,...
                            Data_01_formIm     ,Data_02_formDt     ,...
                            FLF_SubPSF_crp_rad ,Recons_43_NumEd    ,...
                            FLF_ExpPSF_sub_Ymax,FLF_ExpPSF_sub_Xmax,...
                            FLF_ExpPSF_FitHalf)
    close all;clc
    
    FLF_SubPSF_crp_sft = 170;                                              % FLF HybPSF FOV limited one crop range set
    FLF_SubPSF_crp_rad = 55+floor(FLF_SubPSF_crp_sft/2);                   % FLF HybPSF FOV limited one crop range set
    S21_DataSave_FLF_HySPSF(FLF_HySPSF_saveUniN,FLF_HyRPSF_Nor     ,...
                            Data_01_formIm     ,Data_02_formDt     ,...
                            FLF_SubPSF_crp_rad ,Recons_43_NumEd    ,...
                            FLF_ExpPSF_sub_Ymax,FLF_ExpPSF_sub_Xmax,...
                            FLF_ExpPSF_FitHalf)
    close all;clc

    FLF_SubPSF_crp_sft = 190;                                              % FLF HybPSF FOV limited one crop range set
    FLF_SubPSF_crp_rad = 55+floor(FLF_SubPSF_crp_sft/2);                   % FLF HybPSF FOV limited one crop range set
    S21_DataSave_FLF_HySPSF(FLF_HySPSF_saveUniN,FLF_HyRPSF_Nor     ,...
                            Data_01_formIm     ,Data_02_formDt     ,...
                            FLF_SubPSF_crp_rad ,Recons_43_NumEd    ,...
                            FLF_ExpPSF_sub_Ymax,FLF_ExpPSF_sub_Xmax,...
                            FLF_ExpPSF_FitHalf)
    close all;clc
    
    FLF_SubPSF_crp_sft = 290;                                              % FLF HybPSF FOV limited one crop range set
    FLF_SubPSF_crp_rad = 55+floor(FLF_SubPSF_crp_sft/2);                   % FLF HybPSF FOV limited one crop range set
    S21_DataSave_FLF_HySPSF(FLF_HySPSF_saveUniN,FLF_HyRPSF_Nor     ,...
                            Data_01_formIm     ,Data_02_formDt     ,...
                            FLF_SubPSF_crp_rad ,Recons_43_NumEd    ,...
                            FLF_ExpPSF_sub_Ymax,FLF_ExpPSF_sub_Xmax,...
                            FLF_ExpPSF_FitHalf)
    close all;clc
end





























