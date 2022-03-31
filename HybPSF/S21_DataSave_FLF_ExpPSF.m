function [FLF_ExpPSF_Fit_len,FLF_ExpPSF_FitHalf,...
          FLF_ExpPSF_Fit_Dep,FLF_ExpPSF_Fit_Int,...
          FLF_ExpPSF_Rho_dia,FLF_ExpPSF_Sub_Dia,FLF_DnsPSF_Fit] = S21_DataSave_FLF_ExpPSF(...
                                      FLF_ExpPSF_LoadPath,...
                                      FLF_ExpBKG_LoadPath,...
                                      FLF_HybPSF_SavePath,...
                                      FLF_ExpPSF_LoadLable_Ini,...
                                      FLF_ExpPSF_LoadLable_End,...
                                      FLF_ExpPSF_LoadSti,FLF_ExpPSF_LoadStf,...
                                      FLF_ExpPSF_LoadStc,FLF_ExpPSF_LoadStp,...
                                      FLF_Load_Image_bkg,Recons_43_NumEd   ,...
                                      FLF_ExpPSF_range_y,FLF_ExpPSF_range_x,...
                                      Data_01_formIm    ,Data_02_formDt    ,FLF_SubPSF_fit_rad)
%     FLF_ExpPSF_LoadSti = 10000;
%     FLF_ExpPSF_LoadStf = 90000;
%     FLF_ExpPSF_LoadStc = 50000;
%     FLF_ExpPSF_LoadStp = 01000;
%     FLF_Load_Image_bkg = 1;

    for idxsg = 1                                                          % ExpPSF crop and load range         
        FLF_ExpPSF_Rho_dia = length(FLF_ExpPSF_range_x  );
        FLF_ExpPSF_Rho_cen = ceil(  FLF_ExpPSF_Rho_dia/2);
        FLF_ExpPSF_Sub_Dia = round( FLF_ExpPSF_Rho_dia/Recons_43_NumEd);
        
        FLF_ExpPSF_LoadStr = num2str(uint32( FLF_ExpPSF_LoadSti:FLF_ExpPSF_LoadStp:FLF_ExpPSF_LoadStf)','%05d');
        FLF_ExpPSF_Fit_len = length( FLF_ExpPSF_LoadStr)    ;
        FLF_ExpPSF_FitHalf = floor( (FLF_ExpPSF_Fit_len-1)/2);
        FLF_ExpPSF_Fit_Int = -FLF_ExpPSF_FitHalf:FLF_ExpPSF_FitHalf;
        FLF_ExpPSF_Fit_Dep =(-FLF_ExpPSF_FitHalf:FLF_ExpPSF_FitHalf)*FLF_ExpPSF_LoadStp/1000;
        
        FLF_SubPSF_Fit_Int = -FLF_SubPSF_fit_rad:FLF_SubPSF_fit_rad;
    end
                                                                           % ExpPSF load and crop                   
        FLF_ExpPSF_tem = imread([FLF_ExpPSF_LoadPath,'\',FLF_ExpPSF_LoadLable_Ini,FLF_ExpPSF_LoadStr(1 ,:),FLF_ExpPSF_LoadLable_End,'.tif']);
    if (FLF_Load_Image_bkg)
        FLF_ExpBKG_tem = imread([FLF_ExpBKG_LoadPath,'\',FLF_ExpPSF_LoadLable_Ini,FLF_ExpPSF_LoadStr(1 ,:),FLF_ExpPSF_LoadLable_End,'.tif']);
    else
        FLF_ExpBKG_tem = uint16(ones(size(FLF_ExpPSF_tem))*90);
    end
        FLF_DNSPSF_tem = uint16(FLF_ExpPSF_tem - FLF_ExpBKG_tem);
            
        U40_Imshow_Sat(FLF_ExpBKG_tem, 1)
        U40_Imshow_Sat(FLF_ExpBKG_tem(FLF_ExpPSF_range_y,FLF_ExpPSF_range_x), 1)
        U40_Imshow_Sat(FLF_ExpPSF_tem, 10)
        U40_Imshow_Sat(FLF_ExpPSF_tem(FLF_ExpPSF_range_y,FLF_ExpPSF_range_x), 10)
        U40_Imshow_Sat(FLF_DNSPSF_tem, 10)
        U40_Imshow_Sat(FLF_DNSPSF_tem(FLF_ExpPSF_range_y,FLF_ExpPSF_range_x), 10)
        
        FLF_ExpPSF_crp = uint16(zeros(FLF_ExpPSF_Rho_dia,FLF_ExpPSF_Rho_dia,FLF_ExpPSF_Fit_len));
        FLF_ExpBKG_crp = uint16(zeros(FLF_ExpPSF_Rho_dia,FLF_ExpPSF_Rho_dia,FLF_ExpPSF_Fit_len));
%         FLF_DNSPSF_crp = uint16(zeros(FLF_ExpPSF_Rho_dia,FLF_ExpPSF_Rho_dia,FLF_ExpPSF_Fit_len));
    for idxfr = 1:FLF_ExpPSF_Fit_len                                       
        FLF_ExpPSF_org            = imread([FLF_ExpPSF_LoadPath,'\',FLF_ExpPSF_LoadLable_Ini,FLF_ExpPSF_LoadStr(idxfr,:),FLF_ExpPSF_LoadLable_End,'.tif']);
        if (FLF_Load_Image_bkg)
        FLF_ExpBKG_org            = imread([FLF_ExpBKG_LoadPath,'\',FLF_ExpPSF_LoadLable_Ini,FLF_ExpPSF_LoadStr(idxfr,:),FLF_ExpPSF_LoadLable_End,'.tif']);
        FLF_ExpBKG_crp(:,:,idxfr) = FLF_ExpBKG_org(FLF_ExpPSF_range_y,FLF_ExpPSF_range_x);
        end
        FLF_ExpPSF_crp(:,:,idxfr) = FLF_ExpPSF_org(FLF_ExpPSF_range_y,FLF_ExpPSF_range_x);
%         FLF_DNSPSF_org            = uint16(FLF_ExpPSF_org - FLF_ExpBKG_org - 5);
%         FLF_DNSPSF_crp(:,:,idxfr) = FLF_DNSPSF_org(FLF_ExpPSF_range_y,FLF_ExpPSF_range_x);
        disp(idxfr)
    end
        FLF_ExpPSF_Nor = rescale(FLF_ExpPSF_crp);
        if (FLF_Load_Image_bkg)
        FLF_DnsPSF_Nor = rescale(double(FLF_ExpPSF_crp)-repmat(mean(FLF_ExpBKG_crp,3),[1,1,201]));
        U40_Imshow_Sat(mean(FLF_ExpBKG_crp,3),1);
        else
        FLF_ExpBKG_crp = 90;
        FLF_DnsPSF_Nor = rescale(double(FLF_ExpPSF_crp)-FLF_ExpBKG_crp);
        end
    close all;clc
    
    for idxsg = 1                                                          % Center profile save                    
        U40_Imshow_Sat(FLF_ExpPSF_Nor(:,:, ceil(FLF_ExpPSF_Fit_len/2)), 1)
        U40_Imshow_Sat(FLF_DnsPSF_Nor(:,:, ceil(FLF_ExpPSF_Fit_len/2)), 2)
        
        FLF_DnsPSF_cen = FLF_DnsPSF_Nor(FLF_ExpPSF_Rho_cen+FLF_SubPSF_Fit_Int,...
                                        FLF_ExpPSF_Rho_cen+FLF_SubPSF_Fit_Int,...
                                        ceil(FLF_ExpPSF_Fit_len/2));
       [Maxcen_y, Maxcen_x] = ind2sub(size(FLF_DnsPSF_cen),find(FLF_DnsPSF_cen==max(FLF_DnsPSF_cen,[],'all')));
        U40_Imshow_Sat(FLF_DnsPSF_cen,1)
%         Subcen_x = 747;
%         Subcen_y = 750;
        Subcen_x = Maxcen_x+FLF_ExpPSF_Rho_cen-FLF_SubPSF_fit_rad-1;
        Subcen_y = Maxcen_y+FLF_ExpPSF_Rho_cen-FLF_SubPSF_fit_rad-1;
        
        FLF_ExpPSF_cet = squeeze(FLF_ExpPSF_Nor(Subcen_y+FLF_ExpPSF_Fit_Int,Subcen_x,:));
                                                                           U61_Imshow_B16_Hot(FLF_ExpPSF_cet)
        FLF_DnsPSF_cet = squeeze(FLF_DnsPSF_Nor(Subcen_y+FLF_ExpPSF_Fit_Int,Subcen_x,:));
                                                                           U61_Imshow_B16_Hot(FLF_DnsPSF_cet)

    end
    
    for idxsg = 1                                                          % DnsPSF_fit save                        
        FLF_ExpPSF_Sub_rad = floor((FLF_ExpPSF_Sub_Dia-1)/2);    
        FLF_DnsPSFZero = zeros(size(FLF_DnsPSF_Nor));
        for idxxi = 1:Recons_43_NumEd                                      % EXPPSF SubPSF max position located                     
        for idxet = 1:Recons_43_NumEd                                          
            FLF_DnsPSFZero((idxet-1)*FLF_ExpPSF_Sub_Dia + FLF_ExpPSF_Sub_rad + FLF_SubPSF_Fit_Int,...
                           (idxxi-1)*FLF_ExpPSF_Sub_Dia + FLF_ExpPSF_Sub_rad + FLF_SubPSF_Fit_Int,:)=1;
        end
        end
        FLF_DnsPSF_Fit = rescale(FLF_DnsPSF_Nor.*FLF_DnsPSFZero);
        
        Image_MaxP_x = squeeze(max(FLF_DnsPSF_Fit,[],1))';
        Image_MaxP_y = squeeze(max(FLF_DnsPSF_Fit,[],2));
        Image_MaxP_z = squeeze(max(FLF_DnsPSF_Fit,[],3));
        
        Image_size = [size(FLF_DnsPSF_Fit,1),size(FLF_DnsPSF_Fit,2),size(FLF_DnsPSF_Fit,3)];
        Seam__size = ceil(Image_size(1)/30);
    %     Seam__size = 1;
        Maxpr_size = Image_size(3) + Seam__size + Image_size(1);
        Image_MaxP = ones(Maxpr_size,Maxpr_size);
        Image_MaxP( 1:Image_size(1)                              ,                              1:Image_size(2))   = Image_MaxP_z;
        Image_MaxP( 1:Image_size(1)                              ,Image_size(2) + Seam__size + (1:Image_size(3)) ) = Image_MaxP_y;
        Image_MaxP((1:Image_size(3)) + Image_size(1) + Seam__size,                              1:Image_size(2)  ) = Image_MaxP_x;
        
        Image_MaxP_hot = ind2rgb(uint16(Image_MaxP*65535),hot(65535));         figure;imshow(Image_MaxP_hot)
    end
    
    for idxsg = 1                                                          % ExpPSF and DnsPSF save                 
        FLF_ExpPSF_saveDept = ['_',num2str((FLF_ExpPSF_LoadSti-FLF_ExpPSF_LoadStc)/1000,'%+08.3f'),...
                               '_',num2str((FLF_ExpPSF_LoadStf-FLF_ExpPSF_LoadStc)/1000,'%+08.3f')];
        FLF_ExpPSF_saveUniN =  [FLF_HybPSF_SavePath,'\','FLF_ExpPSF',FLF_ExpPSF_saveDept];
        FLF_DnsPSF_saveUniN =  [FLF_HybPSF_SavePath,'\','FLF_DnsPSF',FLF_ExpPSF_saveDept];
        
                     save(     [FLF_ExpPSF_saveUniN,'_','Parameters',Data_02_formDt],'FLF_ExpPSF_Fit_len','FLF_ExpPSF_FitHalf','FLF_ExpPSF_Fit_Int',...
                                                                                     'FLF_ExpPSF_Rho_dia','FLF_ExpPSF_Sub_Dia','-v7.3');
        S65_Imsave_B16_MIP_3D( [FLF_ExpPSF_saveUniN,'_','Nor']      ,Data_01_formIm , FLF_ExpPSF_Nor ,    0  );
                     save(     [FLF_ExpPSF_saveUniN,'_','Nor'       ,Data_02_formDt],'FLF_ExpPSF_Nor','-v7.3');
        S65_Imsave_B16_MIP_3D( [FLF_DnsPSF_saveUniN,'_','Nor']      ,Data_01_formIm , FLF_DnsPSF_Nor ,    0  );
                     save(     [FLF_DnsPSF_saveUniN,'_','Nor'       ,Data_02_formDt],'FLF_DnsPSF_Nor','-v7.3');
        S65_Imsave_B16_MIP_3D( [FLF_DnsPSF_saveUniN,'_','Fit']      ,Data_01_formIm , FLF_DnsPSF_Fit ,    0  );
                       save(   [FLF_DnsPSF_saveUniN,'_','Fit'       ,Data_02_formDt],'FLF_DnsPSF_Fit','-v7.3');
                       
        S61_Imsave_B16_1b1_Col([FLF_ExpPSF_saveUniN,'_','Cet_XZ']   ,Data_01_formIm , FLF_ExpPSF_cet,'hot',0);
        S61_Imsave_B16_1b1_Col([FLF_DnsPSF_saveUniN,'_','Cet_XZ']   ,Data_01_formIm , FLF_DnsPSF_cet,'hot',0);
    end
end

function [] = U40_Imshow_Sat(Image_Data, Sat_Num) 
%Show normalized image   
    figure;    imshow(rescale(double(Image_Data)).*Sat_Num);
end




























