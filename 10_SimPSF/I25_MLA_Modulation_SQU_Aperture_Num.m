function MicLAr_4T_TFunc = I25_MLA_Modulation_SQU_Aperture_Num(...
                               Fl_04_MLA, k0,  Data_06_CCD_DN   ,...
                               Len_37_Pitch, Len_37_Apert, Len_37_NumAd,...
                               MLA_47_Diamt, Fou_49_BeamD, BeamLenratio,...
                               Sgn_circle  , Sgn_center  , Sgn_Aperture,...
                               Sgn_alluse  )  
% Explanation
% Test 1
%         Len_37_Pitch = P37_Len_NumPd_RF;
%         Len_37_Apert = P37_Len_NumPd_RF;
%         Len_37_NumAd = P37_Len_NumAd_RF;
%         MLA_47_Diamt = P47_MLA_NumAd_RF;
%         Fou_49_BeamD = P47_Fou_NumAd_RF;
%         BeamLenratio = 1.51
%         Sgn_circle   = Flag_LensTraCir;
%         Sgn_center   = Flag_LensletCen;
%         Sgn_Aperture = 0;
%         Sgn_alluse   = 0;


    for idxta = 1   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  单个微透镜pattern
            MicLen_37_NumXd = ceil(Len_37_Apert);                          MicLen_37_NumXr = (MicLen_37_NumXd-1)/2;
            MicLen_37_NumYd = ceil(Len_37_Apert);                          MicLen_37_NumYr = (MicLen_37_NumYd-1)/2;
%             I23_MicLen_48_VarXi = 1:I23_MicLen_47_NumXd;
%             I23_MicLen_48_VarYi = 1:I23_MicLen_47_NumYd;
            
           [MicLen_37_VarXX , MicLen_47_VarYY] = meshgrid(gpuArray(Data_06_CCD_DN*(-MicLen_37_NumXr :1: MicLen_37_NumXr)), ...
                                                          gpuArray(Data_06_CCD_DN*(-MicLen_37_NumYr :1: MicLen_37_NumYr)));
            MicLen_30_Funct = MicLen_37_VarXX.^2 + MicLen_47_VarYY.^2   ;
            
        if(Sgn_Aperture==0)   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  是微透镜还是小孔单元
            MicLen_30_TFGPU = exp(-1i*k0*MicLen_30_Funct/(2*Fl_04_MLA));
        else
            MicLen_30_TFGPU = ones(MicLen_37_NumYd , MicLen_37_NumXd);
        end
        
        if( Sgn_circle==1)   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  单个微透镜Aperture是否为圆
            MicLen_30_TFGPU(sqrt(  MicLen_30_Funct)> MicLen_37_NumXr*Data_06_CCD_DN) = 0;
        end
        
            MicLen_30_TFunc = gather(MicLen_30_TFGPU);                     figure(620); imshow( uint16( MicLen_30_TFunc/max(MicLen_30_TFunc(:)) * 65535) );
    end
    
    for idxta = 1   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  微透镜阵列pattern1
            MPitch_37_NumXd =  ceil(Len_37_Pitch);              
            MPitch_37_NumYd =  ceil(Len_37_Pitch);                               % lenslets周期
