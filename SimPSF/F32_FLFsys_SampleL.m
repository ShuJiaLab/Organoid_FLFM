function [Data_06_CCD_DN   ,Data_06_CCD_RF     ,...
          P27_NIP_RefAr_Odd,P27_NIP_RefAr_Eve  ,...
          P27_WFM_RefAd_Odd,P27_WFM_RefAd_Eve  ,...
          P35_Len_NumPd_DN ,P37_Len_NumPd_RF ,P37_Len_NumAd_RF,...
          P47_Fou_NumAd_RF ,P47_MLA_NumAdSim ,P47_MLA_NumAd_RF,...
          Path_s031Lsample ,Path_s033Lsample                  ]...
        = F32_FLFsys_SampleL(                                                  ...
          Ma_06_Mic, NA_01_obj, Pi_04_MLA  ,Dm_04_mic, Pi_05_cam, Num05_cam   ,...
          Data_05_DownRT  ,Data_05_Refine  ,Object_31_FOVZm                   ,...
          Theory_22_NatRd ,Theory_23_FouRd ,Theory_31_NumEl ,Theory_41_ResNL  ,...
          P291NIP_Size_Ext,P292NIP_Size_Wav,P293NIP_Size_Num,P492_MLA_lens_Ext,...
          Flag_Simulation ,Flag_WFMPSFOnly ,Flag_simPSFfine ,P491_MLA_lens_Num,Flag_MLAsizeOdd)
%         
%       
%         Data_05_DownRT   = Data_05HDownRT;
%         Data_05_RefInt   = Data_05HRifine;
        
        Data_05_RefInt   =     round(Data_05_Refine);
        Data_06_CCD_DN   = Pi_05_cam*Data_05_DownRT;                       % Downsampling effective pixel size
        Data_06_CCD_RF   = Pi_05_cam*Data_05_DownRT/Data_05_RefInt;        % Oversampling effective pixel size
        
        P20_NIP_NumAd_Ray = ceil(Object_31_FOVZm*Ma_06_Mic^2*tan(asin(NA_01_obj/Ma_06_Mic))*2*P291NIP_Size_Ext/Data_06_CCD_RF );          % Size of NIP given by ray optics: cone bottom determined by z range 
        P20_NIP_NumAd_Wav = ceil(Theory_41_ResNL*Ma_06_Mic*P292NIP_Size_Wav                  *P291NIP_Size_Ext/Data_06_CCD_RF );          % Size of NIP given by ray optics:  
        P20_NIP_NumAd_FOV = ceil(Theory_22_NatRd                                                              /Data_06_CCD_RF );          % Size of NIP given by the FOV;
        P20_NIP_NumAd_cam = ceil(Num05_cam                                                   /Data_05_DownRT  *Data_05_RefInt );          % Size of NIP given by the size of the camera chip 
        P20_NIP_NumAd_Art = ceil(P293NIP_Size_Num                                            /Data_05_DownRT  *Data_05_RefInt );          % Size of NIP given by the size of nonzero part of PSF(Z_MAX) that is normalized to 65535. 
        if     Flag_WFMPSFOnly == 1                                                          % Simulate only WFM PSF. 
            P27_NIP_NumAd_RF =      P20_NIP_NumAd_Art;                                       %
        elseif Flag_simPSFfine == 1                                                          % Simulate fine   PSF for the NIP of FLFM
            P27_NIP_NumAd_RF = min([P20_NIP_NumAd_Art                  ,P20_NIP_NumAd_FOV]); %  
        else                                                                                 % Simulate coarse PSF for the NIP of FLFM
            P27_NIP_NumAd_RF = min([P20_NIP_NumAd_Ray,P20_NIP_NumAd_Wav,P20_NIP_NumAd_FOV]); %  
        end
            P27_WFM_NumAd_OE = min([P20_NIP_NumAd_cam                  ,P20_NIP_NumAd_FOV]); % WFM PSF size that can be recorded and limited by the size of the camera.
        
        P27_NIP_RefAr_Odd =(floor(((floor(O10_pixelBinning_size(P27_NIP_NumAd_RF,Data_05_RefInt)/2)*2+1)*Data_05_RefInt)/2)*2+1-1)/2;
        P27_NIP_RefAr_Eve =(floor(((floor(O10_pixelBinning_size(P27_NIP_NumAd_RF,Data_05_RefInt)/2)*2+0)*Data_05_RefInt)/2)*2+0-1)/2;
        P27_WFM_RefAd_Odd = floor(((floor(O10_pixelBinning_size(P27_WFM_NumAd_OE,Data_05_RefInt)/2)*2+1)*Data_05_RefInt)/2)*2+1;
        P27_WFM_RefAd_Eve = floor(((floor(O10_pixelBinning_size(P27_WFM_NumAd_OE,Data_05_RefInt)/2)*2+0)*Data_05_RefInt)/2)*2+0;
        
        P35_Len_NumPd_DN = round(Pi_04_MLA      /Data_06_CCD_DN);          % Size of a MLA     pitch    in unit of downsampling pixel 
    if (Flag_Simulation==1)
        P37_Len_NumPd_RF = round(Pi_04_MLA      /Data_06_CCD_RF);          % Size of a MLA     pitch    in unit of Oversampling pixel 
        P37_Len_NumAd_RF = round(Dm_04_mic      /Data_06_CCD_RF);          % Size of a lenslet aperture in unit of Oversampling pixel 
        P47_Fou_NumAd_RF = round(Theory_23_FouRd/Data_06_CCD_RF);          % Size of a Fourier plane    in unit of Oversampling pixel 
    else
        P37_Len_NumPd_RF = round(Pi_04_MLA      /Data_06_CCD_DN)*Data_05_RefInt;    
        P37_Len_NumAd_RF = round(Dm_04_mic      /Data_06_CCD_DN)*Data_05_RefInt ;
        P47_Fou_NumAd_RF = round(Theory_23_FouRd/Data_06_CCD_DN)*Data_05_RefInt;
    end
        P47_MLA_NumAdSim = P37_Len_NumPd_RF*(Theory_31_NumEl + P492_MLA_lens_Ext);	% Size of a MLA part simulated   in unit of Oversampling pixel 
        P47_MLA_NumAd_RF = P37_Len_NumPd_RF*                   P491_MLA_lens_Num ;	% Size of a MLA part illuminated in unit of Oversampling pixel 
        
	if (Flag_MLAsizeOdd)
        P47_MLA_NumAdSim = P16_ParityMatch_Add(P16_ParityMatch_Add(O10_pixelBinning_size(P47_MLA_NumAdSim,Data_05_RefInt),1)*Data_05_RefInt,1);
        P47_MLA_NumAd_RF = P16_ParityMatch_Add(P16_ParityMatch_Add(O10_pixelBinning_size(P47_MLA_NumAd_RF,Data_05_RefInt),1)*Data_05_RefInt,1);
    end
    
        Path_s031Lsample =['P'  ,num2str(Pi_05_cam      *1e6) 'um_',...
                           'RF' ,num2str(Data_05_RefInt *1e0)      ,...
                           'DN' ,num2str(Data_05_DownRT *1e0)      ,...
                           'SPD',num2str(P37_Len_NumAd_RF)];
        Path_s033Lsample =['P'  ,num2str(Pi_05_cam      *1e6) 'um_',...
                           'RF' ,num2str(Data_05_RefInt *1e0)      ,...
                           'DN' ,num2str(Data_05_DownRT *1e0)      ,...
                           'SPD',num2str(P37_Len_NumAd_RF)];
