function [] = S21_DataSave_FLF_HySPSF_Image(FLF_HySPSF_saveUniN,FLF_HyRPSF_Nor     ,Data_01_formIm    ,...
                                            FLF_ExpPSF_sub_Ymax,FLF_ExpPSF_sub_Xmax,FLF_ExpPSF_FitHalf,...
                                            Recons_43_NumEd    ,FLF_SubPSF_crp_rad ,FLF_SubPSF_showrat,...
                                            Index_Col,Index_Sat,Index_Rev)
% FLF_SubPSF_showrat = 0.7;
% Index_Col     = 294;
% Index_Sat     = 2;
% Index_Rev     = 0;

% HyRPSF cropped for deeper field                                          

    FLF_SubPSF_crp_cet = FLF_SubPSF_crp_rad*1+1;
    FLF_SubPSF_crp_dia = FLF_SubPSF_crp_rad*2+1;
    FLF_SubPSF_crp_Int =-FLF_SubPSF_crp_rad:FLF_SubPSF_crp_rad;
    
    S65_Imsave_B16_MIP_3D(FLF_HyRPSF_Nor);
    FLF_HySPSF_Nor = zeros(FLF_SubPSF_crp_dia*Recons_43_NumEd,FLF_SubPSF_crp_dia*Recons_43_NumEd,size(FLF_HyRPSF_Nor,3));
%     load([FLF_HyRPSF_saveUniN,'_','Nor' ,Data_02_formDt])
    for idxxi = 1:Recons_43_NumEd                                          % HybPSF generated eleimg by eleimg             
    for idxet = 1:Recons_43_NumEd
        FLF_HySPSF_Nor((idxet-1)*FLF_SubPSF_crp_dia +(1:FLF_SubPSF_crp_dia),     ...
                       (idxxi-1)*FLF_SubPSF_crp_dia +(1:FLF_SubPSF_crp_dia),:) = ...
        FLF_HyRPSF_Nor(FLF_ExpPSF_sub_Ymax(idxet,idxxi,FLF_ExpPSF_FitHalf+1)+FLF_SubPSF_crp_Int ,...
                       FLF_ExpPSF_sub_Xmax(idxet,idxxi,FLF_ExpPSF_FitHalf+1)+FLF_SubPSF_crp_Int ,:);
            disp(['idxet = ',num2str(idxet),', ',...
                  'idxxi = ',num2str(idxxi),', ',]);
    end
    end
        FLF_HySPSF_col = U69_Imshow_B16_3DColC_ColO(FLF_HySPSF_Nor,Index_Col,Index_Sat,Index_Rev);
        figure,imshow(FLF_HySPSF_col)
        
    save_file = [FLF_HySPSF_saveUniN,'_',num2str(FLF_SubPSF_crp_dia,'%d')];mkdir(save_file);
    
    for idxxi = 1:Recons_43_NumEd                                          % HybPSF generated eleimg by eleimg             
    for idxet = 1:Recons_43_NumEd
        imwrite(                                                               ...
        FLF_HySPSF_col((idxet-1)*FLF_SubPSF_crp_dia +(1:FLF_SubPSF_crp_dia),   ...
                       (idxxi-1)*FLF_SubPSF_crp_dia +(1:FLF_SubPSF_crp_dia),:),...
                [save_file,'\',num2str(idxxi),'_',num2str(idxet), Data_01_formIm]);
    end
    end
    
    FLF_SubPSF_showrad = floor((FLF_SubPSF_crp_dia*FLF_SubPSF_showrat-1)/2);    
    FLF_HySPSF_Pad = uint16(ones(size(FLF_HySPSF_col))*65535);
    for idxxi = 1:Recons_43_NumEd                                          % EXPPSF SubPSF max position located                     
    for idxet = 1:Recons_43_NumEd                                          
        FLF_HySPSF_Pad((idxet-1)*FLF_SubPSF_crp_dia + FLF_SubPSF_crp_cet + (-FLF_SubPSF_showrad : FLF_SubPSF_showrad),...
                       (idxxi-1)*FLF_SubPSF_crp_dia + FLF_SubPSF_crp_cet + (-FLF_SubPSF_showrad : FLF_SubPSF_showrad),:)=0;
    end
    end
        figure,imshow( FLF_HySPSF_Pad)
        
        FLF_HySPSF_rgb = FLF_HySPSF_col + FLF_HySPSF_Pad;
        figure,imshow( FLF_HySPSF_rgb)

        
        imwrite(FLF_HySPSF_rgb,[save_file,'\','All', Data_01_formIm]);
end

























