function [Path_s010_objlam,Path_s020_FouLFM,Path_s040_zrange] =                   ...
          F31_FLFsys_para_Lable(Ma_01_obj,NA_01_obj,lambdaAir                    ,...
                                Fl_02_tub,Fl_03_ent,Dm_04_mic,Pi_04_MLA,fn_04_MLA,...
                                Object_31_FOVZl,Object_31_FOVZu,Object_32_STP_Z)
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Give the name involving the properties of the system
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Path_s010_objlam = [num2str(Ma_01_obj          ,'%03d')    'X',...
                'NA'   ,num2str(NA_01_obj          ,'%.2f')    '_',...
                'La'   ,num2str(lambdaAir      *1e9,'%.0f')  'nm_'];  
    Path_s020_FouLFM = ['FLF_',Path_s010_objlam                   ,...
                'ft'   ,num2str(Fl_02_tub      *1e3,'%03d')  'mm_',...
                'fe'   ,num2str(Fl_03_ent      *1e3,'%03d')  'mm_',...
                'MLA-S',num2str(Dm_04_mic      *1e6,'%04d')     '',...
                'P'    ,num2str(Pi_04_MLA      *1e6,'%04d')     '',...
                'f'    ,num2str(fn_04_MLA      *1e0,'%02d')    '_'];  
 
    Path_s040_zrange = ['zMmd-',num2str(Object_31_FOVZl*1e6),  '_',...
                                num2str(Object_31_FOVZu*1e6),  '_',...
                                num2str(Object_32_STP_Z*1e6),'um_'];
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Backup code
%     Path_s040_zrange = ['zMmd-',num2str(Object_31_FOVZl*1e6,'%.0f'),  '_',...
%                                 num2str(Object_31_FOVZu*1e6,'%.0f'),'um_',...
%                                 num2str(Object_32_STP_Z*1e9,'%03d'),'nm_'];  
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

































