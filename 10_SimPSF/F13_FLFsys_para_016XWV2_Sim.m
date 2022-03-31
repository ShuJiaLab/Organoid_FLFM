function [Step_NIP_Finetune,Step_Propergation,...
          Flag_WFMPSFOnly  ,Flag_Simulation  ,...
          Flag_simPSFfine  ,Flag_Profilesim  ,...
          P291_NIP_Size_Ext,P292_NIP_Size_Wav,P293_NIP_Size_Num,...
          P490_MLA_Beam_Rat,P491_MLA_lens_Num,...
          P492_MLA_lens_Ext,Flag_MLA_size_Odd,...
          Flag_MLA_grid_Hex,Flag_MLA_grid_Inv,...
          Flag_Lens_On_axis,Flag_Lens_All_Use,...          
          Flag_Lens_Tra_Cir,Flag_Lens_Apt_Cir,...
          Flag_Aperture      ] = F13_FLFsys_para_016XWV2_Sim()
      
    Step_NIP_Finetune = 2*10^-8;                                       
    Step_Propergation = 1*10^-4;                                       
    
    Flag_WFMPSFOnly = 0;                                                   % profile simulatn, piont_sim = 1
                                                                           % no profile simul, piont_sim = 0
    Flag_Simulation = 1;                                                   % simulation only , piont_sim = 1
                                                                           % deconvolutionPSF, piont_sim = 0
    Flag_simPSFfine = 1;                                                   % profile simulatn, piont_sim = 1
                                                                           % no profile simul, piont_sim = 0
    Flag_Profilesim = 0;                                                   % profile simulatn, piont_sim = 1
                                                                           % no profile simul, piont_sim = 0   
    P291_NIP_Size_Ext = 3 ;
    P292_NIP_Size_Wav = 10;
    P293_NIP_Size_Num = 1451;
    
    P490_MLA_Beam_Rat = 1.93;
    P491_MLA_lens_Num = 3;
%     P492_MLA_lens_Ext = 2;
    P492_MLA_lens_Ext = 0;
    
    Flag_MLA_size_Odd = 1;                                                 % set lenslets size odd      , Flag = 1
                                                                           % set lenslets size as normal, Flag = 0
    Flag_MLA_grid_Hex = 0;
    Flag_MLA_grid_Inv = 1;
    
    Flag_Lens_On_axis = 1;
    Flag_Lens_All_Use = 0;
    
    Flag_Lens_Tra_Cir = 0;
    Flag_Lens_Apt_Cir = 1;
    
    Flag_Aperture     = 0;
end


