%             I24_MicLen_47_NumYp = ceil(I24_MPitch_47_NumYd*1.5)      ;     
            
            MicLAr_47_NumXn =  ceil(MLA_47_Diamt           /MPitch_37_NumXd) ;      % MLA中X方向lenslets个数
            MicLAr_47_NumYn =  ceil(MLA_47_Diamt           /MPitch_37_NumYd) ;      % MLA中Y方向lenslets个数
            MicLAr_47_NumXd = (ceil(MicLAr_47_NumXn/2)*2+1)*MPitch_37_NumXd+1;      % MLA直径
            MicLAr_47_NumYd = (ceil(MicLAr_47_NumYn/2)*2+1)*MPitch_37_NumYd+1;      % MLA直径
            MicLAr_47_NumXc =  ceil(MicLAr_47_NumXd/2);                             % MLA中点
            MicLAr_47_NumYc =  ceil(MicLAr_47_NumYd/2);                             % MLA中点
            
        if(Sgn_center==1)                                                           % MLA中心LEN在光轴上
            MicLAr_Al_NumXc =       MicLAr_47_NumXc - floor(MPitch_37_NumXd*0.00);  % MLA中心LEN左边界
            MicLAr_Ar_NumXc =       MicLAr_47_NumXc + ceil( MPitch_37_NumXd*0.00);  % MLA中心LEN右边界
            MicLAr_Au_NumYc =       MicLAr_47_NumYc - floor(MPitch_37_NumYd*0.00);  % MLA中心LEN上边界
            MicLAr_Ad_NumYc =       MicLAr_47_NumYc + ceil( MPitch_37_NumYd*0.00);  % MLA中心LEN下边界
        else                                                                        % MLA中心LEN在光轴外
            MicLAr_Al_NumXc =       MicLAr_47_NumXc - floor(MPitch_37_NumXd*0.50);  % MLA中心LEN左边界
            MicLAr_Ar_NumXc =       MicLAr_47_NumXc + ceil( MPitch_37_NumXd*0.50);  % MLA中心LEN右边界
            MicLAr_Au_NumYc =       MicLAr_47_NumYc - floor(MPitch_37_NumYd*0.50);  % MLA中心LEN上边界
            MicLAr_Ad_NumYc =       MicLAr_47_NumYc + ceil( MPitch_37_NumYd*0.50);  % MLA中心LEN下边界
        end
            MicLen_4A_Xcent = [fliplr(MicLAr_Al_NumXc:-MPitch_37_NumXd:1), MicLAr_Ar_NumXc:MPitch_37_NumXd:MicLAr_47_NumXd];
            MicLen_4A_Ycent = [fliplr(MicLAr_Au_NumYc:-MPitch_37_NumYd:1), MicLAr_Ad_NumYc:MPitch_37_NumYd:MicLAr_47_NumYd];
            MicLAr_48_Centr = zeros( MicLAr_47_NumYd, MicLAr_47_NumXd)    ;
            MicLAr_48_Centr(         MicLen_4A_Ycent, MicLen_4A_Xcent) = 1; % 令各MLA中心点为1
            
        if(Sgn_alluse==0)                                                  % 限定应用的MLA个数
            if(BeamLenratio==0)                                            % 限定应用的MLA个数
                Fourie_49_BeamR = Fou_49_BeamD;
            else
                Fourie_49_BeamR = ceil(   BeamLenratio*Len_37_Pitch);
            end
            MicLen_37_NumRr = floor(( Len_37_NumAd-1)/2);
           [MicLAr_35_Coory, MicLAr_35_Coorx] = meshgrid(1:MicLAr_47_NumXd,1:MicLAr_47_NumXd);
            MicLAr_48_Centr((MicLAr_35_Coorx - MicLAr_47_NumXc).^2 + ...
                            (MicLAr_35_Coory - MicLAr_47_NumXc).^2 > ...
                            (Fourie_49_BeamR - MicLen_37_NumRr).^2) = 0;
        end
    end
    for idxta = 1   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  微透镜阵列pattern1
                                                                           MicLAr_47_DiaRr = (MLA_47_Diamt-1)/2;
            % 产生微透镜阵列pattern
            MicLAr_49_TFunc = conv2( MicLAr_48_Centr, MicLen_30_TFunc,    'same'     );                     figure(490); imshow( uint16( MicLAr_49_TFunc/max(MicLAr_49_TFunc(:)) * 65535) );
            
            % crop微透镜阵列pattern
            MicLAr_4T_TFunc = MicLAr_49_TFunc(...
                              MicLAr_47_NumYc + ( - floor(MicLAr_47_DiaRr) : + ceil(MicLAr_47_DiaRr)),...
                              MicLAr_47_NumXc + ( - floor(MicLAr_47_DiaRr) : + ceil(MicLAr_47_DiaRr)) );	figure(491); imshow( uint16( MicLAr_4T_TFunc/max(MicLAr_4T_TFunc(:)) * 65535) );
    end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    