end

function size_new       = P16_ParityMatch_Add(  size_old,size_cmp)
%  To match the parity of number 1 and number 2
    size_new = size_old + xor(mod(size_old,2),mod(size_cmp,2));
end

function Image_pin_size = O10_pixelBinning_size(Size_org,Numb_org)
%     tic
%     Image_org = P20_NIP_CSFOdd;
%     Numbe_org = Data_05_Rifine;
% Size_org = 21
% Numb_org = 4
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Illustration how codes works
% disp(O10_pixelBinning_size(16,4)-4)
% disp(O10_pixelBinning_size(18,4)-4)
% disp(O10_pixelBinning_size(20,4)-5)
% disp(O10_pixelBinning_size(17,4)-4)
% disp(O10_pixelBinning_size(19,4)-4)
% disp(O10_pixelBinning_size(21,4)-5)
% disp(O10_pixelBinning_size(15,3)-5)
% disp(O10_pixelBinning_size(17,3)-5)
% disp(O10_pixelBinning_size(19,3)-5)
% disp(O10_pixelBinning_size(20,3)-6)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        flag__odd_even = xor( mod(Size_org,2),mod(Numb_org,2));            %   精细像尺寸同放大倍数奇偶性是否一致
    if  flag__odd_even                                                     %   精细像尺寸同放大倍数奇偶性一致
        size_modify = Size_org*2;
        Numb_modify = Numb_org*2;
    else
        size_modify = Size_org  ;
        Numb_modify = Numb_org  ;
    end
    
        size_modify_half = floor(size_modify/2);
        Numb_modify_half = floor(Numb_modify/2);
    
    if(mod(Numb_modify,2))                                                 % 降采样像起始点坐标偏移
        size_org_cut  = mod(size_modify_half - Numb_modify_half ,Numb_modify)  ;   
    else
        size_org_cut  = mod(size_modify                         ,Numb_modify)/2;   
    end
        Image_pin_ini  =     1       + size_org_cut;                              % 降采样像起始坐标
        Image_pin_end  = size_modify - size_org_cut;                              % 降采样像终止坐标
        Image_pin_size =   ( 1       + Image_pin_end -Image_pin_ini)/Numb_modify; % 降采样像尺寸
end



